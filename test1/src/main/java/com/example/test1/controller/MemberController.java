package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.util.MultiValueMap;
import org.springframework.util.LinkedMultiValueMap;

import com.example.test1.dao.MemberService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Value("${client_id}")
	private String client_id;

    @Value("${redirect_uri}")
    private String redirect_uri;
	
	@RequestMapping("/member/login.do") 
	public String login(Model model) throws Exception{
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
        model.addAttribute("location", location);

        return "/member/member-login"; 
    }
	@RequestMapping("/member/add.do") 
	public String add(Model model) throws Exception{
		
		return "/member/member-add";
	}
	@RequestMapping("/addr.do") 
	public String juso(Model model) throws Exception{
		
		return "/jusoPopup";
	}
	@RequestMapping("/pay.do") 
	public String pay(Model model) throws Exception{
		
		return "/pay";
	}
	@RequestMapping("/auth.do") 
	public String auth(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/auth";
	}
	@RequestMapping("/member/pwd.do") 
	public String pwd(Model model) throws Exception{
		
		return "/member/pwd-search";
	}
	@RequestMapping("/member/editPwd.do") 
	public String editpwd(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/member/pwd-edit";
	}
	
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberLogin(map);
		return new Gson().toJson(resultMap);
	}
	//카카오 로그인
	@RequestMapping(value = "/kakao.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String kakao(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String tokenUrl = "https://kauth.kakao.com/oauth/token";

        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", client_id);
        params.add("redirect_uri", redirect_uri);
        params.add("code", (String) map.get("code"));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, request, Map.class);

        Map<String, Object> responseBody = response.getBody();
//        return (String) responseBody.get("access_token");
//        System.out.println((String) responseBody.get("access_token")); // >>> 사용자 정보에 엑세스 가능한 토큰 발급
        resultMap = (HashMap<String, Object>) getUserInfo((String) responseBody.get("access_token"));
        System.out.println(resultMap);
        return new Gson().toJson(resultMap);
	}
	
	private Map<String, Object> getUserInfo(String accessToken) {
	    String userInfoUrl = "https://kapi.kakao.com/v2/user/me";

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setBearerAuth(accessToken);
	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    ResponseEntity<String> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, String.class);

	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        return objectMapper.readValue(response.getBody(), Map.class);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null; // 예외 발생 시 null 반환
	    }
	}
	
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String logout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberLogout(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberAdd(map);
		return new Gson().toJson(resultMap);
	}
	// ID 중복체크
	@RequestMapping(value = "/member/idCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberIdcheck(map);
		// searchMember >> id로 유저 검색기능 재활용 가능
		return new Gson().toJson(resultMap);
	}
	// 사용자 정보 조회(pk)
	@RequestMapping(value = "/member/get.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String get(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.getMember(map);
		return new Gson().toJson(resultMap);
	}
	// 비밀번호 변경
	@RequestMapping(value = "/member/editPwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editPwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.editPwd(map);
		return new Gson().toJson(resultMap);
	}
	// 여러 사용자 정보 삭제
	@RequestMapping(value = "/member/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		resultMap = memberService.memberRemoveList(map);
		return new Gson().toJson(resultMap); 
	}
}
