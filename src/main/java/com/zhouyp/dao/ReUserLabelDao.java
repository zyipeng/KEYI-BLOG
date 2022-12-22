package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.ReUserLabel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReUserLabelDao extends ArtDao<ReUserLabel>{
    int insertReUserLabelList(@Param("userId") String userId, @Param("labelList") List<String> labelList);
}

