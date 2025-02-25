package com.example.demo.exception;

public class ArithException {
	public static void main(String[] args) {
		try {
		
		int total = 390;
		int num = 0;
		
		int result = total / num;
			System.out.println(result);		
		} catch(ArithmeticException e) {	// try문에 발생할 예외를 예외별로 처리할 수 있다. 
			System.out.println("0으로 나누기 불가능");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		System.out.println("다음 작업");
	}
}
