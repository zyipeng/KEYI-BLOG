package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.base.Page;

import java.util.List;

public interface ArticleInfoService extends ArtService<ArticleInfo> {
    List<ArticleInfo> findHotList();
    List<ArticleInfo> findHotListByUserId(String userId);
    List<ArticleInfo> findNewListByUserId(String userId);
    Long updateCollectArticle(String userId, String articleId);
    Long deleteCollect(String userId, String articleId);
    boolean haveCollect(String userId,String articleId);
    List<ArticleInfo> collectListByUserId(String userId);
    Long updateCommentCount(String articleId);
    Page<ArticleInfo> findCollectPage(Page<ArticleInfo> page,String userId);
    int updateVisitCount(String artId);
}
