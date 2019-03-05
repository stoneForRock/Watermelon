package com.yx.vdos.model.resp;

import com.yx.vdos.model.entity.Actor;

import java.util.List;

public class ActorDataResp {

    private Integer categoryId;
    private String categoryName;
    private List<Actor> actors;

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

    public List<Actor> getActors() {
        return actors;
    }

    public void setActors(List<Actor> actors) {
        this.actors = actors;
    }
}
