package com.zhouyp.dao;
import com.zhouyp.art.ArtDao;
import com.zhouyp.pojo.CategoryNode;
import com.zhouyp.pojo.UserCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserCategoryDao extends ArtDao<UserCategory>{

    /**
     * 查询父列表
     * @param userId
     * @return
     */
    public List<CategoryNode> findChildList(@Param("userId") String userId, @Param("parId") String parId,@Param("requestUrl") String requestUrl);
}

