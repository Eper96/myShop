package com.example.demo.exception;

public class FinallyEx {
	public static void main(String[] args) {
		
		int total = 390;
		int num = 0;
		try {
		int result = total / num;
			System.out.println(result);		
		} catch(ArithmeticException e) {	 
			System.out.println("0으로 나누기 불가능");
		} finally { // 예외가 발생 해도 안해도 무조건 실행되는 구문
					// 해당 구문은 try구문과 연관되어 있는 구문이다.
					// try문에 묶어서 정리를 할 수 있다는 뜻.
			System.out.println("finally 실행");
		}
		
		System.out.println("다음 작업");
	}
}
