<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   function start() {
	ss = setInterval(function() {
		   
		   var xday=new Date("2025-3-04 12:03:40"); // 마감일
		   var today = new Date(); // 현재 시간
		   
		   var endTime = xday-today;
		   
		   // 초 단위
		   console.log("1/1000초 : " + endTime);
		   
		   if (endTime > 0) {
			   
			   endTime = Math.floor(endTime/1000);
			   console.log("초 : " + endTime);
			   
			   // 초의 값을 저장
			   var sec = twoString(endTime%60);
			   endTime = Math.floor(endTime/60);
			   console.log("분 : " + endTime);
			   
			   var min = twoString(endTime%60);
			   
			   endTime = Math.floor(endTime/60);
			   console.log("시 : " + endTime);
			   
			   var hour = twoString(endTime%60);
			   
			   endTime = Math.floor(endTime/24);
			   
			   document.getElementById("aa").innerText=endTime + "일 " + hour + "시 " + min + "분 " + sec + "초";

		   } else {
			   clearInterval(ss);
			   document.getElementById("aa").innerText= "마감!";
		   }
		},1000);
	}
   
   // 오늘 값을 두 자리로 만드는 함수
   
   function twoString(num) {
	   num=num+"";
	   return num.padStart(2,"0");
   }
 </script>
</head>
<body> <!-- javascript/getTime -->

  <input type="button" onclick="start()" value="클릭"> 
  <hr>
  <div id="aa"></div>

</body>
</html>