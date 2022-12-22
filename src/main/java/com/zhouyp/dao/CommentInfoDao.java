package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.CommentInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentInfoDao extends ArtDao<CommentInfo>{
    public List<CommentInfo> findRootList(String artId);
    public List<CommentInfo> findChildList(CommentInfo root);
    public int count();
}

