package com.yx.vdos.model.entity;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "v_movie_actor")
public class MovieActor {

    @Id
    private Integer id;

    private Integer movieId;

    private Integer actorId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMovieId() {
        return movieId;
    }

    public void setMovieId(Integer movieId) {
        this.movieId = movieId;
    }

    public Integer getActorId() {
        return actorId;
    }

    public void setActorId(Integer actorId) {
        this.actorId = actorId;
    }
}
