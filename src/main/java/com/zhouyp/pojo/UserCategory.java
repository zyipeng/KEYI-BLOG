package com.zhouyp.pojo;

import java.io.Serializable;
import java.util.List;

import com.zhouyp.art.DataEntity;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class UserCategory extends DataEntity<UserCategory> implements Serializable {

//	private static final long serialVersionUID =  8802658229304963L;

	private String id;	/* 用户分类ID*/
	private String name;	/* 分类名*/
	private String userId;	/* 用户ID*/
	private String parId;	/* 父分类ID*/
	private Long delFlag;	/* 删除标志*/
	private List<UserCategory> childs;

	public List<UserCategory> getChilds() {
		return childs;
	}

	public void setChilds(List<UserCategory> childs) {
		this.childs = childs;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getParId() {
		return parId;
	}

	public void setParId(String parId) {
		this.parId = parId;
	}

	public Long getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Long delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return "UserCategory{" +
				"id=" + id+
				"name=" + name+
				"userId=" + userId+
				"parId=" + parId+
				"delFlag=" + delFlag+
				"}";
	}
}
