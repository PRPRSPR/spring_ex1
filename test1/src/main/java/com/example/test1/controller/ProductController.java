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
import com.example.test1.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class ProductController {

	@Autowired
	ProductService productService;
	
	@RequestMapping("/product/list.do") 
    public String list(Model model) throws Exception{

        return "/product/product-list";
    }
	@RequestMapping("/product/view.do") 
	public String view(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		return "/product/product-view";
	}
	@RequestMapping("/product/add.do") 
	public String add(Model model) throws Exception{
		
		return "/product/product-add";
	}
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductList(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/product/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductView(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.addProduct(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/product/payment.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String payment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.addPayment(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/product/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> multi, @RequestParam("itemNo") int itemNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		String url = null;
		String path="c:\\img";
		
		// 카운트나 플래그 등으로 썸네일 구분 가능
		
		boolean thumbFlg = true;
		
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
//					map.put("filename", saveFileName); // 서버 저장 파일명
					map.put("path", "../img/" + saveFileName); // 파일 경로
					map.put("originFilename", originFilename); // 원본파일명
//					map.put("extensionName", extName); // 확장자
//					map.put("size", size); // 파일크기
					map.put("itemNo", itemNo); // 제품번호
					
					String thumbnail = thumbFlg ? "Y" : "N"; // 썸네일여부
					map.put("thumbnail", thumbnail);

					// insert 쿼리 실행
					productService.addProductFile(map);
					thumbFlg = false;

//					model.addAttribute("filename", files.getOriginalFilename());
//					model.addAttribute("uploadPath", file.getAbsolutePath());

				}
			}
					return "redirect:/product/list.do";
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:/product/list.do";
	}
}
