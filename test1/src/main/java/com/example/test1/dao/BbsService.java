package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.BoardFile;

@Service
public class BbsService {
	
	@Autowired
	BbsMapper bbsMapper;

	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Bbs> list = bbsMapper.selectBbsList(map);
			
			int count = bbsMapper.selectBbsCnt(map);
			
			resultMap.put("list", list);
			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			bbsMapper.insertBbs(map);
			resultMap.put("bbsNum", map.get("bbsNum"));
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> removeBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			bbsMapper.deleteBbs(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> viewInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			if(map.get("option").equals("select")) {
				bbsMapper.updateCnt(map);
			}
			Bbs info = bbsMapper.selectInfo(map);
			List<BoardFile> fileList = bbsMapper.selectBbsFile(map);
			
			resultMap.put("info", info);
			resultMap.put("fileList", fileList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public HashMap<String, Object> editInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			bbsMapper.updateInfo(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	public void addBbsFile(HashMap<String, Object> map) {
		bbsMapper.insertBbsFile(map);
	}
	
}
