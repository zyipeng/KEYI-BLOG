import com.zhouyp.pojo.UserInfo;
import com.zhouyp.service.UserInfoService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class Main {
    void a(){
        System.out.println(""+1/0);
    }
    void B(){
        try {
            System.out.println("123");
            a();
            System.out.println("3");
        } catch (Exception e) {
            System.out.println("抛出异常");
        }
    }

    public static void main(String[] args) {
        Main mai = new Main();
        mai.B();
    }
    @Autowired
    UserInfoService userInfoService;
    @Test
    public void demo01(){
        UserInfo userInfo = new UserInfo();
        userInfo.setUserName("0");
    }
    @Test
    public void demo02(){
        UserInfo userInfo = new UserInfo();
        System.out.println(userInfo);
    }
    @Test
    public void Demo01(){
        String a = "";
        a.equals("");
        a.hashCode();
    }
}
