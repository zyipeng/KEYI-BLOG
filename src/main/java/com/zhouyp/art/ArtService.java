package com.zhouyp.art;

import com.zhouyp.pojo.base.Page;

import java.util.List;

public interface ArtService<T extends DataEntity<T>> {

    /**
     * 查找单条数据
     * @param id
     * @return
     */
    public T get(String id);

    /**
     * 查找单条数据
     * @param entity
     * @return
     */
    public T get(T entity);
    /**
     * 存在
     * @param entity
     * @return
     */
    public List<T> exist(T entity);

    /**
     * 查找列表数据
     * @param entity
     * @return
     */
    public List<T> findList(T entity);

    /**
     * 查找列表数据
     * @param
     * @return
     */
    public List<T> findAllList();

    /**
     * 查找页面数据
     * @param page
     * @param entity
     * @return
     */
    public Page<T> findPage(Page<T> page, T entity);

    /**
     * 保存数据（插入/更新）
     * @param entity
     */
    public void save(T entity);

    /**
     * 删除数据
     * @param entity
     */
    public void delete(T entity);
}
