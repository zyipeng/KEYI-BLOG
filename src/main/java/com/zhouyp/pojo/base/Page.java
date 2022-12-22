package com.zhouyp.pojo.base;

import java.util.List;

public class Page<T> {
    private int pageSize = 10;
    private int pageNumb = 1;//start 1
    private int totalPages;
    private int totalRows;
    private int startRow;
    private int stopRow;
    private List<T> result;

    public Page() {
    }

    public Page(int pageNumb) {
        setPageNumb(pageNumb);
    }

    public Page(int pageSize, int pageNumb) {
        this.pageSize = pageSize;
        setPageNumb(pageNumb);
    }


    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNumb() {
        return pageNumb;
    }

    public void setPageNumb(int pageNumb) {
        this.pageNumb = pageNumb;
        startRow = (pageNumb - 1) * pageSize + 1;
        stopRow = pageNumb * pageSize;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
        this.totalPages = totalRows/pageSize;
        if (totalRows % pageSize != 0) {
            totalPages++;
        }
    }

    public int getStartRow() {
        return startRow;
    }

    public int getStopRow() {
        return stopRow;
    }

    public void first(){
        setPageNumb(1);
    }

    public void previous() {
        if (pageNumb == 1) {
            return;
        }
        setPageNumb(pageNumb-1);
    }

    public void next(){
        if (pageNumb < totalPages) {
            setPageNumb(pageNumb+1);
        }
    }

    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }
}
