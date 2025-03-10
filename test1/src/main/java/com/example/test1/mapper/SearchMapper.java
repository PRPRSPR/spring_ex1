package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Search;

@Mapper
public interface SearchMapper {

	List<Search> selectSiList(HashMap<String, Object> map);

	List<Search> selectGuList(HashMap<String, Object> map);

	List<Search> selectDongList(HashMap<String, Object> map);

}
