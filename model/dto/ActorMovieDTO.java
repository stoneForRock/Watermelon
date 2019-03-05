package com.yx.vdos.model.dto;

import java.util.List;

public class ActorMovieDTO {

    private Integer id;
    private String briefIntroduction;
    private String nameCn;
    private String nameEn;
    private String nameJpn;
    private String nameKo;
    private String photoUrl;
    private Integer videosCount;
    private List<MovieDTO> movies;

    public static class MovieDTO {

        private Integer id;
        private String movName;
        private Float movScore;
        private String cover;

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getMovName() {
            return movName;
        }

        public void setMovName(String movName) {
            this.movName = movName;
        }

        public Float getMovScore() {
            return movScore;
        }

        public void setMovScore(Float movScore) {
            this.movScore = movScore;
        }

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBriefIntroduction() {
        return briefIntroduction;
    }

    public void setBriefIntroduction(String briefIntroduction) {
        this.briefIntroduction = briefIntroduction;
    }

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public String getNameJpn() {
        return nameJpn;
    }

    public void setNameJpn(String nameJpn) {
        this.nameJpn = nameJpn;
    }

    public String getNameKo() {
        return nameKo;
    }

    public void setNameKo(String nameKo) {
        this.nameKo = nameKo;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public Integer getVideosCount() {
        return videosCount;
    }

    public void setVideosCount(Integer videosCount) {
        this.videosCount = videosCount;
    }

    public List<MovieDTO> getMovies() {
        return movies;
    }

    public void setMovies(List<MovieDTO> movies) {
        this.movies = movies;
    }
}
