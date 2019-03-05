package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

@Table(name = "v_column_nav")
public class ColumnNav implements Serializable{
	
	//columns START
	/**
	 * nav_id
	 */
	@Id
	private Integer id;
	/**
	 * nav_cls
	 */
	private Integer navCls;
	/**
	 * intro
	 */
	private String intro;
	/**
	 * nav_name
	 */
	private String navName;
	/**
	 * nav_image
	 */
	private String navImage;

	private String cover;
	/**
	 * nav_link
	 */
	private String navLink;
	/**
	 * last_update_time
	 */
	private LocalDateTime lastUpdateTime;

	private Integer columnId;

	private Integer rank;
	//columns END 数据库字段结束
	
	//get and set
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setNavCls(Integer navCls) {
		this.navCls = navCls;
	}
	
	public Integer getNavCls() {
		return this.navCls;
	}
	
	public void setIntro(String intro) {
		this.intro = StringUtils.trim(intro);
	}
	
	public String getIntro() {
		return this.intro;
	}
	
	public void setNavName(String navName) {
		this.navName = StringUtils.trim(navName);
	}
	
	public String getNavName() {
		return this.navName;
	}
	
	public void setNavImage(String navImage) {
		this.navImage = StringUtils.trim(navImage);
	}
	
	public String getNavImage() {
		return this.navImage;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public void setNavLink(String navLink) {
		this.navLink = StringUtils.trim(navLink);
	}
	
	public String getNavLink() {
		return this.navLink;
	}
	
	public void setLastUpdateTime(LocalDateTime lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	
	public LocalDateTime getLastUpdateTime() {
		return this.lastUpdateTime;
	}

	public Integer getColumnId() {
		return columnId;
	}

	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}
}

