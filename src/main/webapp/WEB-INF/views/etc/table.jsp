<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	td {
		width:50px;
		height:50px;
		border:1px solid black;
	}
</style>
</head>
<body>  <!-- etc/table.jsp -->
<table>
	
	<tr>
	<c:forEach varStatus="sts" begin="1" end="20">
		<td></td>
		<c:if test="${sts.count%4==0}">
			</tr>
			<tr>
		</c:if>
	</c:forEach>
	</tr>
</table>

</body>
</html>