package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class ReUserLabel extends DataEntity<ReUserLabel> implements Serializable {

	private static final long serialVersionUID =  1256203595657562207L;

	private String userId;	/* 用户ID*/
	private String labelId;	/* 标签ID*/
	private String labelName;	/* 标签名*/

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
		return "ReUserLabel{" +
				"userId=" + userId+
				"labelId=" + labelId+
				"labelName=" + labelName+
				"}";
	}
}
