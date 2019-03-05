package com.yx.vdos.model.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_movie_tag")
public class MovieTag implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * movie_id
	 */
	private Integer movieId;
	/**
	 * tag_id
	 */
	private Integer tagId;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setMovieId(Integer movieId) {
		this.movieId = movieId;
	}
	
	public Integer getMovieId() {
		return this.movieId;
	}
	
	public void setTagId(Integer tagId) {
		this.tagId = tagId;
	}
	
	public Integer getTagId() {
		return this.tagId;
	}
	
}

