package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 
 * @author vdos
 * @version  2018-08-23 15:56:06
 */
@Table(name = "u_member_token")
public class MemberToken implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * member_id
	 */
	private Integer memberId;
	/**
	 * visitor
	 */
	private String visitor;
	/**
	 * token
	 */
	private String token;
	/**
	 * token 类型
	 */
	private Byte type;
	/**
	 * expired_time
	 */
	private LocalDateTime expiredTime;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	public Integer getMemberId() {
		return this.memberId;
	}

	public String getVisitor() {
		return visitor;
	}

	public void setVisitor(String visitor) {
		this.visitor = visitor;
	}

	public void setToken(String token) {
		this.token = StringUtils.trim(token);
	}
	
	public String getToken() {
		return this.token;
	}

	public Byte getType() {
		return type;
	}

	public void setType(Byte type) {
		this.type = type;
	}

	public void setExpiredTime(LocalDateTime expiredTime) {
		this.expiredTime = expiredTime;
	}
	
	public LocalDateTime getExpiredTime() {
		return this.expiredTime;
	}
}
