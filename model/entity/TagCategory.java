package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_tag_category")
public class TagCategory implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * name
	 */
	private String name;

	private Integer rank;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setName(String name) {
		this.name = StringUtils.trim(name);
	}
	
	public String getName() {
		return this.name;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}
}

