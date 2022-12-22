package com.zhouyp.service;

import com.zhouyp.art.ArtService;
import com.zhouyp.pojo.LabelInfo;

import java.util.List;

public interface LabelInfoService extends ArtService<LabelInfo> {
    List<String> redWord();
    public int addRedWord(String redWord);
}
