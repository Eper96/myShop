package com.example.demo.exception;

public class ThrowClass {
	
	public static void main(String[] args) {
		String str = "aabbccddabdcaa";
		System.out.println(str);
		ThrowMain tm = new ThrowMain();
		str = tm.chgString(str);
		System.out.println(str);
		
		String str2;
		try { 
			str2 = null;
			tm.chgString(str2);
			System.out.println(str2);
		} catch (NullPointerException e) {
			str2 = "null입니다.";
			System.out.println(str2);
		}
		System.out.println("다음작업");
		
	}
}
