package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.ReUserLabelDao;
import com.zhouyp.pojo.ReUserLabel;
import com.zhouyp.service.ReUserLabelService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReUserLabelServiceImpl extends ArtServiceAbstract<ReUserLabelDao, ReUserLabel> implements ReUserLabelService {
    @Override
    public int insertReUserLabelList(String userId, List<String> labelId) {
        return dao.insertReUserLabelList(userId, labelId);
    }

    public List<ReUserLabel> findListByUserId(String userId) {
        ReUserLabel reUserLabel = new ReUserLabel();
        reUserLabel.setUserId(userId);
        return dao.findAllList(reUserLabel);
    }
}
