package com.zhouyp.dao;

import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.ArticleInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleInfoDao extends ArtDao<ArticleInfo> {

    int addCollectArticle(@Param("userId") String userId, @Param("articleId") String articleId);

    int delCollect(@Param("userId") String userId, @Param("articleId") String articleId);

    List<ArticleInfo> collectListByUserId(String userId);

    int haveCollect(@Param("userId") String userId, @Param("articleId") String articleId);

    int updateCollectCount(@Param("articleId") String articleId,@Param("i") int i);

    int updateCommentCount(String articleId);

    int updateVisitCount(String articleId);
}

