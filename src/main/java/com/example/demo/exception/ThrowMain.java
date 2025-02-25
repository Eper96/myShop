package com.example.demo.exception;

public class ThrowMain {
	// try~catch로 한다면
	/* 
	public String chgString(String str) {
		try {
			str=str.replace("aa", "zz");
		} catch(NullPointerException e) {
			str = "null";
		}
		
		return str;
	}
	*/
	
	
	// throw로 한다면
	public String chgString(String str) throws NullPointerException {
		str=str.replace("aa", "zz");

		return str;
	}
}
