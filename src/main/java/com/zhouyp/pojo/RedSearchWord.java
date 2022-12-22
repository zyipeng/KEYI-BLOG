package com.zhouyp.pojo;

import com.zhouyp.art.DataEntity;

import java.io.Serializable;

/**
 * @Description  
 * @Company asia 
 * @Author  zhouyp@asiainfo.com
 * @Date 2020-06-03 
 */
public class RedSearchWord extends DataEntity<RedSearchWord> implements Serializable {

	private static final long serialVersionUID =  3019327568416512511L;

	private String word;	//

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	@Override
	public String toString() {
		return "RedSearchWord{" +
				"word=" + word+
				"}";
	}
}
