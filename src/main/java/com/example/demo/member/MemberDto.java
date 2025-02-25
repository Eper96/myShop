package com.example.demo.member;

import lombok.Data;

@Data
public class MemberDto {
	private int id,state,juk;
	private String userid,name,pwd,email,phone,writeday;
}
