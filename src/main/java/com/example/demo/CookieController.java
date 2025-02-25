package com.example.demo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RestController
public class CookieController {
	@Autowired
	private CookieMapper mapper;
	
	@GetMapping("/firstCookie")
	public String firstCookie(HttpServletResponse response) {
		
		try {
			// x를 눌렀다는 표시로 쿠키변수를 생성
			Cookie cookie = new Cookie("fcook","1");
			cookie.setMaxAge(30);
			cookie.setPath("/");	// 쿠키의 경로
			response.addCookie(cookie);
			
			return "1";
		} catch(Exception e) {
			return "0";
		}
	}
	
	@GetMapping("/fcookOk")
	public String fcookOk(HttpServletRequest request) {
		
		Cookie cookie = WebUtils.getCookie(request, "fcook");
		
		if (cookie == null) {
			return "0";
		} else {
			return "1";
		}
	}
	
	@GetMapping("/getDae")
	public ArrayList<DaeDto> getDae() {
		
		return mapper.getDae();
	}
	
	@GetMapping("/getJung")
	public ArrayList<JungDto> getJung(HttpServletRequest request) {
		int imsi = Integer.parseInt(request.getParameter("daecode"));
		String daecode = String.format("%02d", imsi);
		return mapper.getJung(daecode);
	}
	
	@GetMapping("/getSo")
	public ArrayList<SoDto> getSo(HttpServletRequest request) {
		int imsi = Integer.parseInt(request.getParameter("daejung"));
		String daejung = String.format("%04d", imsi);
		
		return mapper.getSo(daejung);
		
	}
	
	@GetMapping("/getCartNum")
	public String getCartNum(HttpSession session,HttpServletRequest request) {
		
		if (session.getAttribute("userid")==null) {
			Cookie cookie = WebUtils.getCookie(request,"cart");
			/*
			String pcodes = cookie.getValue();
			String[] imsi = pcodes.split("/");
			String num = imsi.length+"";
			return num;
			*/
			if (cookie==null || cookie.getValue().equals("")) {
				return "0";
			} else {
				return cookie.getValue().split("/").length+"";
			}
		} else {
			String userid = session.getAttribute("userid").toString();
			return mapper.getCartNum(userid);
		}
	}
}
