package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.RedSearchWord;

import java.util.List;

public interface RedSearchWordDao extends ArtDao<RedSearchWord>{
    List<RedSearchWord> findAllList();
}

