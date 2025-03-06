package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.getMember(map);
		if(member != null) {
			System.out.println("성공");
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getUserName());
			session.setAttribute("sessionStatus", member.getStatus());
			session.setMaxInactiveInterval(60*60); //60*60초
			// model > member 에 status, get,set 만들어줘야함
			
//			session.invalidate(); (한번에 모든)세션 정보 삭제 (로그아웃)
//			session.removeAttribute("sessionId"); id, name, status 등 1개씩 삭제
			
			resultMap.put("member", member);
			resultMap.put("result", "success");
		} else {
			System.out.println("실패");
			resultMap.put("result", "fail");
		}
			
		return resultMap;
	}


	public HashMap<String, Object> memberAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			memberMapper.memberInsert(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

//	중복체크
	public HashMap<String, Object> memberIdcheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member user = memberMapper.selectMember(map);
			
//			resultMap.put("user", user);
//			개인정보를 다 넘겨줄 필요 없음. 있는지 없는지만 알 수 있도록.
			int count = user != null ? 1 : 0;
//			조회된 user 정보가 있으면 1, 없으면 0 (편의에 맞게 보내면 됨)
			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

//	사용자 정보 조회 (중복체크 재활용)
	public HashMap<String, Object> getMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member member = memberMapper.selectMember(map);
			
			resultMap.put("member", member);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}


	public HashMap<String, Object> memberRemoveList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		try {
			memberMapper.deleteMemberList(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
}