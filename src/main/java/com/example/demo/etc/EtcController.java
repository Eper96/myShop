package com.example.demo.etc;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class EtcController {
	@Autowired
	private EtcMapper mapper;
	
	@GetMapping("/etc/numberString")
	public String numberString() {
		return "/etc/numberString";
	}
	
	@GetMapping("/etc/menu")
	public String menu() {
		return "/etc/menu";
	}
	@GetMapping("/etc/menu2")
	public String menu2() {
		return "/etc/menu2";
	}
	@GetMapping("/etc/menu3")
	public String menu3() {
		return "/etc/menu3";
	}
	
	@GetMapping("/etc/jsCal")
	public String jsCal() {
		return "/etc/jsCal";
	}
	
	@GetMapping("/etc/jsCal2")
	public String jsCal2() {
		return "/etc/jsCal2";
	}
	
	@GetMapping("/etc/getHoliday")
	public @ResponseBody ArrayList<EtcDto> getHoliday(HttpServletRequest request) {
		int year =Integer.parseInt(request.getParameter("y"));
		int m =Integer.parseInt(request.getParameter("m"));
		String month = String.format("%02d", m);
		
		ArrayList<EtcDto> alist = mapper.getHoliday(year,month);
		
		return alist;
	}
	
	@GetMapping("/etc/node")
	public String node() {
		return "/etc/node";
	}
	
	@GetMapping("/etc/table")
	public String table() {
		return "/etc/table";
	}
	
	
	@GetMapping("/etc/star")
	public String star(Model model) {
		double star = 4.12;
		
		// 노란별 , 반별, 회색별의 갯수를 전달.
		int ystar = 0, hstar = 0, gstar = 0;
		
		// 노란 별의 갯수 => 정수부분의 숫자.
		ystar = (int)star; // 3
		double imsi = star - ystar;
		if (imsi >= 0.8) {
			ystar++;
		} else if (imsi < 0.8 && imsi >= 0.2 ) {
			hstar++;
		}
		
		// 회색별 => 5-(노란별+반별)
		gstar = 5-(ystar+hstar);
		model.addAttribute("ystar",ystar);
		model.addAttribute("hstar",hstar);
		model.addAttribute("gstar",gstar);
		
		return "/etc/star";
	}
	@GetMapping("/etc/chkbox")
	public String chkbox() {
		return "/etc/chkbox";
	}
	
	@GetMapping("/etc/juso")
	public String juso() {
		return "/etc/juso";
	}
	
	@RequestMapping("/etc/form")
	public String form()
	{
		return "/etc/form";
	}
	
	@RequestMapping("/etc/form2")
	public String form2()
	{
		return "/etc/form2";
	}
	
	@RequestMapping("/etc/formOk")
	public void formOk(HttpServletRequest request) {
		String[] pcodes = request.getParameterValues("pcode");
		String[] sus = request.getParameterValues("su");
	}


}
