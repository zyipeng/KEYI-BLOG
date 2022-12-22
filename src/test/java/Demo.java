import jdk.nashorn.internal.objects.NativeString;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class Demo {
    @Test
    public void demo01(){
        String originalFilename = "abc.png";
        String substring = originalFilename.substring(originalFilename.lastIndexOf("."));
        System.out.println(substring);
    }

    @Test
    public void demo02(){
        String sql = "select\n" +
                "           id,\n" +
                "           user_id,\n" +
                "           category_id,\n" +
                "           name,\n" +
                "           intro,\n" +
                "           path,\n" +
                "           img_path,\n" +
                "           like_count,\n" +
                "           hate_count,\n" +
                "           comment_count,\n" +
                "           visit_count,\n" +
                "           create_time,\n" +
                "           issue_time,\n" +
                "           hide_flag,\n" +
                "           issue_flag,\n" +
                "           original_flag,\n" +
                "           del_flag,\n" +
                "           label_id\n" +
                "        from article_info\n" +
                "         where  user_id= ?";
        String form = sql.substring(sql.indexOf("form") + 4);
        System.out.println(form);
    }
    @Test
    public void demo03(){
        String str = "abc?cde?";
        int i = str.indexOf('?');
//        System.out.println(i);
//        String k = str.replace("?", "k");
        String k = str.replaceFirst("\\?", "k");
        System.out.println(k);
    }
    @Test
    public void demo04(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = dateFormat.format(new Date());
        System.out.println(format);
    }

    @Test
    public void demo05(){
        Random random = new Random();
        int i = random.nextInt(10);
        System.out.println(i);
    }
}
