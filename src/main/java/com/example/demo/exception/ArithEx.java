package com.example.demo.exception;

public class ArithEx {
	public static void main(String[] args) {
		
		// 예외처리 : 잘못된 동작이 발생 시 전체 프로그램을 중지시키지 않고 계속 진행하도록 하는 것.
		// 1. try~catch
		// 2. throws
		
		// 이클립스 툴에서 예외처리를 알려주는 부분(빨간 줄), 알려주지 않는 예외도 많다. 
		
		
		// 모든 숫자를 나눌 떄 0으로 나눌 수는 없다. 
		int total = 390;
		int num = 0;
		
		int result = total / num;
		System.out.println(result);
		
		System.out.println("다음 작업");
	}
}
