package com.yx.vdos.model.dto;

import java.util.List;

public class MovieDTO {

    private Integer id;
    /**
     * mov_name
     */
    private String movName;
    /**
     * mov_desc
     */
    private String movDesc;
    /**
     * mov_score
     */
    private Float movScore;
    /**
     * play_count
     */
    private Integer playCount;

    private Integer loveCnt;

    private String cover;

    private Integer movCls;

    private String file;

    private Integer loveStatus;

    private Integer isFav;

    private List<RelTagDTO> relTagName;

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

    public String getMovDesc() {
        return movDesc;
    }

    public void setMovDesc(String movDesc) {
        this.movDesc = movDesc;
    }

    public Float getMovScore() {
        return movScore;
    }

    public void setMovScore(Float movScore) {
        this.movScore = movScore;
    }

    public Integer getPlayCount() {
        return playCount;
    }

    public void setPlayCount(Integer playCount) {
        this.playCount = playCount;
    }

    public Integer getLoveCnt() {
        return loveCnt;
    }

    public void setLoveCnt(Integer loveCnt) {
        this.loveCnt = loveCnt;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public Integer getMovCls() {
        return movCls;
    }

    public void setMovCls(Integer movCls) {
        this.movCls = movCls;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public Integer getLoveStatus() {
        return loveStatus;
    }

    public void setLoveStatus(Integer loveStatus) {
        this.loveStatus = loveStatus;
    }

    public Integer getIsFav() {
        return isFav;
    }

    public void setIsFav(Integer isFav) {
        this.isFav = isFav;
    }

    public List<RelTagDTO> getRelTagName() {
        return relTagName;
    }

    public void setRelTagName(List<RelTagDTO> relTagName) {
        this.relTagName = relTagName;
    }
}
