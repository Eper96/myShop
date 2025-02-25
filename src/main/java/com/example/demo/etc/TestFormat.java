package com.example.demo.etc;

import java.text.DecimalFormat;

public class TestFormat {
	public static void main(String[] args) {
		
		int price = 1593426;
		int halin = 6;
		int juk = 12;
		
		double halinPrice = price - (price * halin/100.0);
		System.out.println(halinPrice);
		
		double jukPrice = price*juk/100.0;
		System.out.println(jukPrice);
		
		DecimalFormat df = new DecimalFormat("#,###");
		
		System.out.println(df.format(price));
		System.out.println(df.format(halinPrice));
		System.out.println(df.format(jukPrice));
		
	}
}
