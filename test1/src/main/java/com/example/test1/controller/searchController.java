package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.SearchService;
import com.google.gson.Gson;

@Controller
public class searchController {
	@Autowired
	SearchService searchService;
	
	@RequestMapping("/search/Area.do") 
    public String list(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);

        return "/weather-search";
    }
	
	@RequestMapping(value = "/search/Area.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = searchService.getAreaList(map);
		return new Gson().toJson(resultMap);
	}
}
