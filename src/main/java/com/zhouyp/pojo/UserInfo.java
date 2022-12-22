package com.zhouyp.pojo;

import java.io.Serializable;
import com.zhouyp.art.DataEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-05-19 
 */
public class UserInfo extends DataEntity<UserInfo> implements Serializable {

	private static final long serialVersionUID =  8359100097233018537L;

	private String id;	/* 用户用户信息*/
	private String userName;	/* 用户名*/
	private String pwd;	/* 密码*/
	private Long role;	//
	private String email;	/* 邮箱*/
	private String phoneCode;	/* 电话*/
	private String qq;	/* QQ*/
	private String wechat;	/* 微信*/
	private Long sex;	/* 性别*/
	private Date birthday;	/* 生日*/
	private Long likeCount;	/* 总喜欢*/
	private Long hateCount;	/* 总讨厌*/
	private Long visitCount;	/* 访问量*/
	private Long articleCount;	/* 文章数*/
	private String headPath;	/* 头像*/
	private Date createTime;	/* 注册时间*/
	private Long likeUserCount;	/* 关注数*/
	private Long likedUserCount;	/* 粉丝数*/
	private String intro;	/* 头像*/
	private String inter;	/* 头像*/
	private Boolean attentionFlag; /*关注标志*/

	public UserInfo() {
	}

	public UserInfo(String userName) {
		this.userName = userName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public Long getRole() {
		return role;
	}

	public void setRole(Long role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneCode() {
		return phoneCode;
	}

	public void setPhoneCode(String phoneCode) {
		this.phoneCode = phoneCode;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public Long getSex() {
		return sex;
	}

	public void setSex(Long sex) {
		this.sex = sex;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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

	public Long getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(Long visitCount) {
		this.visitCount = visitCount;
	}

	public Long getArticleCount() {
		return articleCount;
	}

	public void setArticleCount(Long articleCount) {
		this.articleCount = articleCount;
	}

	public String getHeadPath() {
		return headPath;
	}

	public void setHeadPath(String headPath) {
		this.headPath = headPath;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getLikeUserCount() {
		return likeUserCount;
	}

	public void setLikeUserCount(Long likeUserCount) {
		this.likeUserCount = likeUserCount;
	}

	public Long getLikedUserCount() {
		return likedUserCount;
	}

	public void setLikedUserCount(Long likedUserCount) {
		this.likedUserCount = likedUserCount;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getInter() {
		return inter;
	}

	public void setInter(String inter) {
		this.inter = inter;
	}

	public Boolean getAttentionFlag() {
		return attentionFlag;
	}

	public void setAttentionFlag(Boolean attentionFlag) {
		this.attentionFlag = attentionFlag;
	}

	@Override
	public String toString() {
		return "UserInfo{" +
				"id='" + id + '\'' +
				", userName='" + userName + '\'' +
				", pwd='" + pwd + '\'' +
				", role=" + role +
				", email='" + email + '\'' +
				", phoneCode='" + phoneCode + '\'' +
				", qq='" + qq + '\'' +
				", wechat='" + wechat + '\'' +
				", sex=" + sex +
				", birthday=" + birthday +
				", likeCount=" + likeCount +
				", hateCount=" + hateCount +
				", visitCount=" + visitCount +
				", articleCount=" + articleCount +
				", headPath='" + headPath + '\'' +
				", createTime=" + createTime +
				", likeUserCount=" + likeUserCount +
				", likedUserCount=" + likedUserCount +
				", intro='" + intro + '\'' +
				", inter='" + inter + '\'' +
				", attentionFlag=" + attentionFlag +
				'}';
	}
}
