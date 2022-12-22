package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.CommentInfo;

import java.util.List;

public interface CommentInfoService extends ArtService<CommentInfo> {
    public List<CommentInfo> findCommentTreeByArtId(String ArtId);

    public List<CommentInfo> randomCommentList();
}
