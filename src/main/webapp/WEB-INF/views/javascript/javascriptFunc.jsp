<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check() {
		alert("클릭1");
	}
	
	window.onload = function() {
		document.getElementById("aa").onclick=function(){
			alert("클릭2");
		};
		
		document.getElementById("bb").addEventListener("click",function(){
			alert("클릭3");
		});
	}
</script>
</head>
<body> <!-- javascript/javascriptFunc.jsp -->
<!-- 
   자바스크립트 함수를 실행하는 방법
   1. 태그내에 이벤트핸들러="함수명()"
   2. script태그내에 DOM방식으로 요소를 부른뒤 이벤트를 추가하는 방법
      - addEventListener을 사용을 O , X
 -->
	<div onclick="check()"> 클릭1 </div>
	<div id="aa"> 클릭2 </div>
	<div id="bb"> 클릭3 </div>
</body>
</html>