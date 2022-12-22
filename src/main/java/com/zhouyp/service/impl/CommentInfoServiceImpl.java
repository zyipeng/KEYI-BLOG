package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.CommentInfoDao;
import com.zhouyp.pojo.CommentInfo;
import com.zhouyp.service.CommentInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class CommentInfoServiceImpl extends ArtServiceAbstract<CommentInfoDao,CommentInfo> implements CommentInfoService {
    @Autowired
    CommentInfoDao commentInfoDao;
    @Override
    public List<CommentInfo> findCommentTreeByArtId(String artId) {
        //首先查询所有的根评论
        //根的定理则是，没有父id，没有根id
        List<CommentInfo> rootList = commentInfoDao.findRootList(artId);
        //然后维护根评论中的子回复列表
        //通过根id和artId查出子回复列表
        for (CommentInfo root : rootList) {
            List<CommentInfo> childList = commentInfoDao.findChildList(root);
            root.setHfList(childList);
        }
        return rootList;
    }

    @Override
    public List<CommentInfo> randomCommentList() {
        //获取总数
        int count = commentInfoDao.count();
        int base = 0;
        if (count > 8) {
            Random random = new Random();
            base = random.nextInt(count - 4);
        }
        return commentInfoDao.findConditionList("limit " + base + "10");
    }
}
