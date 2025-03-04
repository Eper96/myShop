<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#aa {
		width:50px;
		height:50px;
		background:red;
	}
</style>
<script>
	var n = 0;
	function move2() {
		ss = setTimeout(function(){
			n++;
			document.getElementById("aa").style.marginLeft=n+"px";
			
			if (n<300) {
				move2();
			} else {
				clearTimeout(ss);
			}
		},10); // 0.05초 후에 익명함수를 1번 실행.
	}
	
	function move1() {
		ss = setInterval(function(){ // 변수 선언을 하지 않으면 전역 변수
			n++;
			document.getElementById("aa").style.marginLeft=n+"px";
			
			// 멈추기
			if (n>=300){
				clearInterval(ss);
			}
		},10); // 0.05초 후에 익명함수를 1번 실행.
	}
</script>
</head>
<body> <!-- javascript/setEx.jsp -->
<!-- 
	재귀함수 : 함수 자신을 내부에서 다시 호출
	setTimeout : 1번만 실행
	setInerval : 계속 실행
 -->
	
	<input type="button" onclick="move1()" value="setInerval">
	<input type="button" onclick="move2()" value="setTimeout">
	<hr>
	
	<div id="aa"></div>
</body>
</html>