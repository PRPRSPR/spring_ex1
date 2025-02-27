package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping("/login.do") 
    public String login(Model model) throws Exception{
		// 도메인 설정

        return "/login";
        // >>> login.jsp 파일 실행 jsp 생략
    }
	@RequestMapping("/member/list.do") 
	public String list(Model model) throws Exception{
		//메소드명 변경해줘야함
		
		return "/member-list";
	}
	@RequestMapping("/test.do") 
	public String test(Model model) throws Exception{
		
		return "/test1";
	}
	
	
	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
//		System.out.println(map);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userLogin(map);
//		userService클래스의 userLogin함수 호출
		return new Gson().toJson(resultMap);
		// return >> login.jsp의 ajax/data로 받을 수 있음.
	}
	@RequestMapping(value = "/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.memberList(map);
//		map 파라메터는 당장인 빈값이어도 나중을 위해 넣어두는 것이 좋음
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/member/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		// "/member/remove.dox" 주소 / memberRemove 메소드 이름 변경 시 잘 확인하기 >> 중복되면 오류
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.memberRemove(map);
		// 서비스의 메소드 호출 >> 메소드명 확인. 자동으로 만들어줌
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/test/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String testRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.testRemove(map);
		// 테이블명을 알아볼 수 있는 명칭이 좋음 >> test >>> porduct
		return new Gson().toJson(resultMap);
	}
	
}
