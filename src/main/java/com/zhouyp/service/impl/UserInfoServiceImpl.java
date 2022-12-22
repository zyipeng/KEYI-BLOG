package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.UserInfoDao;
import com.zhouyp.interceptor.PageInterceptor;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserInfoServiceImpl extends ArtServiceAbstract<UserInfoDao,UserInfo> implements UserInfoService {
    @Autowired
    UserInfoDao userInfoDao;
    @Override
    public List<UserInfo> findHotList() {
        return dao.findConditionList("order by VISIT_COUNT limit 0 , 10");
    }

    @Override
    public boolean haveAttention(String userId,String attentionId) {
        int i = userInfoDao.haveAttention(userId, attentionId);
        return i>0;
    }

    @Override
    public Long addAttention(String userId, String attentionId) {
        //更新关注列表
        userInfoDao.addAttentionUser(userId, attentionId);
        //更新关注数
        userInfoDao.updateAttentionCount(userId, 1);
        //更新粉丝数
        userInfoDao.updateFansCount(attentionId, 1);
        //返回关注数
        return userInfoDao.get(userId).getLikeUserCount();
    }

    @Override
    public Long deleteAttention(String userId, String attentionId) {
        //更新关注列表
        userInfoDao.delAttentionUser(userId, attentionId);
        //更新关注数
        userInfoDao.updateAttentionCount(userId, -1);
        //更新粉丝数
        userInfoDao.updateFansCount(attentionId, -1);
        //返回关注数
        return userInfoDao.get(userId).getLikeUserCount();
    }

    @Override
    public List<UserInfo> findFansList(String userId) {
        return userInfoDao.fansListByUserId(userId);
    }

    @Override
    public Page<UserInfo> findFansPage(Page<UserInfo> page, String userId) {
        PageInterceptor.startPage(page);
        List<UserInfo> list = userInfoDao.fansListByUserId(userId);
        Page<UserInfo> res = PageInterceptor.endPage();
        res.setResult(list);
        return res;
    }

    @Override
    public List<UserInfo> findAttentionList(String userId) {
        return userInfoDao.attentionListByUserId(userId);
    }

    @Override
    public Page<UserInfo> findAttentionPage(Page<UserInfo> page, String userId) {
        PageInterceptor.startPage(page);
        List<UserInfo> list = userInfoDao.attentionListByUserId(userId);
        Page<UserInfo> res = PageInterceptor.endPage();
        res.setResult(list);
        return res;
    }

    @Override
    public int updateVisitCount(String userId) {
        return userInfoDao.updateVisitCount(userId);
    }
}
