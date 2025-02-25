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
		width:40px;
		height:30px;
	}
	
	table tr td:first-child {
		color:red;
	}
	table tr td:last-child {
		color:blue;
	}
	caption {
		font-size:12px;
	}
</style>
<script>
	// 달력 만들기 => 1일의 요일, 총 일수, 몇 주
	function genCal(y,m,x) {	// 자바스크립트 지역변수에 var을 제외하고 선언 시 => 전역변수
		document.getElementById("cal").style.visibility="visible";
		if(!y || y == 0) {
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
		var calender = "<table width='140' border='1'>";
		calender += "<caption>";
		calender += "<a href='javascript:genCal("+y+","+(m-1)+","+x+")'> 이전 </a>";
		calender += y + "년" + (m + 1) + "월";
		calender += "<a href='javascript:genCal("+y+","+(m+1)+","+x+")'> 다음 </a>";
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
					calender +="<td class='redday' onclick='getDays("+y+","+(m)+","+day+","+x+")'>" + day + "<br><span class='reddayName'></span></td>";					
					day++;
				}
			}
			
			calender += "</tr>";
			
		}
		calender += "</table>";
		//id=cal인 곳에 innerHTML
		document.getElementById("cal").innerHTML=calender;
		
		
	}
	function getDays(y,m,d,x) {
		// td가 클릭되면 해당 위치의 년,월,일을 text에 전달 => 2025-01-01
		m++;
		m=m+"";
		d=d+"";
		
		m = m.padStart(2,"0");
		d = d.padStart(2,"0");
		/*
		if (m.length == 1) {
			m = "0" + m;
		}
		if (d.length == 1) {
			d = "0" + d;
		}
		*/
		var days = y + "-" + m + "-" + d;
		if (x==1){
			document.getElementById("start").value=days;
		} else {
			document.getElementById("end").value=days;
		}
		
			document.getElementById("cal").style.visibility="hidden";
		
	}
</script>
<style>
	#form {
		position:relative;
		width:400px;
		margin:auto;
	}
	
	#form #cal {
		position:absolute;
		
	}
</style>
</head>
<body>	<!-- etc/jsCal.jsp -->
	<!-- 
		1. type="text"에 커서가 들어오면 달력이 보이기
		2. 날짜를 선택하면 년-월-일이 text에 들어감
		3. 달력을 숨기기
	 -->
	<div id="form">
		<input type="text" name="start" placeholder="시작일" onfocus="genCal(0,0,1)" id="start">
		<input type="text" name="end" placeholder="완료일" onfocus="genCal(0,0,0)" id="end">
		
		<div id="cal"></div>
	</div>
</body>
</html>