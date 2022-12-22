package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.ArticleInfoDao;
import com.zhouyp.interceptor.PageInterceptor;
import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.ArticleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleInfoServiceImpl extends ArtServiceAbstract<ArticleInfoDao,ArticleInfo> implements ArticleInfoService {
    @Autowired
    ArticleInfoDao articleInfoDao;
    @Override
    public List<ArticleInfo> findHotList() {
        return dao.findConditionList("order by VISIT_COUNT limit 0 , 10");
    }

    @Override
    public List<ArticleInfo> findHotListByUserId(String userId) {
        return dao.findConditionList("where USER_ID = '"+userId+"'order by VISIT_COUNT limit 0 , 10");
    }

    @Override
    public List<ArticleInfo> findNewListByUserId(String userId) {
        return dao.findConditionList("where USER_ID = '"+userId+"'order by CREATE_TIME limit 0 , 10");
    }

    @Override
    public Long updateCollectArticle(String userId, String articleId) {
        articleInfoDao.updateCollectCount(articleId, 1);
        articleInfoDao.addCollectArticle(userId,articleId);
        ArticleInfo articleInfo = articleInfoDao.get(articleId);
        return articleInfo.getCollectCount();
    }

    @Override
    public Long deleteCollect(String userId, String articleId) {
        articleInfoDao.updateCollectCount(articleId, -1);
        articleInfoDao.delCollect(userId,articleId);
        ArticleInfo articleInfo = articleInfoDao.get(articleId);
        return articleInfo.getCollectCount();
    }

    @Override
    public boolean haveCollect(String userId, String articleId) {
        int flag = articleInfoDao.haveCollect(userId, articleId);
        return flag>0?true:false;
    }

    @Override
    public List<ArticleInfo> collectListByUserId(String userId) {
        return articleInfoDao.collectListByUserId(userId);
    }

    @Override
    public Long updateCommentCount(String articleId) {
        articleInfoDao.updateCommentCount(articleId);
        return articleInfoDao.get(articleId).getCommentCount();
    }

    @Override
    public Page<ArticleInfo> findCollectPage(Page<ArticleInfo> page, String userId) {
        PageInterceptor.startPage(page);
        List<ArticleInfo> list = articleInfoDao.collectListByUserId(userId);
        Page<ArticleInfo> res = PageInterceptor.endPage();
        res.setResult(list);
        return res;
    }

    @Override
    public int updateVisitCount(String artId) {
        return articleInfoDao.updateVisitCount(artId);
    }
}
