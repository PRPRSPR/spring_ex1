package com.example.test1.model;

import lombok.Data;

@Data
public class Comment {
	private String commentNo;
	private String boardNo;
	private String userId;
	private String userName;
	private String contents;
	private String pCommentNo;
	private String cdateTime;
	private String udateTime;
}
