package com.zhouyp.art;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArtDao<T> {
    /**
     *获取单条数据
     * @param id
     * @return
     */
    public T get(String id);

    /**
     *获取单条数据
     * @param entity
     * @return
     */
    public T get(T entity);

    /**
     *存在
     * @param entity
     * @return
     */
    public List<T> exist(T entity);

    /**
     *查找列表
     * @param entity
     * @return
     */
    public List<T> findList(T entity);

    /**
     * 查询条件语句
     * @param queryCondition
     * @return
     */
    public List<T> findConditionList(@Param("queryCondition") String queryCondition);

    /**
     * 查找全部列表
     * @param entity
     * @return
     */
    public List<T> findAllList(T entity);
    /**
     * 查找全部列表
     * @return
     */
    public List<T> findAllList();

    /**
     * 插入数据
     * @param entity
     * @return
     */
    public int insert(T entity);

    /**
     * 更新数据
     * @param entity
     * @return
     */
    public int update(T entity);

    /**
     * 删除单条数据
     * @param id
     * @return
     */
    public int delete(String id);

    /**
     * 删除数据
     * @param entity
     * @return
     */
    public int delete(T entity);

}
