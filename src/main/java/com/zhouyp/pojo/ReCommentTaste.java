package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class ReCommentTaste extends DataEntity<ReCommentTaste> implements Serializable {

	private static final long serialVersionUID =  46341049559536238L;

	private String userId;	/* 用户ID*/
	private String commentId;	/* 评论ID*/
	private Long taste;	/* 喜恶*/

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommentId() {
		return commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}

	public Long getTaste() {
		return taste;
	}

	public void setTaste(Long taste) {
		this.taste = taste;
	}

	@Override
	public String toString() {
		return "ReCommentTaste{" +
				"userId=" + userId+
				"commentId=" + commentId+
				"taste=" + taste+
				"}";
	}
}
