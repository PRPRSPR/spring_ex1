package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Member;
import com.example.test1.model.User;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.userMapperLogin(map);
		// System.out.println(user.getUserName()); >> 이름 출력됨
		String result = user != null ? "success" : "fail";
		// id.pwd 있으면 success
		resultMap.put("result", result);
		resultMap.put("info", user);
			
		return resultMap;
	}


	public HashMap<String, Object> memberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// resultMap을 만드는 과정
//		userMapper.getUserList(map);
		List<Member> list = userMapper.getUserList(map);
//		List<Member>를 import (가져올 데이터가 여러개)
		resultMap.put("list", list);
		return resultMap;
	}


	public HashMap<String, Object> memberRemove(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		userMapper.memberDelete(map);
		// 함수명만 보고 유추할 수 있게 이름에 변화줌
		resultMap.put("result","success");
		return resultMap;
	}


	public HashMap<String, Object> testRemove(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		userMapper.testDelete(map);
		resultMap.put("result","success");
		return resultMap;
	}
	
}
