package com.yx.vdos.model.entity;

import org.apache.commons.lang3.StringUtils;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_ad")
public class Ad implements Serializable{
	
	//columns START
	/**
	 * id
	 */
	@Id
	private Integer id;
	/**
	 * ad_name
	 */
	private String adName;
	/**
	 * thumbnail
	 */
	private String thumbnail;
	/**
	 * show_order
	 */
	private Integer showOrder;
	/**
	 * link_addr
	 */
	private String linkAddr;
	/**
	 * link_type
	 */
	private Integer linkType;
	/**
	 * show_location
	 */
	private Integer showLocation;
	/**
	 * ad_show_time
	 */
	private Integer adShowTime;
	/**
	 * link_type_cn
	 */
	private String linkTypeCn;
	/**
	 * show_location_cn
	 */
	private String showLocationCn;
	/**
	 * equi_cls
	 */
	private String equiCls;
	/**
	 * equi_cls_cn
	 */
	private String equiClsCn;
	/**
	 * state
	 */
	private Integer state;
	/**
	 * channel_type
	 */
	private Integer channelType;
	/**
	 * click_count
	 */
	private Integer clickCount;
	//columns END 数据库字段结束
	
	//get and set
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getId() {
		return this.id;
	}
	
	public void setAdName(String adName) {
		this.adName = StringUtils.trim(adName);
	}
	
	public String getAdName() {
		return this.adName;
	}
	
	public void setThumbnail(String thumbnail) {
		this.thumbnail = StringUtils.trim(thumbnail);
	}
	
	public String getThumbnail() {
		return this.thumbnail;
	}
	
	public void setShowOrder(Integer showOrder) {
		this.showOrder = showOrder;
	}
	
	public Integer getShowOrder() {
		return this.showOrder;
	}
	
	public void setLinkAddr(String linkAddr) {
		this.linkAddr = StringUtils.trim(linkAddr);
	}
	
	public String getLinkAddr() {
		return this.linkAddr;
	}
	
	public void setLinkType(Integer linkType) {
		this.linkType = linkType;
	}
	
	public Integer getLinkType() {
		return this.linkType;
	}
	
	public void setShowLocation(Integer showLocation) {
		this.showLocation = showLocation;
	}
	
	public Integer getShowLocation() {
		return this.showLocation;
	}
	
	public void setAdShowTime(Integer adShowTime) {
		this.adShowTime = adShowTime;
	}
	
	public Integer getAdShowTime() {
		return this.adShowTime;
	}
	
	public void setLinkTypeCn(String linkTypeCn) {
		this.linkTypeCn = StringUtils.trim(linkTypeCn);
	}
	
	public String getLinkTypeCn() {
		return this.linkTypeCn;
	}
	
	public void setShowLocationCn(String showLocationCn) {
		this.showLocationCn = StringUtils.trim(showLocationCn);
	}
	
	public String getShowLocationCn() {
		return this.showLocationCn;
	}
	
	public void setEquiCls(String equiCls) {
		this.equiCls = StringUtils.trim(equiCls);
	}
	
	public String getEquiCls() {
		return this.equiCls;
	}
	
	public void setEquiClsCn(String equiClsCn) {
		this.equiClsCn = StringUtils.trim(equiClsCn);
	}
	
	public String getEquiClsCn() {
		return this.equiClsCn;
	}
	
	public void setState(Integer state) {
		this.state = state;
	}
	
	public Integer getState() {
		return this.state;
	}
	
	public void setChannelType(Integer channelType) {
		this.channelType = channelType;
	}
	
	public Integer getChannelType() {
		return this.channelType;
	}

	public Integer getClickCount() {
		return clickCount;
	}

	public void setClickCount(Integer clickCount) {
		this.clickCount = clickCount;
	}
}

