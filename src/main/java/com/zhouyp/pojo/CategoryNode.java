package com.zhouyp.pojo;

import java.util.List;

public class CategoryNode {
    private String id;
    private String text;
    private String href;
    private List<CategoryNode> nodes;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTest() {
        return text;
    }

    public void setTest(String text) {
        this.text = text;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public List<CategoryNode> getNodes() {
        return nodes;
    }

    public void setNodes(List<CategoryNode> nodes) {
        this.nodes = nodes;
    }

    @Override
    public String toString() {
        return "CategoryNode{" +
                "id='" + id + '\'' +
                ", text='" + text + '\'' +
                ", href='" + href + '\'' +
                ", nodes=" + nodes +
                '}';
    }
}
