package com.yx.vdos.model.dto;

import java.io.Serializable;
import java.time.LocalDateTime;


public class MemberDTO implements Serializable {

    private static final long serialVersionUID = 5325207945295385676L;

    private Integer id;
    /**
     * phone
     */
    private String phone;
    /**
     * name
     */
    private String name;
    /**
     * sup_user_id
     */
    private Integer supUserId;
    /**
     * gmt_create
     */
    private LocalDateTime gmtCreate;
    /**
     * daily_view_num
     */
    private Integer dailyViewNum;
    /**
     * used_view_num
     */
    private Integer usedViewNum;
    /**
     * daily_download_num
     */
    private Integer dailyDownloadNum;
    /**
     * used_download_num
     */
    private Integer usedDownloadNum;
    /**
     * my_invite_code
     */
    private String myInviteCode;
    /**
     * invite_cnt
     */
    private Integer inviteCnt;
    /**
     * gender
     */
    private Integer gender;

    private Integer level;

    private Integer nextLevelNeed;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSupUserId() {
        return supUserId;
    }

    public void setSupUserId(Integer supUserId) {
        this.supUserId = supUserId;
    }

    public LocalDateTime getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Integer getDailyViewNum() {
        return dailyViewNum;
    }

    public void setDailyViewNum(Integer dailyViewNum) {
        this.dailyViewNum = dailyViewNum;
    }

    public Integer getUsedViewNum() {
        return usedViewNum;
    }

    public void setUsedViewNum(Integer usedViewNum) {
        this.usedViewNum = usedViewNum;
    }

    public Integer getDailyDownloadNum() {
        return dailyDownloadNum;
    }

    public void setDailyDownloadNum(Integer dailyDownloadNum) {
        this.dailyDownloadNum = dailyDownloadNum;
    }

    public Integer getUsedDownloadNum() {
        return usedDownloadNum;
    }

    public void setUsedDownloadNum(Integer usedDownloadNum) {
        this.usedDownloadNum = usedDownloadNum;
    }

    public String getMyInviteCode() {
        return myInviteCode;
    }

    public void setMyInviteCode(String myInviteCode) {
        this.myInviteCode = myInviteCode;
    }

    public Integer getInviteCnt() {
        return inviteCnt;
    }

    public void setInviteCnt(Integer inviteCnt) {
        this.inviteCnt = inviteCnt;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getNextLevelNeed() {
        return nextLevelNeed;
    }

    public void setNextLevelNeed(Integer nextLevelNeed) {
        this.nextLevelNeed = nextLevelNeed;
    }
}
