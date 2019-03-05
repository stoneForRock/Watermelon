package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_column")
public class Column implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * cls
	 */
	private Integer cls;
	/**
	 * mod_name
	 */
	private String modName;
	/**
	 * thumbnail
	 */
	private String thumbnail;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setCls(Integer cls) {
		this.cls = cls;
	}
	
	public Integer getCls() {
		return this.cls;
	}
	
	public void setModName(String modName) {
		this.modName = StringUtils.trim(modName);
	}
	
	public String getModName() {
		return this.modName;
	}
	
	public void setThumbnail(String thumbnail) {
		this.thumbnail = StringUtils.trim(thumbnail);
	}
	
	public String getThumbnail() {
		return this.thumbnail;
	}
	
}

