package com.zhouyp.art;

import com.zhouyp.interceptor.PageInterceptor;
import com.zhouyp.pojo.base.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

public abstract class ArtServiceAbstract<D extends ArtDao<T>,T extends DataEntity<T>> implements ArtService<T>{

    @Autowired
    protected D dao;

    @Override
    public T get(String id) {
        return dao.get(id);
    }

    @Override
    public T get(T entity) {
        return dao.get(entity);
    }

    @Override
    public List<T> exist(T entity) {
        return dao.exist(entity);
    }

    @Override
    public List<T> findList(T entity) {
        return dao.findList(entity);
    }

    @Override
    public List<T> findAllList() {
        return dao.findAllList();
    }

    @Override
    public Page<T> findPage(Page<T> page, T entity) {

        PageInterceptor.startPage(page);
        List<T> list = dao.findList(entity);
        Page<T> res = PageInterceptor.endPage();
        res.setResult(list);
        return res;
    }

    @Override
    public void save(T entity) {
        if (entity.getIsNewRecord()) {
            dao.insert(entity);
        } else {
            dao.update(entity);
        }
    }

    @Override
    public void delete(T entity) {
        dao.delete(entity);
    }
}
