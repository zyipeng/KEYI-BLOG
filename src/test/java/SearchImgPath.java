import org.junit.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SearchImgPath {
    @Test
    public void demo01(){
        String str = "dgsdfbdsfgs![周毅鹏](/blog/images/blogs/19175f20-18f6-4975-b4c4-98c16594bc37.png)hhreefbdfbd![1](/blog/images/blogs/19175f20-18f6-4975-b4c4-98c16594bc37.png)";
        Pattern p=Pattern.compile("!\\[[^(\\]\\n\\r)]*]\\(.+?\\.(png|jpg|jpeg|gif)\\)");
        Matcher m=p.matcher(str);
        if (m.find()) {
            String s = m.group();
            System.out.println(s);
        }
    }
    @Test
    public void demo02(){
        String str = "![周毅鹏](/blog/images/blogs/19175f20-18f6-4975-b4c4-98c16594bc37.png)";
        String substring = str.substring(str.lastIndexOf('/')+1,str.length()-1);
        System.out.println(substring);
    }
}
