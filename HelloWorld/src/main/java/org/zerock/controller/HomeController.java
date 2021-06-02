package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.LoginDTO;
import org.zerock.domain.SampleDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
//	@RequestMapping은 get, post, put, delete등등의 방식으로 보낼 수 있다. (RequestMethod.)
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
//		model은 jsp에서 request.setAttribute("serverTime", serverTime) / ${serverTime}와 유사한 역할이다.
		model.addAttribute("serverTime", formattedDate );
		
		return "home"; 
	}
	
	@GetMapping("/ex05")
	public void ex05() {
		System.out.println("ex05...");
	}
	
	@GetMapping("/list")
	public void boardList() {
		// 게시판 목록 작업
	}
	
	@GetMapping("/test")
//	String이면 return 값이 나오는 곳으로 주소가 옮겨진다.
	public String testList() {
		return "list";
	}
	
	@GetMapping("/test2")
//	list.jsp로 돌아간다.
	public String testList2() {
		return "redirect:/list";
	}
	
	@GetMapping("/ex06")
//	Json 데이터로 불러오는 방식(jackson.core가 필요하다.)
	public @ResponseBody SampleDTO ex06() {
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		return dto; // Json형식으로 변환되어 브라우저로 전송됨.
	}
	
	@GetMapping("/ex07")
//	jsp에 form 태그가 있고, input의 id가 name, age이면 parameter에 저장이 된다.
	public void ex07(SampleDTO s) {
		s.setAge(10);
		s.setName("홍길동");
	}
	
	@GetMapping("/login")
	public void login(LoginDTO l) {
		l.setId("ghkdwlghks");
		l.setPw("password");
	}
}
