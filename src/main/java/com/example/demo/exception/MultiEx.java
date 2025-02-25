package com.example.demo.exception;

public class MultiEx {
	public static void main(String[] args) {		
		try {
			int total = 390;
			int num = 2;
			int result = total/num;
			System.out.println(result);
			
			String str2= "java javascript pkc";
			str2 = str2.replace("java", "Action");
			System.out.println(str2);
			
			int[] num2=new int[6];
	       	num2[0]=100;
	       	//num2[6]=99;
	       	
	       	String bb="33a";
            int n=Integer.parseInt(bb);
            System.out.println(n);
            
            
		} catch(ArithmeticException e) { // 무조건 발생할 예외클래스를 사용해야 한다. 
			System.out.println("0으로 나누는 일이 발생함");
			
		} catch (NullPointerException e) {
			System.out.println("null은 실행 불가");
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("배열을 초과");
		} catch (Exception e) {	// 예외클래스의 최상위 클래스 => 모든 예외를 다 받는다. 
			System.out.println("모든 예외를 처리합니다.");
		}
       	System.out.println("다음 작업");
	}
}
