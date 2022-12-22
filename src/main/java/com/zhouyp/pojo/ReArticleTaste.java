package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class ReArticleTaste extends DataEntity<ReArticleTaste> implements Serializable {

	private static final long serialVersionUID =  1078766539114477180L;

	private String userId;	/* 用户ID*/
	private String articleId;	/* 文章ID*/
	private Long taste;	/* 喜恶*/

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public Long getTaste() {
		return taste;
	}

	public void setTaste(Long taste) {
		this.taste = taste;
	}

	@Override
	public String toString() {
		return "ReArticleTaste{" +
				"userId=" + userId+
				"articleId=" + articleId+
				"taste=" + taste+
				"}";
	}
}
