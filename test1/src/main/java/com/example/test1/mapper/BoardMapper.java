package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.BoardFile;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
Object insertBoardFile = null;

	// interface로 생성해야 함
	List<Board> selectBoardList(HashMap<String, Object> map);

	void insertBoard(HashMap<String, Object> map);

	Board selectBoard(HashMap<String, Object> map);
	// 여러개가 아니고 하나. list 사용하지 않고 Board 타입으로 지정

	void updateBoard(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	void deleteBoard(HashMap<String, Object> map);

	void deleteBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<Comment> selectBoardComment(HashMap<String, Object> map);

	void insertComment(HashMap<String, Object> map);

	void insertBoardFile(HashMap<String, Object> map);

	List<BoardFile> selectBoardFile(HashMap<String, Object> map);

}