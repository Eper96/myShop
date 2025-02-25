<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>  <!-- etc/star.jsp -->
 ${ystar} : ${hstar} : ${gstar}
<hr>
<c:forEach begin="1" end="${ystar}">
<img src="../static/star1.png">
</c:forEach>
<c:forEach begin="1" end="${hstar}">
<img src="../static/star3.png">
</c:forEach>
<c:forEach begin="1" end="${gstar}">
<img src="../static/star2.png">
</c:forEach>
</body>
</html>