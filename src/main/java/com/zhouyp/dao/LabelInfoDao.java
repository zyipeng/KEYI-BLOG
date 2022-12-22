package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.LabelInfo;

import java.util.List;

public interface LabelInfoDao extends ArtDao<LabelInfo>{
    List<String> findRedWordList();
}

