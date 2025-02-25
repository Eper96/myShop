<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   section {
     width:1100px;
     height:600px;
     margin:auto;
   }
   section table {
     border-spacing:0px;
   }
   section table tr:first-child td {
     height:40px;
     text-align:center;
     border-top:2px solid black;
   }
   section table tr td {
     height:70px;
     text-align:center;
     border-bottom:1px solid black;
   }
   section table tr:last-child td {
     border-bottom:2px solid black;
   }
 </style>
</head>
<body>  <!-- member/qnaList.jsp -->

	<section>
		<table width="1100" align="center">
			<caption><h3>상품 문의</h3></caption>
			<tr>
				<td width="160">상품명</td>
				<td>문의내용</td>
				<td>답변내용</td>
				<td>작성일</td>
				<td>삭제</td>
			</tr>
			<c:forEach items="${mapAll}" var="map">
			<tr>
				<td>${map.ptitle}</td>
				<td>${map.content}</td>
				<td>${map.adminCnt}</td>
				<td>${map.writeday}</td>
				<td><input type="button" value="삭제" onclick="location='../product/qnaDelete?id=${map.id}&ref=${map.r}&chk=1'"></td>
			</tr>
			</c:forEach>
		</table>
	</section>
</body>
</html>