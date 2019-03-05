package com.yx.vdos.model.resp;

import com.yx.vdos.model.entity.Tag;

public class TagResp extends Tag {

    private String category;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
