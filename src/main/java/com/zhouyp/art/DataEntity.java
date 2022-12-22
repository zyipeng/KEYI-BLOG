package com.zhouyp.art;

/**
 * 数据库操作实体类需要拥有的内容通过这个类实现
 * @param <T>
 */
public class DataEntity<T> extends BaseEntity {

    private String queryCondition;

    /**
     * 记录数据是否为新数据，左右保存数据操作时判断标志
     */
    private boolean isNewRecord;

    public boolean getIsNewRecord() {
        return isNewRecord || this.getId() == null;
    }

    public void setNewRecord(boolean isnewRecord) {
        this.isNewRecord = isnewRecord;
    }

    public String getQueryCondition() {
        return queryCondition;
    }

    public void setQueryCondition(String queryCondition) {
        this.queryCondition = queryCondition;
    }

}
