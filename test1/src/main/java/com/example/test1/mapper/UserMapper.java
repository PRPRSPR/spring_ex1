package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;
import com.example.test1.model.User;

@Mapper
public interface UserMapper {
	// @Mapper 명시 필수
	User userMapperLogin(HashMap<String, Object> map);
	// User >> 클래스

	List<Member> getUserList(HashMap<String, Object> map);
	// 위의 User 사용시에는 최대 1개 조회 / Member의 경우 여러개로 관리해야함(lsit)

	void memberDelete(HashMap<String, Object> map);

	void testDelete(HashMap<String, Object> map);
}
