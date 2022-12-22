package com.zhouyp.art;

/**
 * 所有pojo需要有的内容通过这个实现
 */
public class BaseEntity {
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
