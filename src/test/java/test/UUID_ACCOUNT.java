package test;

import org.junit.Test;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public class UUID_ACCOUNT {
    @Test
    public void demo01() {
        UUID uuid = UUID.randomUUID();
        System.out.println(uuid);
        Double d = new Double("20000000001");
        System.out.println(d.toString());
    }


    private static String token = null;//存token
    private static LocalTime preTime; //存上一次token更新时间
//    public String getAccessToken() {
//        if (token==null||preTime.isBefore(LocalTime.now().minusHours(1))){
//            //如果token为空，或者上一次的时间在当先时间减去一个小时之前，则获取token
//            token = res.get("access_token").toString();
//            preTime = LocalTime.now();
//        }
//        return token;
//    }
    @Test
    public void demo02(){
        LocalTime localTime1 = LocalTime.now();
        System.out.println(localTime1);
        LocalTime localTime2 = localTime1.minusHours(1);
        LocalTime localTime3 = localTime1.minusMinutes(50);
        System.out.println("localTime1:"+localTime1);
        System.out.println("localTime2:"+localTime2);
        System.out.println("localTime3:"+localTime3);
        System.out.println(localTime3.isAfter(localTime2));
    }
    @Test
    public void demo03(){
        UUID uuid = UUID.randomUUID();
        System.out.println(uuid.toString()+uuid.toString());
    }
}
