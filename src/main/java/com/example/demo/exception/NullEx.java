package com.example.demo.exception;

public class NullEx {
	public static void main(String[] args) {
		String str = "java javascript pkc";
		
		str = str.replace("java", "Action");
		
		System.out.println(str);
		
		try {
			int a = 100/0;
		String str2 = null;
		str2 = str2.replace("java", "Action");
		
		System.out.println("str2");
		} catch (NullPointerException e) {
			System.out.println("null은 사용불가");
		}
		
		System.out.println("다음 작업");
	}
}
