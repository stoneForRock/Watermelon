package com.yx.vdos.model.dto;

import java.io.Serializable;
import java.util.List;

public class ColumnNavDTO implements Serializable{

	private static final long serialVersionUID = -5711655876541528420L;

	private Integer id;
	private Integer cls;
	private String modName;
	private String thumbnail;
	private List<Nav> subclass;

	public static class Nav implements Serializable {

		private static final long serialVersionUID = 4301521040725275268L;

		private Integer id;
		private Integer navCls;
		private String intro;
		private String navName;
		private String navImage;
		private String cover;
		private String navLink;

		public Integer getId() {
			return id;
		}

		public void setId(Integer id) {
			this.id = id;
		}

		public Integer getNavCls() {
			return navCls;
		}

		public void setNavCls(Integer navCls) {
			this.navCls = navCls;
		}

		public String getIntro() {
			return intro;
		}

		public void setIntro(String intro) {
			this.intro = intro;
		}

		public String getNavName() {
			return navName;
		}

		public void setNavName(String navName) {
			this.navName = navName;
		}

		public String getNavImage() {
			return navImage;
		}

		public void setNavImage(String navImage) {
			this.navImage = navImage;
		}

		public String getCover() {
			return cover;
		}

		public void setCover(String cover) {
			this.cover = cover;
		}

		public String getNavLink() {
			return navLink;
		}

		public void setNavLink(String navLink) {
			this.navLink = navLink;
		}
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCls() {
		return cls;
	}

	public void setCls(Integer cls) {
		this.cls = cls;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public List<Nav> getSubclass() {
		return subclass;
	}

	public void setSubclass(List<Nav> subclass) {
		this.subclass = subclass;
	}
}

