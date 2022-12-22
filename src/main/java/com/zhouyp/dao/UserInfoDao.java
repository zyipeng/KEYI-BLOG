package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserInfoDao extends ArtDao<UserInfo>{
    int addAttentionUser(@Param("userId") String userId, @Param("attentionId") String attentionId);

    int delAttentionUser(@Param("userId") String userId, @Param("attentionId") String attentionId);

    List<UserInfo> attentionListByUserId(String userId);

    List<UserInfo> fansListByUserId(String attentionId);

    int haveAttention(@Param("userId") String userId, @Param("attentionId") String attentionId);

    int updateAttentionCount(@Param("userId") String userId,@Param("i") int i);

    int updateFansCount(@Param("userId") String userId,@Param("i") int i);

    int updateVisitCount(String userId);

}

