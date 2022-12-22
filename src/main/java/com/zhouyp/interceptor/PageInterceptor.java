package com.zhouyp.interceptor;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import com.zhouyp.pojo.base.Page;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.resultset.DefaultResultSetHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;

import java.sql.*;
import java.util.List;
import java.util.Properties;

@Intercepts({
        @Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class, Integer.class}),
        @Signature(type = DefaultResultSetHandler.class, method = "handleResultSets", args = {Statement.class})
})
public class PageInterceptor implements Interceptor {

    private static final Logger logger = LoggerFactory.getLogger(PageInterceptor.class);

    private static final ThreadLocal<Page> local = new ThreadLocal<Page>();

    public static void startPage(int pageNum) {
        local.set(new Page(pageNum));
    }

    public static void startPage(int pageNum, int pageSize) {
        local.set(new Page(pageNum, pageSize));
    }

    public static void startPage(Page page) {
        local.set(page);
    }

    public static Page endPage() {
        Page page = local.get();
        local.remove();
        return page;
    }

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        if (local.get() == null) {
            return invocation.proceed();
        }
        //获取sql，原sql，反射获取
        if (invocation.getTarget() instanceof StatementHandler) {
            StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
            MetaObject metaStatementHandler = SystemMetaObject.forObject(statementHandler);
            //分离代理对象链
            while (!metaStatementHandler.hasGetter("delegate")) {
                Object o = metaStatementHandler.getValue("h");
                metaStatementHandler = SystemMetaObject.forObject(o);
            }
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            //获取分页信息
            Page page = local.get();

            //重构sql，总数sql，分页sql
            String countSql = getCountSql(boundSql.getSql());

            List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
            Object parameterObject = boundSql.getParameterObject();
            //设置参数，针对pojo
            MetaObject metaObject = SystemMetaObject.forObject(parameterObject);
            Class<?> aClass = metaObject.getOriginalObject().getClass();
            boolean primitive = aClass.isPrimitive();
            boolean equals = aClass.equals(String.class);
            if (primitive || equals) {
                countSql = countSql.replace("?", "'" + metaObject.getOriginalObject() + "'");
            }else {
                for (ParameterMapping pm : parameterMappings) {
                    String property = pm.getProperty();
                    String pv = metaObject.getValue(property).toString();
                    countSql = countSql.replaceFirst("\\?", "'" + pv + "'");
                }
            }
//            String pageSql = getPageSql(boundSql, page, (String) metaStatementHandler.getValue(
//                    "delegate.configuration.environment.dataSource.dbType"));
            String pageSql = getPageSql(boundSql, page, "mysql");
            /*没办法了直接写死算了，以前写的插件对mysql不兼容，dataSource中没有dbType参数了，暂时又不会通过properties设置*/

            //总数sql，配置page基本参数信息
            setPageParameter(countSql, page, (Connection) invocation.getArgs()[0]);
            //原sql替换为pageSql
            metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
            return invocation.proceed();
        } else {// if (invocation.getTarget() instanceof ResultSetHandler)
            Object result = invocation.proceed();
            Page page = local.get();
            page.setResult((List) result);
            return result;
        }
    }

    private void setPageParameter(String countSql, Page page, Connection connection) {
        PreparedStatement countStmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        try {
            countStmt = connection.prepareStatement(countSql);
            rs = countStmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Ignore this exception" + e);
        } finally {
            try {
                rs.close();
                countStmt.close();
            } catch (SQLException e) {
                System.out.println("Ignoer this exception" + e);
            }
        }
        page.setTotalRows(totalCount);
    }

    private String getCountSql(String sql) {
        StringBuffer countSql = new StringBuffer("select count(0) from ");
        sql = sql.toLowerCase();
        if (sql.lastIndexOf("order") > sql.lastIndexOf(")")) {
            countSql.append(sql, sql.indexOf("from") + 4, sql.lastIndexOf("order"));
        } else {
            countSql.append(sql.substring(sql.indexOf("from") + 4));
        }
        return countSql.toString();
    }

    private String getPageSql(BoundSql boundSql, Page page, String dbType) throws Exception {
        StringBuffer pageSql = new StringBuffer();
        try {
            if (dbType.equals("oracle")) {
                //改成orcal分页
                pageSql.append("select * from ( " +
                        "select t.*, rownum rn from ( "
                        + boundSql.getSql() + " " +
                        ") t " + "where rownum <= " + page.getStopRow() + "" +
                        ") where rn > " + page.getStartRow());
            } else if (dbType.equals("mysql")) {
                //改成mysql分页
                pageSql.append(boundSql.getSql());
                pageSql.append(" limit " + page.getStartRow() + " , " + page.getPageSize());
            } else {
                logger.error("dbType is unknown ------>" + dbType);
                throw new Exception("dbType is unknown ------>" + dbType);
            }
        } catch (NullPointerException e) {
            logger.error("dbType is null");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageSql.toString();
    }

    @Override
    public Object plugin(Object o) {
        if (o instanceof StatementHandler) {
            return Plugin.wrap(o, this);
        } else {
            return o;
        }
    }

    @Override
    public void setProperties(Properties properties) {
    }

    /**
     * 代入参数值
     *
     * @param ps              PreparedStatement
     * @param mappedStatement MappedStatement
     * @param boundSql        BoundSql
     * @param parameterObject Object
     * @throws SQLException
     */
    private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql,
                               Object parameterObject) throws SQLException {
        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
        parameterHandler.setParameters(ps);
    }
}
