package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.ReUserLabel;

import java.util.List;

public interface ReUserLabelService extends ArtService<ReUserLabel> {
    int insertReUserLabelList(String userId, List<String> labelId);
    public List<ReUserLabel> findListByUserId(String userId);
}
