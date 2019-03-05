package com.yx.vdos.model.resp;

public class MemberInfluence {

    private Integer inviteMember;
    private Integer count;
    private String name;
    private String headerImage;

    public Integer getInviteMember() {
        return inviteMember;
    }

    public void setInviteMember(Integer inviteMember) {
        this.inviteMember = inviteMember;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHeaderImage() {
        return headerImage;
    }

    public void setHeaderImage(String headerImage) {
        this.headerImage = headerImage;
    }
}
