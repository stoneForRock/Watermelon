package com.yx.vdos.model.resp;

import com.yx.vdos.model.entity.Article;

/**
 * @authorvdos
 * @date 2018/8/15 0015.
 */
public class ArticleResp extends Article {

    private static final long serialVersionUID = -5043437488019108055L;

    private String columnName;
    private Integer configId;
    private Integer rank;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public Integer getConfigId() {
        return configId;
    }

    public void setConfigId(Integer configId) {
        this.configId = configId;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }
}
