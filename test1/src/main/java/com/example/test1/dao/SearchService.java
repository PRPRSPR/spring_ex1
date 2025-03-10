package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.SearchMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Search;

@Service
public class SearchService {
	@Autowired
	SearchMapper searchMapper;
	
	public HashMap<String, Object> getAreaList(HashMap<String, Object> map) {
HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Search> siList = searchMapper.selectSiList(map);
			List<Search> guList = searchMapper.selectGuList(map);
			List<Search> dongList = searchMapper.selectDongList(map);
			resultMap.put("siList", siList);
			resultMap.put("guList", guList);
			resultMap.put("dongList", dongList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

}
