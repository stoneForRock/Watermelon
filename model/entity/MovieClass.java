package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_movie_class")
public class MovieClass implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * cls_name
	 */
	private String clsName;
	/**
	 * cls_icon
	 */
	private String clsIcon;
	/**
	 * deleted
	 */
	private Integer deleted;
	/**
	 * rank
	 */
	private Integer rank;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setClsName(String clsName) {
		this.clsName = StringUtils.trim(clsName);
	}
	
	public String getClsName() {
		return this.clsName;
	}
	
	public void setClsIcon(String clsIcon) {
		this.clsIcon = StringUtils.trim(clsIcon);
	}
	
	public String getClsIcon() {
		return this.clsIcon;
	}
	
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	
	public Integer getDeleted() {
		return this.deleted;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}
}

