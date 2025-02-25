package com.example.demo.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	@GetMapping("/member/member")
	public String member() {
		return service.member();
	}
	
	@GetMapping("/member/useridChk")
	public @ResponseBody String useridChk(HttpServletRequest request) {
		return service.useridChk(request);
		
	}
	
	@PostMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		return service.memberOk(mdto);
	}
	
	@GetMapping("/member/cartView")
	public String cartView(HttpServletRequest request, Model model, HttpSession session) {
		return service.cartView(request,model,session);
	}
	
	@GetMapping("/member/cartDel")
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.cartDel(request,session,response);		
	}
	
	@GetMapping("/member/chgSu")
	public @ResponseBody String chgSu(HttpServletRequest request,
			HttpSession session, HttpServletResponse response) {
		return service.cghSu(request,session,response);
	}
	@GetMapping("/member/jjimList")
	public String jjimList(HttpSession session, Model model) {
		return service.jjimList(session,model);
	}
	@GetMapping("member/jjimDel")
	public String jjimDel(HttpSession session, HttpServletRequest request) {
		return service.jjimDel(session,request);
	}
	@GetMapping("/member/addCart")
	public String addCart(HttpSession session, HttpServletRequest request) {
		return service.addCart(session,request);
	}
	@GetMapping("/member/addCart2")
	public @ResponseBody String addCart2(HttpSession session, HttpServletRequest request) {
		return service.addCart2(session,request);
	}
	@GetMapping("/member/jumunList")
	public String jumunList(HttpSession session, Model model,HttpServletRequest request) {
		return service.jumunList(session,model,request);
	}
	@GetMapping("/member/chgState")
	public String chgState(HttpSession session,GumaeDto gdto) {
		return service.chgState(session,gdto);
	}
	@GetMapping("/member/review")
	public String review(ReviewDto rdto, Model model) {
		return service.review(rdto,model);
	}
	@PostMapping("/member/reviewOk")
	public String reviewOk(ReviewDto rdto, HttpSession session) {
		return service.reviewOk(rdto,session);
	}
	@GetMapping("/member/reviewDelete")
	public String reviewDelete(HttpServletRequest request, HttpSession session) {
		return service.reviewDelete(request,session);
	}
	@GetMapping("/member/reviewUpdate")
	public String reviewUpdate(HttpServletRequest request, HttpSession session
			,Model model) {
		return service.reviewUpdate(request,session,model);
	}
	@PostMapping("/member/reviewUpdateOk")
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session,HttpServletRequest request) {
		return service.reviewUpdateOk(rdto,session,request);
	}
	@GetMapping("/member/memberInfo")
	public String memberInfo(HttpSession session, Model model) {
		return service.memberInfo(session, model);
	}
	@GetMapping("/member/chgEmail")
	public @ResponseBody String chgEmail(HttpSession session,HttpServletRequest request) {
		return service.chgEmail(session,request);
	}
	@PostMapping("/member/chgPhone")
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		return service.chgPhone(request,session);
	}
	@GetMapping("/member/oldPwdChk")
	public @ResponseBody String oldPwdChk(HttpServletRequest request,HttpSession session) {
		return service.oldPwdChk(request,session);
	}
	@PostMapping("/member/chgPwdOnInfo")
	public String chgPwd(HttpServletRequest request,HttpSession session) {
		return service.chgPwd(request,session);
	}
	@GetMapping("/member/baesongList")
	public String baesongList(HttpSession session, Model model) {
		return service.baesongList(session,model);
	}
	@GetMapping("/member/baesongWrite")
	public String baesongWrite() {
		return "member/baesongWrite";
	}
	@GetMapping("/member/reviewList")
	public String reviewList(HttpSession session, Model model) {
		return service.reviewList(session,model);
	}
	@GetMapping("/member/qnaList")
	public String qnaList(HttpSession session, Model model) {
		return service.qnaList(session,model);
	}
	
}
