package com.yx.vdos.model.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * 
 * @authorvdos
 * @version  2018-08-15 17:10:28
 */
@Table(name = "a_article_config")
public class ArticleConfig implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * article_id
	 */
	private Integer articleId;
	/**
	 * title
	 */
	private Integer rank;
	/**
	 * type
	 */
	private Byte type;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	
	public Integer getArticleId() {
		return this.articleId;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

	public void setType(Byte type) {
		this.type = type;
	}
	
	public Byte getType() {
		return this.type;
	}
	
}
