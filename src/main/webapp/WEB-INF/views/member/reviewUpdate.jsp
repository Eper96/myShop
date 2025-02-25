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
	section form > div {
		text-align:center;
		margin-top:30px;
	}
	section #title {
		width:600px;
		height:30px;
	}
	section #content {
		width:600px;
		height:250px;
	}
	section #submit {
		width:606px;
		height:34px;
		margin:auto;
	}
</style>
<script>
	function chgStar(n) {
		var star = document.getElementsByClassName("star");
		for (i=0;i<=n;i++) {
			star[i].src="../static/star1.png";
		}
		for (i=n+1;i<star.length;i++) {
			star[i].src="../static/star2.png";
		}
		document.rform.star.value=n+1;
	}
	window.onpageshow=function() {
		var len = ${rdto.star};
		var star = document.getElementsByClassName("star");
		
		for (i=0;i<len;i++) {
			star[i].src = "../static/star1.png";
		}
	}
</script>
</head>
<body> <!-- review.jsp -->
	<section>
		<form name="rform" method="post" action="reviewUpdateOk">
			<c:if test="${chk != null}">
				<input type="hidden" name="chk" value="1">
			</c:if>
			<input type="hidden" name="id" value="${rdto.id}"> <!-- rdto의 id필드에 저장 -->
			<input type="hidden" name="pcode" value="${rdto.pcode}">
			<input type="hidden" name="star" value="${rdto.star}">
			<h3 align="center"> 상품평 수정하기 </h3>
			<div>
				<img src="../static/star2.png" onclick="chgStar(0)" class="star">
        		<img src="../static/star2.png" onclick="chgStar(1)" class="star">
        		<img src="../static/star2.png" onclick="chgStar(2)" class="star">
				<img src="../static/star2.png" onclick="chgStar(3)" class="star">
        		<img src="../static/star2.png" onclick="chgStar(4)" class="star">
			</div>	<!-- 별점 -->	
			<div> <input type="text" style="fontSize=20px;" name="title" value="${rdto.title}" placeholder="한줄 제목 입력"> </div>	<!-- 한줄평 -->
			<div> <textarea name="content" id="content" placeholder="상품평 내용을 적어주세요">${rdto.content} </textarea> </div>	<!-- 내용 -->
			<div><input type="submit" id="submit" value="상품평 수정"></div>
		</form>
	</section>
</body>
</html>