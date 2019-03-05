package com.yx.vdos.model.dto;

import java.io.Serializable;

public class RelTagDTO implements Serializable {

    private static final long serialVersionUID = -5331423211484746515L;

    private Integer id;
    private String name;
    private Integer movieId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getMovieId() {
        return movieId;
    }

    public void setMovieId(Integer movieId) {
        this.movieId = movieId;
    }
}
