package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
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
import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
//		System.out.println(map);
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
	//게시글 수정
	@RequestMapping(value = "/board/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.editBoard(map);
		return new Gson().toJson(resultMap);
	}
	//게시글 삭제
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.removeBoard(map);
		return new Gson().toJson(resultMap);
	}
	//게시글 여러개 삭제
	@RequestMapping(value = "/board/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		list 형태의 값 > json 형태의 문자로 전송 > list로 꺼내기
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		resultMap = boardService.boardRemoveList(map);
		return new Gson().toJson(resultMap);
	}
	// 덧글 작성
	@RequestMapping(value = "/board/addCmt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addCmt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addComment(map);
		return new Gson().toJson(resultMap);
	}
	// 파일업로드
	@RequestMapping("/fileUpload.dox")
//	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
	public String result(@RequestParam("file1") List<MultipartFile> multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		String url = null;
		String path="c:\\img";
		try {
			// 여러개의 파일을 올리기위해 List로 바꿈. 아래 내용도 반복해줘야함 >> board-add.jsp 포함
			
//			//String uploadpath = request.getServletContext().getRealPath(path);
//			String uploadpath = path;
//			String originFilename = multi.getOriginalFilename();
//			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
//			long size = multi.getSize();
//			String saveFileName = genSaveFileName(extName);
//			
//			System.out.println("uploadpath : " + uploadpath);
//			System.out.println("originFilename : " + originFilename);
//			System.out.println("extensionName : " + extName);
//			System.out.println("size : " + size);
//			System.out.println("saveFileName : " + saveFileName);
//			String path2 = System.getProperty("user.dir");
//			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
//			if(!multi.isEmpty())
//			{
//				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
//				multi.transferTo(file);
//				
//				//db에 보내줄 정보
//				HashMap<String, Object> map = new HashMap<String, Object>();
//				map.put("filename", saveFileName); // 서버 저장 파일명
//				map.put("path", "../img/" + saveFileName); // 파일 경로
//				map.put("boardNo", boardNo); // 게시글번호
//				map.put("originFilename", originFilename); // 원본파일명
//				map.put("extensionName", extName); // 확장자
//				map.put("size", size); // 파일크기
//				
//				// insert 쿼리 실행
//			    boardService.addBoardFile(map);
//				
//				model.addAttribute("filename", multi.getOriginalFilename());
//				model.addAttribute("uploadPath", file.getAbsolutePath());
//				
//				return "redirect:board/list.do";
//			}
			
//			System.out.println(multi.size());
			// 파일 갯수
			
			for(MultipartFile files : multi) {
//				System.out.println(file.getOriginalFilename());
				String uploadpath = path;
				String originFilename = files.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
				long size = files.getSize();
				String saveFileName = Common.genSaveFileName(extName);
				
				String path2 = System.getProperty("user.dir");
				
//				System.out.println("uploadpath : " + uploadpath);
//				System.out.println("originFilename : " + originFilename);
//				System.out.println("extensionName : " + extName);
//				System.out.println("size : " + size);
//				System.out.println("saveFileName : " + saveFileName);
//				System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
				
				if(!files.isEmpty())
				{
					File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
					files.transferTo(file);

					// db에 보내줄 정보
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("filename", saveFileName); // 서버 저장 파일명
					map.put("path", "../img/" + saveFileName); // 파일 경로
					map.put("boardNo", boardNo); // 게시글번호
					map.put("originFilename", originFilename); // 원본파일명
					map.put("extensionName", extName); // 확장자
					map.put("size", size); // 파일크기

					// insert 쿼리 실행
					boardService.addBoardFile(map);

//					model.addAttribute("filename", files.getOriginalFilename());
//					model.addAttribute("uploadPath", file.getAbsolutePath());

				}
			}
					return "redirect:board/list.do";
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:board/list.do";
//		redirect >> 원하는 페이지로 이동
	}
}
