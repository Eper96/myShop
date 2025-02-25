package com.example.demo.login;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.member.MemberDto;

@Mapper
public interface LoginMapper {
	public String loginOk(MemberDto mdto);

	public String getUserid(MemberDto mdto);

	public String getPwd(MemberDto mdto);

	public void imsiPwdChg(String imsiPwd, String userid, String oldPwd);
	
	public void addCart(String userid, String pcode, String su);
	
	public boolean isCartChk(String userid, String pcode);
	
	public void cartSuUpdate(String userid, String pcode, String su);
}
