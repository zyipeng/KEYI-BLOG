package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.UserCategoryDao;
import com.zhouyp.pojo.CategoryNode;
import com.zhouyp.pojo.ReUserLabel;
import com.zhouyp.pojo.UserCategory;
import com.zhouyp.service.UserCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserCategoryServiceImpl extends ArtServiceAbstract<UserCategoryDao, UserCategory> implements UserCategoryService {

    @Autowired
    UserCategoryDao userCategoryDao;

    @Override
    public List<CategoryNode> findCategoryTreeList(String userId,String requestUrl) {//查询用户目录树列表
        //查询顶级目录列表,userId为当前用户,然后父id为空
        //查询子树列表
        List<CategoryNode> parCategoryList = getChildList(userId,null,requestUrl);
        //将查询出来的结果转换成目录树
        return parCategoryList;
    }

    private List<CategoryNode> getChildList(String userId,String parId,String requestUrl) {
        List<CategoryNode> childList = userCategoryDao.findChildList(userId,parId,requestUrl);
        for (CategoryNode child : childList) {
            List<CategoryNode> nodes = getChildList(userId, child.getId(),requestUrl);
            if (nodes.size() > 0) {
                child.setNodes(nodes);
            }
        }
        return childList;
    }

    public List<UserCategory> findListByUserId(String userId) {
        UserCategory userCategory = new UserCategory();
        userCategory.setUserId(userId);
        return dao.findList(userCategory);
    }

    @Override
    public void delete(UserCategory entity) {//修改删除标志
        entity.setDelFlag(1L);
        dao.update(entity);
    }
}
