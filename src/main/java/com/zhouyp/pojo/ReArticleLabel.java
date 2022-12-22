package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class ReArticleLabel extends DataEntity<ReArticleLabel> implements Serializable {

	private static final long serialVersionUID =  4661531253385350151L;

	private String articleId;	/* 文章ID*/
	private String labelId;	/* 标签ID*/
	private String labelName;	/* 标签名*/

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getLabelId() {
		return labelId;
	}

	public void setLabelId(String labelId) {
		this.labelId = labelId;
	}

	public String getLabelName() {
		return labelName;
	}

	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

	@Override
	public String toString() {
		return "ReArticleLabel{" +
				"articleId=" + articleId+
				"labelId=" + labelId+
				"labelName=" + labelName+
				"}";
	}
}
