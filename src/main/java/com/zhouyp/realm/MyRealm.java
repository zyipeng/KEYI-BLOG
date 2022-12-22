package com.zhouyp.realm;

import java.util.List;
import java.util.Set;

import com.zhouyp.pojo.UserInfo;
import com.zhouyp.service.UserInfoService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * created by yangqing on 2018年2月19日 下午9:57:09
 */
public class MyRealm extends AuthorizingRealm {

    @Autowired
    private UserInfoService userInfoService;

    /**
     * 授权方法
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        /**
         * 注意principals.getPrimaryPrincipal()对应
         * new SimpleAuthenticationInfo(user.getUserName(), user.getPassword(), getName())的第一个参数
         */
        //获取当前身份
        String userName = (String) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        //从数据库中查找该用户有何角色和权限
        Set<String> roles = null;//= userService.getRoles(userName);

        //为当前用户赋予对应角色和权限
//        info.setRoles(roles);
        UserInfo userInfo = userInfoService.get(new UserInfo(userName));
        info.addRole(userInfo.getRole().toString());

        return info;
    }

    /**
     * 认证方法
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取用户名
        String username = (String) token.getPrincipal();
        UserInfo userInfo = null;
        //从数据库中查找用户信息
        List<UserInfo> temp = userInfoService.findList(new UserInfo(username));
        if (temp != null && temp.size() != 0) {
            userInfo = temp.get(0);
        }
        if (userInfo == null) {
            return null;
        }
        AuthenticationInfo info = new SimpleAuthenticationInfo(userInfo, userInfo.getPwd(), getName());
        return info;
    }

}