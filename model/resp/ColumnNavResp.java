package com.yx.vdos.model.resp;

import com.yx.vdos.model.entity.Column;
import com.yx.vdos.model.entity.ColumnNav;

import java.util.List;

public class ColumnNavResp extends Column {

    private static final long serialVersionUID = 5630140355657065277L;

    private List<ColumnNav> subclass;

    public List<ColumnNav> getSubclass() {
        return subclass;
    }

    public void setSubclass(List<ColumnNav> subclass) {
        this.subclass = subclass;
    }
}
