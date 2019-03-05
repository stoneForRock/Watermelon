package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "inf_promotion_config")
public class PromotionConfig implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * title
	 */
	private String title;
	/**
	 * content
	 */
	private String content;
	/**
	 * type
	 */
	private Integer type;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setTitle(String title) {
		this.title = StringUtils.trim(title);
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public void setContent(String content) {
		this.content = StringUtils.trim(content);
	}
	
	public String getContent() {
		return this.content;
	}
	
	public void setType(Integer type) {
		this.type = type;
	}
	
	public Integer getType() {
		return this.type;
	}
	
}

