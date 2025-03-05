package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
//		boardMapper.selectBoardList(map);
//		List<Board> list = boardMapper.selectBoardList(map);
		// get, select
		// add, insert
		// edit, update
		// remove, delete
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Board> list = boardMapper.selectBoardList(map);
			
			int count = boardMapper.selectBoardCnt(map);
//			페이징 작업 위한 전체 게시글 수 구하기
//			System.out.println(count);
//			전체 게시글 수 출력 확인
			resultMap.put("list", list);
			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			boardMapper.insertBoard(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			if(map.get("option").equals("SELECT")) {
				boardMapper.updateCnt(map);				
			}
			// 조회수 증가
			Board info = boardMapper.selectBoard(map);
			// selectBoard >> Board 타입
			List<Comment> commentList = boardMapper.selectBoardComment(map);
			
			resultMap.put("info", info);
			resultMap.put("commentList", commentList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			boardMapper.updateBoard(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	// 게시글 삭제
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			boardMapper.deleteBoard(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	// 게시글 여러개 삭제
	public HashMap<String, Object> boardRemoveList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		try {
			boardMapper.deleteBoardList(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			boardMapper.insertComment(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

}
