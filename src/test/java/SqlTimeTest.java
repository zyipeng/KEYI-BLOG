import org.junit.Test;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class SqlTimeTest {
    @Test
    public void demo01(){
        Date date = new Date(System.currentTimeMillis());
        System.out.println(date);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String parse = dateFormat.format(date);
        System.out.println(parse);
    }
}
