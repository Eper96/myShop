<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check() {
		alert("check함수 실행");
	}
	
	window.onload = function() {
		document.getElementById("aa").onclick=check;
		
		document.getElementById("bb").addEventListener("click",check);
		
		document.getElementById("cancel").onclick=function(){
			document.getElementById("bb").removeEventListener("click",check);
		}
	}
</script>
</head>
<body> <!-- javascript/javascriptFunc2.jsp -->

	<div onclick="check()"> 클릭1 </div>
	<div id="aa"> 클릭2 </div>
	<div id="bb"> 클릭3 </div>
	<hr>
	
	<input type="button" value="id=bb인 요소 이벤트 제거" id="cancel">
</body>
</html>