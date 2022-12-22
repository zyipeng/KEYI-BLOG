package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.CategoryNode;
import com.zhouyp.pojo.UserCategory;

import java.util.List;

public interface UserCategoryService extends ArtService<UserCategory> {
    /**
     * 获取目录树
     * text节点文本==》目录名
     * href节点url（enableLInks）==》查找分类文章列表
     * [
     *        {
     * 		text:"目录命"，
     * 		href:"获取分类文章列表"
     * 		nodes：[子目录树]
     *    }，
     *    {其它节点},...
     * ]
     * @param userId
     * @return
     */
    List<CategoryNode> findCategoryTreeList(String userId,String requestUrl);

    /**
     * 获取用户分类列表
     * @param userId
     * @return
     */
    public List<UserCategory> findListByUserId(String userId);
}
