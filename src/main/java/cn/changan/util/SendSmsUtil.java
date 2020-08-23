package cn.changan.util;

import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

public class SendSmsUtil {

    public static String sendSms(String phone_number,String captchaCode) throws Exception{
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou","LTAI4GHJgcgBEeQaRWp5L6r6","g4HC0KvuK9Nn3kjE1xmwjBZO9kaiQT");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phone_number);
        request.putQueryParameter("SignName", "高校奖学金申报管理系统");
        request.putQueryParameter("TemplateCode", "SMS_192575949");
        request.putQueryParameter("TemplateParam", captchaCode);

        CommonResponse response = client.getCommonResponse(request);
        JSONObject object = JSONObject.parseObject(response.getData());
        return (String)object.get("Code");
    }
}
