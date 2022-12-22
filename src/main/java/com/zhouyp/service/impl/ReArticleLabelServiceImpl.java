package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.ReArticleLabelDao;
import com.zhouyp.pojo.ReArticleLabel;
import com.zhouyp.service.ReArticleLabelService;
import org.springframework.stereotype.Service;

@Service
public class ReArticleLabelServiceImpl extends ArtServiceAbstract<ReArticleLabelDao, ReArticleLabel> implements ReArticleLabelService {
}
