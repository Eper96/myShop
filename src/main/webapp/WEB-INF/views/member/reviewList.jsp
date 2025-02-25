<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <!-- member/reviewList.jsp -->
 <section>
   <table width="1100" align="center">
     <caption> <h3> 상품평 목록 </h3> </caption>
     <tr>
       <td> 상품명 </td>
       <td> 별 점 </td>
       <td> 한줄평 </td>
       <td> 상품평 </td>
       <td> 작성일 </td>
       <td> 수정/삭제 </td>
     </tr>
    <c:forEach items="${mapAll}" var="map">
     <tr>
       <td> ${map.ptitle} </td>
       <td> 
         <c:forEach begin="1" end="${map.star}"> <!-- 노란별 -->
           <img src="../static/star1.png" width="16">
         </c:forEach>
         <c:forEach begin="1" end="${5-map.star}"> <!-- 회색별 -->
           <img src="../static/star2.png" width="16">
         </c:forEach>
       </td>
       <td> ${map.title} </td>
       <td> ${map.content} </td>
       <td> ${map.writeday} </td>
       <td> 
         <input type="button" value="수정" onclick="location='reviewUpdate?chk=1&id=${map.id}&pcode=${map.pcode}'">
         <input type="button" value="삭제" onclick="location='reviewDelete?chk=1&id=${map.id}&pcode=${map.pcode}&gid=${map.gid}'">
       </td>
     </tr>
    </c:forEach>
   </table>
 </section>
</body>
</html>