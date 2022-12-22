package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;
import java.util.Date;
import java.util.List;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-14 
 */
public class CommentInfo extends DataEntity<CommentInfo> implements Serializable {

	private static final long serialVersionUID =  6528870114269579840L;

	private String id;	/* 评论信息ID*/
	private String userId;	/* 用户ID*/
	private String replyUserId;	/* 回复用户ID*/
	private String userName;	/* 用户NAME*/
	private String replyUserName;	/* 回复用户NAME*/
	private String rootId;	/* 根评论ID*/
	private String parId;	/* 父ID*/
	private String articleId;	/* 文章ID*/
	private String headPath;	/* 用户头像*/
	private Long likeCount;	/* 喜欢数*/
	private Long hateCount;	/* 讨厌数*/
	private String content;	/* 内容*/
	private Date createTime;	/* 创建时间*/
	private Long delFlag;	/* 删除标志*/
	private List<CommentInfo> hfList;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReplyUserId() {
		return replyUserId;
	}

	public void setReplyUserId(String replyUserId) {
		this.replyUserId = replyUserId;
	}

	public String getRootId() {
		return rootId;
	}

	public void setRootId(String rootId) {
		this.rootId = rootId;
	}

	public String getParId() {
		return parId;
	}

	public void setParId(String parId) {
		this.parId = parId;
	}

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getHeadPath() {
		return headPath;
	}

	public void setHeadPath(String headPath) {
		this.headPath = headPath;
	}

	public Long getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Long likeCount) {
		this.likeCount = likeCount;
	}

	public Long getHateCount() {
		return hateCount;
	}

	public void setHateCount(Long hateCount) {
		this.hateCount = hateCount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Long delFlag) {
		this.delFlag = delFlag;
	}

	public List<CommentInfo> getHfList() {
		return hfList;
	}

	public void setHfList(List<CommentInfo> hfList) {
		this.hfList = hfList;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getReplyUserName() {
		return replyUserName;
	}

	public void setReplyUserName(String replyUserName) {
		this.replyUserName = replyUserName;
	}

	@Override
	public String toString() {
		return "CommentInfo{" +
				"id='" + id + '\'' +
				", userId='" + userId + '\'' +
				", replyUserId='" + replyUserId + '\'' +
				", userName='" + userName + '\'' +
				", replyUserName='" + replyUserName + '\'' +
				", rootId='" + rootId + '\'' +
				", parId='" + parId + '\'' +
				", articleId='" + articleId + '\'' +
				", headPath='" + headPath + '\'' +
				", likeCount=" + likeCount +
				", hateCount=" + hateCount +
				", content='" + content + '\'' +
				", createTime=" + createTime +
				", delFlag=" + delFlag +
				", hfList=" + hfList +
				'}';
	}
}
