package com.example.test1.model;

import lombok.Data;

@Data
public class Product {

	private String itemNo;
	private String itemName;
	private String filePath;
	private String fileName;
	private String thumbnail;
	private String itemInfo;
	private int price;
}
