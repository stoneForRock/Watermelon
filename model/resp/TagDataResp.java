package com.yx.vdos.model.resp;

import java.util.List;

public class TagDataResp {

    private Integer categoryId;
    private String categoryName;
    private List<TagResp> tags;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<TagResp> getTags() {
        return tags;
    }

    public void setTags(List<TagResp> tags) {
        this.tags = tags;
    }
}
