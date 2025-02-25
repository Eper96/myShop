package com.example.demo.dto;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id,price,halin,su,baeprice,baeday,juk,pansu,review,sales;
	private String pcode,pimg,dimg,title,writeday,salesDay;
	private double star;
	// 배송예정일 필드
	private String baeDayStr;
	
	// 별점 필드
	private int ystar,gstar,hstar;
	
	// 할인금액, 적림금 필드
	private String priceStr, halinPriceStr, jukPriceStr;
	
	// 배송비 필드
	private String baePriceStr;
	
	// 장바구니 날짜가 오늘 날짜랑 같은지 저장하는 필드
	private int wchk;
	
}
