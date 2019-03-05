package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_floor")
public class Floor implements Serializable{

	private static final long serialVersionUID = 8059197751994817865L;

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
	/**
	 * cls_id
	 */
	private Integer clsId;
	/**
	 * nav_id
	 */
	private Integer navId;
	/**
	 * selection_type
	 */
	private Integer selectionType;
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
	
	public void setClsId(Integer clsId) {
		this.clsId = clsId;
	}
	
	public Integer getClsId() {
		return this.clsId;
	}
	
	public void setNavId(Integer navId) {
		this.navId = navId;
	}
	
	public Integer getNavId() {
		return this.navId;
	}
	
	public void setSelectionType(Integer selectionType) {
		this.selectionType = selectionType;
	}
	
	public Integer getSelectionType() {
		return this.selectionType;
	}
	
}

