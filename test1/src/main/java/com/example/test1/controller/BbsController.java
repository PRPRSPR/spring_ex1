package com.example.test1.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.common.Common;
import com.example.test1.dao.BbsService;
import com.google.gson.Gson;

@Controller
//필수
public class BbsController {
	
	@Autowired
	BbsService bbsService;
	// 객체를 만들어서 서비스와 연결해줌
	
	@RequestMapping("/bbs/list.do") 
    public String list(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
        return "/bbs/bbs-list";
    }

	@RequestMapping("/bbs/add.do") 
	public String add(Model model) throws Exception{
		
		return "/bbs/bbs-add";
	}

	@RequestMapping("/bbs/view.do") 
	public String view(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/bbs/bbs-view";
	}
	
	@RequestMapping("/bbs/edit.do") 
	public String edit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/bbs/bbs-edit";
	}
	
	@RequestMapping(value = "/bbs/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getBbsList(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/bbs/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.addBbs(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/bbs/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.removeBbs(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.viewInfo(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/bbs/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String edit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.editInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/bbs/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> multi, @RequestParam("bbsNum") int bbsNum, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		String url = null;
		String path="c:\\img";
		try {
			for(MultipartFile files : multi) {
				String uploadpath = path;
				String originFilename = files.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
				long size = files.getSize();
				String saveFileName = Common.genSaveFileName(extName);
				
				String path2 = System.getProperty("user.dir");
				if(!files.isEmpty())
				{
					File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
					files.transferTo(file);

					// db에 보내줄 정보
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("filename", saveFileName); // 서버 저장 파일명
					map.put("path", "../img/" + saveFileName); // 파일 경로
					map.put("bbsNum", bbsNum); // 게시글번호
					map.put("originFilename", originFilename); // 원본파일명
					map.put("extensionName", extName); // 확장자
					map.put("size", size); // 파일크기

					// insert 쿼리 실행
					bbsService.addBbsFile(map);

				}
			}
					return "redirect:/bbs/list.do";
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:/bbs/list.do";
	}
}
