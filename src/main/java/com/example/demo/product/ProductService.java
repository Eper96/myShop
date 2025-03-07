package com.example.demo.product;

import org.springframework.ui.Model;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.QnaDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface ProductService {

	public String productList(HttpServletRequest request, Model model);

	public String productContent(HttpServletRequest request, Model model,HttpSession session);

	public String jjimOk(HttpServletRequest request, HttpSession session);

	public String jjimDelete(HttpServletRequest request,HttpSession session);

	public String addCart(CartDto cdto,HttpSession session,HttpServletRequest request, HttpServletResponse response);

	public String productGumae(HttpSession session, HttpServletRequest request, Model model);

	public String baesongWrite();

	public String baesongWriteOk(BaesongDto bdto, HttpSession session);

	public String baesongList(HttpSession session, Model model);

	public String gumaeOk(GumaeDto gdto, HttpSession session , HttpServletRequest request);

	public String gumaeList(HttpServletRequest request, HttpSession session, Model model);

	public String qnaWriteOK(QnaDto qdto, HttpServletRequest request,HttpSession session);

	public String qnaDelete(QnaDto qdto,HttpServletRequest request);

	String baesongUpdateOk(BaesongDto bdto, HttpSession session);

	String baesongUpdate(HttpServletRequest request, HttpSession session, Model model);

	String baesongDelete(HttpServletRequest request, HttpSession session);

}
