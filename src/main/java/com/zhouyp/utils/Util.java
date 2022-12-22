package com.zhouyp.utils;

public class Util {
    public static boolean strIsEmpty(String str){
        if (str == null || str.length() == 0 || str.equals("")) {
            return true;
        }
        return false;
    }
}
