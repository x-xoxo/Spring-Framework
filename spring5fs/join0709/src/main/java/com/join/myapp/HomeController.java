package com.join.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.join.dto.UserVO;
import com.join.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	UserService us;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "login";
	}
	
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
	@ResponseBody
	public int postEmailCheck(HttpServletRequest req) throws Exception {
		 logger.info("post EmailCheck");
		 String email = req.getParameter("email");

		 
		 if(email.equals(""))
		 {
			 return 1;
		 }
		 
		 System.out.println(email);
		 UserVO temp = new UserVO();
		 temp.setEmail(email);
		 int result =  us.checkEmail(temp);
		 System.out.println(result);
		 return result;
		}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerView()
	{
		return "home";
	}
	
	@RequestMapping(value = "/registerNow", method = RequestMethod.POST)
	public String register(UserVO uv) throws Exception
	{
		System.out.println(uv.getEmail());
		System.out.println(uv.getUsername());
		System.out.println(uv.getPassword());
		
		//이메일 확인여부 후에 추가해주세요.
		
		if(us.checkEmail(uv) == 0)
		{
			us.insertUser(uv);
		}
		else
		{
			System.out.println("이메일이 있습니다.");
		}
		
		
		
		return "home";
	}
	
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String loginCheck(UserVO uv) throws Exception
	{
		System.out.println(uv.getUsername());
		System.out.println(uv.getPassword());
		if(us.loginCheck(uv) == 0)
			System.out.println("올바른 이름과 암호가 아닙니다.");
		else
			System.out.println("환영합니다.");
		return "home";
	}
	
	
}
