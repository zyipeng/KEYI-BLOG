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
public class ArticleInfo extends DataEntity<ArticleInfo> implements Serializable {

	private static final long serialVersionUID =  618098066012733437L;

	private String id;	/* 文章ID*/
	private String userId;	/* 用户ID*/
	private String categoryId;	/* 分类ID*/
	private String labelId;
	private String name;	/* 文章名*/
	private String intro;	//
	private String path;	/* 文章路径*/
	private String imgPath;	/* 文章图片*/
	private Long collectCount; /*收藏数*/
	private Long likeCount;	/* 喜欢数*/
	private Long hateCount;	/* 讨厌数*/
	private Long commentCount;	/* 评论数*/
	private Long visitCount;	/* 访问数*/
	private Date createTime;	/* 创建时间*/
	private Date issueTime;	/* 发表时间*/
	private Long hideFlag;	/* 隐藏标志*/
	private Long issueFlag;	/* 发行标志*/
	private Long originalFlag;	/* 原创标志*/
	private Long delFlag;	/* 删除标志*/

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

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getLabelId() {
		return labelId;
	}

	public void setLabelId(String labelId) {
		this.labelId = labelId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public Long getCollectCount() {
		return collectCount;
	}

	public void setCollectCount(Long collectCount) {
		this.collectCount = collectCount;
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

	public Long getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(Long commentCount) {
		this.commentCount = commentCount;
	}

	public Long getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(Long visitCount) {
		this.visitCount = visitCount;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getIssueTime() {
		return issueTime;
	}

	public void setIssueTime(Date issueTime) {
		this.issueTime = issueTime;
	}

	public Long getHideFlag() {
		return hideFlag;
	}

	public void setHideFlag(Long hideFlag) {
		this.hideFlag = hideFlag;
	}

	public Long getIssueFlag() {
		return issueFlag;
	}

	public void setIssueFlag(Long issueFlag) {
		this.issueFlag = issueFlag;
	}

	public Long getOriginalFlag() {
		return originalFlag;
	}

	public void setOriginalFlag(Long originalFlag) {
		this.originalFlag = originalFlag;
	}

	public Long getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Long delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return "ArticleInfo{" +
				"id='" + id + '\'' +
				", userId='" + userId + '\'' +
				", categoryId='" + categoryId + '\'' +
				", labelId='" + labelId + '\'' +
				", name='" + name + '\'' +
				", intro='" + intro + '\'' +
				", path='" + path + '\'' +
				", imgPath='" + imgPath + '\'' +
				", collectCount=" + collectCount +
				", likeCount=" + likeCount +
				", hateCount=" + hateCount +
				", commentCount=" + commentCount +
				", visitCount=" + visitCount +
				", createTime=" + createTime +
				", issueTime=" + issueTime +
				", hideFlag=" + hideFlag +
				", issueFlag=" + issueFlag +
				", originalFlag=" + originalFlag +
				", delFlag=" + delFlag +
				'}';
	}
}
