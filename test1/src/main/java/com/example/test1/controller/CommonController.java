package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.CommonService;
import com.google.gson.Gson;


@Controller
public class CommonController {

	@Autowired
	CommonService commonService;
	
	@RequestMapping("/map.do") 
    public String map(Model model) throws Exception{

        return "/map";
    }

	@RequestMapping("/slider.do") 
	public String slider(Model model) throws Exception{
		
		return "/slider";
	}
	
	@RequestMapping("/datepicker.do") 
	public String datepicker(Model model) throws Exception{
		
		return "/datepicker";
	}
	
	@RequestMapping("/chatBot.do") 
	public String add(Model model) throws Exception{
		
		return "/chatBot";
	}
	
	@RequestMapping(value = "/menu.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String menu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = commonService.getMenuList(map);
		return new Gson().toJson(resultMap);
	}
}
