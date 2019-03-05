package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 
 * @authorvdos
 * @version  2018-08-13 15:42:10
 */
@Table(name = "a_article")
public class Article implements Serializable{

	private static final long serialVersionUID = -1149974492515632281L;

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
	 * author
	 */
	private String author;
	/**
	 * cover
	 */
	private String cover;
	/**
	 * content
	 */
	private String content;
	/**
	 * create_time
	 */
	private LocalDateTime createTime;
	/**
	 * status
	 */
	private Byte status;

	private Integer likeCount;

	private Integer readCount;

	private Integer columnId;

	private Byte recommendFlag;
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
	
	public void setAuthor(String author) {
		this.author = StringUtils.trim(author);
	}
	
	public String getAuthor() {
		return this.author;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
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

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public Integer getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Integer likeCount) {
		this.likeCount = likeCount;
	}

	public Integer getReadCount() {
		return readCount;
	}

	public void setReadCount(Integer readCount) {
		this.readCount = readCount;
	}

	public Integer getColumnId() {
		return columnId;
	}

	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	public Byte getRecommendFlag() {
		return recommendFlag;
	}

	public void setRecommendFlag(Byte recommendFlag) {
		this.recommendFlag = recommendFlag;
	}
}
