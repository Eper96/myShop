<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#aa {
		width:100%;
		height:40px;
		background:red;
		matgin:auto;
	}
</style>
<script>
	var h = 40;
	function hide() {
		ss=setInterval(function(){ // setInterval(함수명,시간); setInterval(function(){},시간);
			h--;
			document.getElementById("aa").style.height=h+"px";
			if(h==0) {
				clearInterval(ss)
			}
		},10)
	
	}
</script>
</head>
<body>	<!-- slide.jsp -->

<div id="aa">안녕하세요 <span onclick="hide()">X</span></div>

</body>
</html>