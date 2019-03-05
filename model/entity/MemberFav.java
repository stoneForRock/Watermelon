package com.yx.vdos.model.entity;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name = "v_member_fav")
public class MemberFav implements Serializable {

    private static final long serialVersionUID = -7067225760125948368L;

    @Id
    private Integer id;
    private Integer memberId;
    private Integer movieId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public Integer getMovieId() {
        return movieId;
    }

    public void setMovieId(Integer movieId) {
        this.movieId = movieId;
    }

}
