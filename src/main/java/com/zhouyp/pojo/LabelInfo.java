package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;
import java.util.Date;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class LabelInfo extends DataEntity<LabelInfo> implements Serializable {

	private static final long serialVersionUID =  8237044768538873942L;

	private String id;	/* 标签ID*/
	private String name;	/* 标签名*/
	private String createUserName;	/* 创建人名*/
	private Date createTime;	/* 创建时间*/

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

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "LabelInfo{" +
				"id=" + id+
				"name=" + name+
				"createUserName=" + createUserName+
				"createTime=" + createTime+
				"}";
	}
}
