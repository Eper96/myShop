<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function view() {
		var imsi = document.getElementById("aa");
		
		//alert(imsi.childNodes.length);
		
		imsi.childNodes[1].innerText = "1번";
		imsi.childNodes[1].style.color = "red"; 
		
	}
</script>
</head>
<body>	<!-- etc/node.jsp -->
	<input type="button" onclick="view()" value="클릭"> <hr>
	<div id="aa">ㅎㅎ히ㅣ낄낄<b>잉잉잉</b>하하호호</div>
	
	

</body>
</html>