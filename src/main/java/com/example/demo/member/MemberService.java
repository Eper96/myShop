package com.example.demo.member;

import org.springframework.ui.Model;

import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface MemberService {

	public String member();

	public String useridChk(HttpServletRequest request);

	public String memberOk(MemberDto mdto);

	public String cartView(HttpServletRequest request, Model model, HttpSession session);

	public String cartDel(HttpServletRequest request, HttpSession session,HttpServletResponse response);

	public String cghSu(HttpServletRequest request,HttpSession session,HttpServletResponse response);

	public String jjimList(HttpSession session, Model model);

	public String jjimDel(HttpSession session, HttpServletRequest request);

	public String addCart(HttpSession session, HttpServletRequest request);
	
	public String addCart2(HttpSession session, HttpServletRequest request);

	public String jumunList(HttpSession session, Model model, HttpServletRequest request);

	public String chgState(HttpSession session, GumaeDto gdto);

	public String review(ReviewDto rdto,Model model);

	public String reviewOk(ReviewDto rdto, HttpSession session);

	public String reviewDelete(HttpServletRequest request, HttpSession session);

	public String reviewUpdate(HttpServletRequest request, HttpSession session, Model model);

	public String reviewUpdateOk(ReviewDto rdto, HttpSession session, HttpServletRequest request);

	public String memberInfo(HttpSession session, Model model);

	public String chgEmail(HttpSession session, HttpServletRequest request);

	public String chgPhone(HttpServletRequest request, HttpSession session);

	public String oldPwdChk(HttpServletRequest request, HttpSession session);

	public String chgPwd(HttpServletRequest request, HttpSession session);

	public String baesongList(HttpSession session, Model model);

	public String reviewList(HttpSession session, Model model);

	public String qnaList(HttpSession session, Model model);


}
