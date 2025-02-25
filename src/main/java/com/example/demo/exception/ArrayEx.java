package com.example.demo.exception;

public class ArrayEx {
	public static void main(String[] args) {
		
		
		int[] num = new int[6];
		
		
		try {
			num[0] = 100;
			num[6] = 99;
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("예외처리 함");
		}
		
		
		for (int i = 0; i < num.length; i++) {
			System.out.println(num[i]);
		}
	}
}
