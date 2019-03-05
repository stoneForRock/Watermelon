package com.yx.vdos.model.resp;

import com.yx.core.model.common.NameID;
import com.yx.vdos.model.entity.Movie;

import java.util.List;

public class EditMovieResp extends Movie {

    private static final long serialVersionUID = 7072431042900206183L;

    private List<RelActor> relActors;
    private List<RelTag> relTags;

    public static class RelActor extends NameID {
        private static final long serialVersionUID = -1689727948224742325L;
    }

    public static class RelTag extends NameID {
        private static final long serialVersionUID = -3908396899364606870L;
    }

    public List<RelActor> getRelActors() {
        return relActors;
    }

    public void setRelActors(List<RelActor> relActors) {
        this.relActors = relActors;
    }

    public List<RelTag> getRelTags() {
        return relTags;
    }

    public void setRelTags(List<RelTag> relTags) {
        this.relTags = relTags;
    }
}
