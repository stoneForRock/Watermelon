package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

@Table(name = "u_member")
public class Member implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * phone
	 */
	private String phone;
	/**
	 * password
	 */
	private String password;
	/**
	 * salt
	 */
	private String salt;
	/**
	 * name
	 */
	private String name;
	/**
	 * sup_user_id
	 */
	private Integer supUserId;
	/**
	 * gmt_create
	 */
	private LocalDateTime gmtCreate;
	/**
	 * daily_view_num
	 */
	private Integer dailyViewNum;
	/**
	 * used_view_num
	 */
	private Integer usedViewNum;
	/**
	 * daily_download_num
	 */
	private Integer dailyDownloadNum;
	/**
	 * used_download_num
	 */
	private Integer usedDownloadNum;
	/**
	 * my_invite_code
	 */
	private String myInviteCode;
	/**
	 * last_login
	 */
	private LocalDateTime lastLogin;
	/**
	 * visitor
	 */
	private String visitor;
	/**
	 * invite_cnt
	 */
	private Integer inviteCnt;
	/**
	 * gender
	 */
	private Integer gender;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setPhone(String phone) {
		this.phone = StringUtils.trim(phone);
	}
	
	public String getPhone() {
		return this.phone;
	}
	
	public void setPassword(String password) {
		this.password = StringUtils.trim(password);
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public void setSalt(String salt) {
		this.salt = StringUtils.trim(salt);
	}
	
	public String getSalt() {
		return this.salt;
	}
	
	public void setName(String name) {
		this.name = StringUtils.trim(name);
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setSupUserId(Integer supUserId) {
		this.supUserId = supUserId;
	}
	
	public Integer getSupUserId() {
		return this.supUserId;
	}
	
	public void setGmtCreate(LocalDateTime gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	
	public LocalDateTime getGmtCreate() {
		return this.gmtCreate;
	}
	
	public void setDailyViewNum(Integer dailyViewNum) {
		this.dailyViewNum = dailyViewNum;
	}
	
	public Integer getDailyViewNum() {
		return this.dailyViewNum;
	}
	
	public void setUsedViewNum(Integer usedViewNum) {
		this.usedViewNum = usedViewNum;
	}
	
	public Integer getUsedViewNum() {
		return this.usedViewNum;
	}
	
	public void setDailyDownloadNum(Integer dailyDownloadNum) {
		this.dailyDownloadNum = dailyDownloadNum;
	}
	
	public Integer getDailyDownloadNum() {
		return this.dailyDownloadNum;
	}
	
	public void setUsedDownloadNum(Integer usedDownloadNum) {
		this.usedDownloadNum = usedDownloadNum;
	}
	
	public Integer getUsedDownloadNum() {
		return this.usedDownloadNum;
	}
	
	public void setMyInviteCode(String myInviteCode) {
		this.myInviteCode = StringUtils.trim(myInviteCode);
	}
	
	public String getMyInviteCode() {
		return this.myInviteCode;
	}
	
	public void setLastLogin(LocalDateTime lastLogin) {
		this.lastLogin = lastLogin;
	}
	
	public LocalDateTime getLastLogin() {
		return this.lastLogin;
	}
	
	public void setVisitor(String visitor) {
		this.visitor = StringUtils.trim(visitor);
	}
	
	public String getVisitor() {
		return this.visitor;
	}
	
	public void setInviteCnt(Integer inviteCnt) {
		this.inviteCnt = inviteCnt;
	}
	
	public Integer getInviteCnt() {
		return this.inviteCnt;
	}
	
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	
	public Integer getGender() {
		return this.gender;
	}
	
}

