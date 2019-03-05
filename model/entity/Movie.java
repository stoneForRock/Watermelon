package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

@Table(name = "v_movie")
public class Movie implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * mov_name
	 */
	private String movName;
	/**
	 * mov_desc
	 */
	private String movDesc;
	/**
	 * mov_score
	 */
	private Float movScore;
	/**
	 * play_count
	 */
	private Integer playCount;

	private Integer loveCnt;
	/**
	 * create_time
	 */
	private LocalDateTime createTime;
	/**
	 * update_time
	 */
	private LocalDateTime updateTime;

	private String cover;

	private Integer movCls;

	private String file;

	private Integer status;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setMovName(String movName) {
		this.movName = StringUtils.trim(movName);
	}
	
	public String getMovName() {
		return this.movName;
	}
	
	public void setMovScore(Float movScore) {
		this.movScore = movScore;
	}
	
	public Float getMovScore() {
		return this.movScore;
	}
	
	public void setMovDesc(String movDesc) {
		this.movDesc = StringUtils.trim(movDesc);
	}
	
	public String getMovDesc() {
		return this.movDesc;
	}
	
	public void setPlayCount(Integer playCount) {
		this.playCount = playCount;
	}
	
	public Integer getPlayCount() {
		return this.playCount;
	}

	public Integer getLoveCnt() {
		return loveCnt;
	}

	public void setLoveCnt(Integer loveCnt) {
		this.loveCnt = loveCnt;
	}

	public void setCreateTime(LocalDateTime createTime) {
		this.createTime = createTime;
	}
	
	public LocalDateTime getCreateTime() {
		return this.createTime;
	}
	
	public void setUpdateTime(LocalDateTime updateTime) {
		this.updateTime = updateTime;
	}
	
	public LocalDateTime getUpdateTime() {
		return this.updateTime;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public Integer getMovCls() {
		return movCls;
	}

	public void setMovCls(Integer movCls) {
		this.movCls = movCls;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}

