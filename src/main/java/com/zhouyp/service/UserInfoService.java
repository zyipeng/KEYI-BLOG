package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.pojo.base.Page;

import java.util.List;

public interface UserInfoService extends ArtService<UserInfo> {
    List<UserInfo> findHotList();

    boolean haveAttention(String userId,String attentionId);

    Long addAttention(String userId, String attentionId);

    Long deleteAttention(String userId, String attentionId);

    List<UserInfo> findFansList(String userId);
    Page<UserInfo> findFansPage(Page<UserInfo> page,String userId);

    List<UserInfo> findAttentionList(String userId);
    Page<UserInfo> findAttentionPage(Page<UserInfo> page,String userId);

    int updateVisitCount(String userId);
}
