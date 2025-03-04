<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.onload = function() {
		document.getElementById("bb").addEventListener("click",function(){
			alert("한 번 만")
		},{
			once:true
		});
		
	}
	
	var chk = 0;
	function check() {
		if(chk==0) {
			alert("한 번만 실행");
		}
		chk=1;
	}
</script>
</head>
<body> <!-- javascript/javascriptFunc3.jsp -->
<!-- 
    함수를 1번만 실행하고 끝
 -->
 
  <div id="aa" onclick="check()">클릭2</div>
  <div id="bb">클릭3</div>

</body>
</html>