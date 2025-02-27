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

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
//필수
public class BoardController {
	
	@Autowired
	BoardService boardService;
	// 객체를 만들어서 서비스와 연결해줌
	
	@RequestMapping("/board/list.do") 
    public String list(Model model) throws Exception{

        return "/board/board-list";
    }
	@RequestMapping("/board/add.do") 
	public String add(Model model) throws Exception{
		
		return "/board/board-add";
	}
	@RequestMapping("/board/view.do") 
	public String view(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		// pageChange("/board/view.do",{boardNo:boardNo})에서 boardNo:boardNo 를 보냄 >> map 에 담음
		// board-list >> Controller
		System.out.println(map);
		// {boardNo=1} 출력
		
		request.setAttribute("map", map);
		// map 이라는 이름으로 보내주기
		// Controller >> board-view
		
		return "/board/board-view";
	}
	@RequestMapping("/board/edit.do") 
	public String edit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/board/board-edit";
	}
	
	// 게시글 목록
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		return new Gson().toJson(resultMap);
	}
	// 게시글 추가
	@RequestMapping(value = "/board/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addBoard(map);
		return new Gson().toJson(resultMap);
	}
	//게시글 상세보기
	@RequestMapping(value = "/board/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoard(map);
		return new Gson().toJson(resultMap);
	}
}
