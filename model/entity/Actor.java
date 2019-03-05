package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_actor")
public class Actor implements Serializable{
	
	//columns START
	/**
	 * actor_id
	 */
	@Id
	private Integer id;
	/**
	 * brief_introduction
	 */
	private String briefIntroduction;
	/**
	 * name_cn
	 */
	private String nameCn;
	/**
	 * name_en
	 */
	private String nameEn;
	/**
	 * name_jpn
	 */
	private String nameJpn;
	/**
	 * name_ko
	 */
	private String nameKo;
	/**
	 * photo_url
	 */
	private String photoUrl;
	/**
	 * videos_count
	 */
	private Integer videosCount;
	/**
	 * category_id
	 */
	private Integer categoryId;

	private String ext1;
	private String ext2;
	private String ext3;

	private Integer deleted;

	private Integer hot;
	//columns END 数据库字段结束
	
	//get and set


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setBriefIntroduction(String briefIntroduction) {
		this.briefIntroduction = StringUtils.trim(briefIntroduction);
	}
	
	public String getBriefIntroduction() {
		return this.briefIntroduction;
	}
	
	public void setNameCn(String nameCn) {
		this.nameCn = StringUtils.trim(nameCn);
	}
	
	public String getNameCn() {
		return this.nameCn;
	}
	
	public void setNameEn(String nameEn) {
		this.nameEn = StringUtils.trim(nameEn);
	}
	
	public String getNameEn() {
		return this.nameEn;
	}
	
	public void setNameJpn(String nameJpn) {
		this.nameJpn = StringUtils.trim(nameJpn);
	}
	
	public String getNameJpn() {
		return this.nameJpn;
	}

	public String getNameKo() {
		return nameKo;
	}

	public void setNameKo(String nameKo) {
		this.nameKo = nameKo;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = StringUtils.trim(photoUrl);
	}
	
	public String getPhotoUrl() {
		return this.photoUrl;
	}
	
	public void setVideosCount(Integer videosCount) {
		this.videosCount = videosCount;
	}
	
	public Integer getVideosCount() {
		return this.videosCount;
	}
	
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	
	public Integer getCategoryId() {
		return this.categoryId;
	}

	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}

	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public String getExt3() {
		return ext3;
	}

	public void setExt3(String ext3) {
		this.ext3 = ext3;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public Integer getHot() {
		return hot;
	}

	public void setHot(Integer hot) {
		this.hot = hot;
	}
}

