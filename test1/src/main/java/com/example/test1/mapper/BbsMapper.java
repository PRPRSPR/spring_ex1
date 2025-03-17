package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.BoardFile;

@Mapper
public interface BbsMapper {

	List<Bbs> selectBbsList(HashMap<String, Object> map);

	void insertBbs(HashMap<String, Object> map);

	void deleteBbs(HashMap<String, Object> map);

	Bbs selectInfo(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	void updateInfo(HashMap<String, Object> map);

	int selectBbsCnt(HashMap<String, Object> map);

	void insertBbsFile(HashMap<String, Object> map);

	List<BoardFile> selectBbsFile(HashMap<String, Object> map);

}