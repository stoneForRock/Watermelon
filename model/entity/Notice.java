package com.yx.vdos.model.entity;

import com.yx.common.validate.SaveValidator;
import com.yx.common.validate.UpdateValidator;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Update;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

@Table(name = "inf_notice")
public class Notice implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	@NotNull(message = "公告信息错误", groups = UpdateValidator.class)
	private Integer id;
	/**
	 * title
	 */
	@NotBlank(message = "公告标题不能为空", groups = {SaveValidator.class, UpdateValidator.class})
	private String title;
	/**
	 * content
	 */
	@NotBlank(message = "公告内容不能为空", groups = {SaveValidator.class, UpdateValidator.class})
	private String content;
	/**
	 * create_time
	 */
	private LocalDateTime createTime;
	/**
	 * update_time
	 */
	private LocalDateTime updateTime;

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
	
	public void setCreateTime(LocalDateTime createTime) {
		this.createTime = createTime;
	}
	
	public LocalDateTime getCreateTime() {
		return this.createTime;
	}

	public LocalDateTime getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(LocalDateTime updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}

