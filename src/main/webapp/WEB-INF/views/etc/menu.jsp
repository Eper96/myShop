<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#sub {
		position:absolute;
		visibility:hidden;
		left:0px;
		top:20px;
		background:gray;
	}
</style>
<script>
	function viewMenu() {
		document.getElementById("sub").style.visibility="visible";
	}
	function hideMenu() {
		document.getElementById("sub").style.visibility="hidden";
	}
</script>
</head>
<body>	<!-- etc/menu.jsp -->
	<ul style="margin:auto;width:200px;padding-left:0xp;background:grey;">
		<li style="position:relative" onmouseover="viewMenu()" onmouseleave="hideMenu()">가전제품
			<ul id="sub">
				<li>TV</li>
				<li>냉장고</li>
				<li>세탁기</li>
				<li>컴퓨터</li>
				<li>청소기</li>
			</ul>
		</li>
	</ul>
<!-- TV,냉장고,세탁기,컴퓨터,청소기 -->
</body>
</html>