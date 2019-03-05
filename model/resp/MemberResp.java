package com.yx.vdos.model.resp;

import com.yx.vdos.model.entity.Member;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class MemberResp extends Member {

    private Integer readPlanId;
    private Byte started;
    private Byte finished;
    private LocalDateTime joinTime;
    private LocalDate startTime;
    private String name;
    private String mobile;
    private Integer paied;
    private Integer price;

    public Integer getReadPlanId() {
        return readPlanId;
    }

    public void setReadPlanId(Integer readPlanId) {
        this.readPlanId = readPlanId;
    }

    public Byte getStarted() {
        return started;
    }

    public void setStarted(Byte started) {
        this.started = started;
    }

    public Byte getFinished() {
        return finished;
    }

    public void setFinished(Byte finished) {
        this.finished = finished;
    }

    public LocalDateTime getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(LocalDateTime joinTime) {
        this.joinTime = joinTime;
    }

    public LocalDate getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDate startTime) {
        this.startTime = startTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getPaied() {
        return paied;
    }

    public void setPaied(Integer paied) {
        this.paied = paied;
    }

    public Integer getPrice() {
        return price == null ? 0 : price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }
}
