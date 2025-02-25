<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border-spacing:0px;
		border:1px solid black;
		border-collapse:collapse;
	}
	table td {
		border:1px solid black;
		text-align:center;
		width:50px;
		height:40px;
	}
	
	table tr td:first-child {
		color:red;
	}
	table tr td:last-child {
		color:blue;
	}
</style>
<script>
	// 달력 만들기 => 1일의 요일, 총 일수, 몇 주
	function genCal(y,m) {	// 자바스크립트 지역변수에 var을 제외하고 선언 시 => 전역변수
		
		if(!y) {
			var today = new Date();	// 오늘의 날짜객체를 생성
			y = today.getFullYear();	// 4자리 연도
			m = today.getMonth();	// 0~11의 값으로 나온다. 1월이니 0이 나온다.
		}
		
		if (m == -1 ) {
			m = 11;
			y--;
		} 
		if (m == 12) {
			m = 0;
			y++;
		}
		// 이번 달 1일의 객체를 구하려면 => new Date(년,월,일);
		var xday = new Date(y,m,1);
		
		// 요일
		var dow = xday.getDay(); // 0~6까지의 값. (일~토)
		
		// 총일수 구하기 => 배열을 이용
		var month = [31,28,31,30,31,30,31,31,30,31,30,31]; // 인덱스와 getMonth()의 값이 0~11로 같다.
		var totalDay = month[m];
		
		// 윤년일 경우 2월달 => 29일
		if (m==1) { // 2월일때는 윤년을 계산
			if ( (y%4 == 0 && y%100 != 0) || y&400 == 0 ) {// 윤년이라면
				totalDay++;
			}
			
		}
		
	 	// 몇주인가 
		var weeks = Math.ceil((totalDay + dow)/7);
		
		
		
		
		// 변수에 달력을 위한 태그를 누적
		var calender = "<table width='300' border='1'>";
		calender += "<caption>";
		calender += "<a href='javascript:genCal("+y+","+(m-1)+")'> 이전 </a>";
		calender += y + "년" + (m + 1) + "월";
		calender += "<a href='javascript:genCal("+y+","+(m+1)+")'> 다음 </a>";
		calender += "</caption>";
		calender += "<tr>";
		calender += " <td> 일 </td>";
		calender += " <td> 월 </td>";
		calender += " <td> 화 </td>";
		calender += " <td> 수 </td>";
		calender += " <td> 목 </td>";
		calender += " <td> 금 </td>";
		calender += " <td> 토 </td>";
		calender += "</tr>";
		 
		var day = 1;
		for (i=0; i < weeks; i++) {
			calender += "<tr>";
			
			for (j=0; j < 7; j++) {
				if ( (i == 0 && j < dow) || (totalDay < day) ) {
					calender += "<td> </td>";
				} else {
					calender +="<td class='redday'>" + day + "<br><span class='reddayName'></span></td>";
					day++;
				}
			}
			
			calender += "</tr>";
			
		}
		calender += "</table>";
		//id=cal인 곳에 innerHTML
		document.getElementById("cal").innerHTML=calender;
		
		// 휴일의 값을 가져와서 달력에 표시하기 => 비동기방식을 이용하여 holiday테이블에서 이번달의 휴일을 읽어온다. 
		var chk = new XMLHttpRequest();
		chk.onload = function() {
				var jsCals = JSON.parse(chk.responseText);
				var imsi;
				for (jsCal of jsCals) {
					
					if (imsi == jsCal.dday) {	// 이전의 날짜와 같은지 확인 
						var n = jsCal.dday - 1;
						document.getElementsByClassName("reddayName")[n].innerHTML=document.getElementsByClassName("reddayName")[n].innerHTML+"<br>"+jsCal.title;
					} else {
						var n = jsCal.dday - 1;
						document.getElementsByClassName("redday")[n].style.color="red";
						document.getElementsByClassName("reddayName")[n].innerText=jsCal.title;
						document.getElementsByClassName("reddayName")[n].style.fontSize="12px";
					}
					
					imsi = jsCal.dday;

				}
			
			//document.getElementById("err").innerText=chk.responseText;
		}
		
		chk.open("get","getHoliday?y="+y+"&m="+(m+1));
		chk.send();
		
	}
	
	function srcView() {
		document.getElementById("src").innerText=document.getElementById("cal").innerHTML;
	}
</script>
</head>
<body>	<!-- etc/jsCal.jsp -->
	<input type="button" onclick="genCal()" value="달력생성">
	<input type="button" onclick="srcView()" value="소스보기">
	<hr>
	
	<div id="cal"></div>
	<hr>
	<div id="src"></div>
	<div id="err"></div>
</body>
</html>