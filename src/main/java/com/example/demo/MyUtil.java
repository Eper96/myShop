package com.example.demo;

import java.text.DecimalFormat;
import java.time.LocalDate;

import com.example.demo.dto.ProductDto;

public class MyUtil {
	public static String getNewPwd2() {
		String newPwd = "";
		for (int i = 1; i <= 6; i++) {
			int num = (int) (Math.random() * 90); // 0~89까지의 정수
			// (33~47)특수문자 , (48~57)숫자 (58~64)특수문자 ,
			// (65~90)대문자, (91~96)특수문자 , (97~122)소문자

			num = num + 33;

			newPwd = newPwd + (char) num;
		}

		return newPwd;
	}

	/*
	 * // 별점을 실수로 받은 뒤 노란별, 반별, 회색별의 갯수를 구하기 public static int[] getStar(double
	 * star) { // 노란별, 반별, 회색별의 갯수를 생성하여 dto에 저장. int ystar = 0, hstar = 0, gstar =
	 * 0; ystar = (int) star; double imsi = star - ystar; if (imsi > 0.8) { ystar++;
	 * } else if (imsi >= 0.2) { hstar++; } gstar = 5 - (ystar + hstar);
	 * 
	 * // ystar, hstar, gstar 가 생성 => 배열로 리턴 int[] stars = new int[3]; stars[0] =
	 * ystar; stars[1] = hstar; stars[2] = gstar;
	 * 
	 * return stars; }
	 */

	public static void getStar(ProductDto pdto) {
		// 노란별, 반별, 회색별의 갯수를 생성하여 dto에 저장.
		double star = pdto.getStar();
		int ystar = 0, hstar = 0, gstar = 0;
		ystar = (int) star;
		double imsi = star - ystar;
		if (imsi > 0.8) {
			ystar++;
		} else if (imsi >= 0.2) {
			hstar++;
		}
		gstar = 5 - (ystar + hstar);
		// ystar, hstar, gstar 가 생성 => Dto로 리턴
		pdto.setYstar(ystar);
		pdto.setHstar(hstar);
		pdto.setGstar(gstar);
	}

	/*
	 * public static String getBaesong(int baeday) { LocalDate today =
	 * LocalDate.now();
	 * 
	 * // 오늘 날짜에서 minus(), plus()메소드를 이용하여 며칠 전, 후의 날짜를 생성. LocalDate xday =
	 * today.plusDays(baeday); // => 배송 도착일 (오늘 + 배송일) int m = xday.getMonthValue();
	 * // 월 int d = xday.getDayOfMonth(); // 일 int dd =
	 * xday.getDayOfWeek().getValue(); String dow = null; switch (dd) { case 1: dow
	 * = "월"; break; case 2: dow = "화"; break; case 3: dow = "수"; break; case 4: dow
	 * = "목"; break; case 5: dow = "금"; break; case 6: dow = "토"; break; case 7: dow
	 * = "일"; break; } String baeDayStr = ""; if (baeday == 1) { baeDayStr = "내일(" +
	 * dow + ") 도착예정"; } else if (baeday == 2) { baeDayStr = "모레(" + dow + ") 도착예정";
	 * } else { baeDayStr = m + "/" + d + "(" + dow + ") 도착예정"; }
	 * 
	 * // 가장 편한 방법은 Dto로 보내는 것. return baeDayStr; }
	 */

	public static void getBaesong(ProductDto pdto) {
		LocalDate today = LocalDate.now();
		int baeday = pdto.getBaeday();
		// 오늘 날짜에서 minus(), plus()메소드를 이용하여 며칠 전, 후의 날짜를 생성.
		LocalDate xday = today.plusDays(baeday); // => 배송 도착일 (오늘 + 배송일)
		int m = xday.getMonthValue(); // 월
		int d = xday.getDayOfMonth(); // 일
		int dd = xday.getDayOfWeek().getValue();
		String dow = null;
		switch (dd) {
		case 1:
			dow = "월";
			break;
		case 2:
			dow = "화";
			break;
		case 3:
			dow = "수";
			break;
		case 4:
			dow = "목";
			break;
		case 5:
			dow = "금";
			break;
		case 6:
			dow = "토";
			break;
		case 7:
			dow = "일";
			break;
		}
		String baeDayStr = "";
		if (baeday == 1) {
			baeDayStr = "내일(" + dow + ") 도착예정";
		} else if (baeday == 2) {
			baeDayStr = "모레(" + dow + ") 도착예정";
		} else {
			baeDayStr = m + "/" + d + "(" + dow + ") 도착예정";
		}
		pdto.setBaeDayStr(baeDayStr);
	}
	
	public static String comma(int num) {
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(num);
	}
	
	public static String getState(int num)
	{
		String str;
		switch(num)
		{
		    case 0: str="결제완료"; break;
		    case 1: str="배송준비"; break;
		    case 2: str="취소신청"; break;
		    case 3: str="취소완료"; break;
		    case 4: str="배송중"; break;
		    case 5: str="배송완료"; break;
		    case 6: str="반품신청"; break;
		    case 7: str="반품완료"; break;
		    case 8: str="교환신청"; break;
		    case 9: str="교환완료"; break;
		    default: str="오류";
		}
		
		return str;
	}
	
}
