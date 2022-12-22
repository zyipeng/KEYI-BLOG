package com.zhouyp.service.impl;

import com.zhouyp.art.ArtServiceAbstract;
import com.zhouyp.dao.LabelInfoDao;
import com.zhouyp.dao.RedSearchWordDao;
import com.zhouyp.pojo.LabelInfo;
import com.zhouyp.pojo.RedSearchWord;
import com.zhouyp.service.LabelInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LabelInfoServiceImpl extends ArtServiceAbstract<LabelInfoDao, LabelInfo> implements LabelInfoService {
    @Autowired
    RedSearchWordDao redSearchWordDao;
    @Autowired
    LabelInfoDao labelInfoDao;

    @Override
    public List<String> redWord() {
        return labelInfoDao.findRedWordList();
    }

    public int addRedWord(String redWord) {
        RedSearchWord redSearchWord = new RedSearchWord();
        redSearchWord.setWord(redWord);
        return redSearchWordDao.insert(redSearchWord);
    }
}
