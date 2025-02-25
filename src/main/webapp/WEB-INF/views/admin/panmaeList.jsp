<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>  <!-- admin/panmaeList -->

	<table width="1100" align="center">
		<caption><h2>판매 목록</h2></caption>
		
		<tr>
			<td>구매자</td>
			<td>구매상품</td>
			<td>상품명</td>
			<td>배송주소</td>
			<td>상 태</td>
		</tr>
		<c:forEach items="${mapAll}" var="map">
		<tr>
			<td>${map.userid}</td>
			<td><img src="../static/product/${map.pimg}" width="40" height="40"></td>
			<td width="400">${map.title}</td>
			<td>${map.juso}</td>
			<td>${map.stateStr}</td>
			<td>
				<c:if test="${map.state==0}">
					<input type="button" value="배송준비" onclick="location='chgState?state=1&id=${map.id}'">
				</c:if>
				
				<c:if test="${map.state==1}">
					<input type="button" value="배송중" onclick="location='chgState?state=4&id=${map.id}'">
				</c:if>
				
				<c:if test="${map.state==4}">
					<input type="button" value="배송완료" onclick="location='chgState?state=5&id=${map.id}'">
				</c:if>
				
				<c:if test="${map.state==2}">
					<input type="button" value="취소완료" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
				
				<c:if test="${map.state==6}">
					<input type="button" value="반품완료" onclick="location='chgState?state=7&id=${map.id}'">
				</c:if>
				
				<c:if test="${map.state==8}">
					<input type="button" value="교환완료" onclick="location='chgState?state=9&id=${map.id}'">
				</c:if>

			</td>
		</tr>
		</c:forEach>
	</table>

</body>
</html>