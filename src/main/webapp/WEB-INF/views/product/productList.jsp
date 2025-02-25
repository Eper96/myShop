<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	section {
		width:1100px;
		margin:auto;
	}
	#star {
		letter-spacing:-3px;
		line-height:15px;
		margin-left:0px;
	}
	#star > img {
		width:15px;
		height:15px;
		valign:middle;	
	}
	section #halinDiv {
		font-size:12px;
	}
	section #halinDiv s {
		color:#cccccc;
	}
	section #halinPriceDiv {
		font-size:17px;
		color:red;
	}
	
	section > table {
		border-spacing:20px;
	}
	section > table tr td {
		border:2px solid white;
		vertical-align:top;
	}
	section > table tr td:hover {
		border:2px solid #cccccc;
	}
	
	section > table tr td div:first-child{
		text-align:center;
		overflow:hidden;
		width:250px;
		height:250px;
	}
	section > table tr td div {
		margin-top:4px;
	}
	
   @keyframes pkc {
   		0% { transform:scale(1,1);}
   		100% { transform:scale(1.2,1.2);}
   }
   @keyframes pkc2 {
      	0% { transform:scale(1.2,1.2); }
	  	100% { transform:scale(1,1); }
   }
   
   section #pageDiv {
		text-align:center;
   }
   section #pageDiv a:hover {
		text-decoration:underline;
		color:white;
   }
   section #nowPg:hover {
   		color:white;
   }
   section .pageLink {
   		width:50px;
   		height:50px;
   }
   section .pageLink:hover {
   		background:#5F0080;
   }
   section #orderList {
   		text-align:right;
   }
   section #orderLst a {
   		text-decoration:none;
   		color:black;
   		font-size:12px;
   }
   section #orderList a:hover {
   		text-decoration:underline;
   		font-weight:900;
   		color:#5F007F;
   }
</style>
<script>
	function exOver(my) {
		my.style.animationName="pkc";
		my.style.animationDuration="0.5s";
		my.style.animationFillMode="forwards";
	}
	function exOut(my) {
		my.style.animationName="pkc2";
		my.style.animationDuration="0.5s";
		my.style.animationFillMode="forwards";
	}
	window.onpageshow = function() {
		
		document.getElementsByClassName("nowOrder")[${order-1}].style.fontWeight="900";
		document.getElementsByClassName("nowOrder")[${order-1}].style.color="#5F007F";
	}
</script>	
</head>
<body> <!-- product/productList.jsp -->
<section>
	<div id="menuList">${menuList}</div>
	<div id="orderList">
		<a class="nowOrder" href="productList?pcode=${pcode}&page=${page}&order=1">판매량순</a> |
		<a class="nowOrder" href="productList?pcode=${pcode}&page=${page}&order=2">가격높은순</a> |
		<a class="nowOrder" href="productList?pcode=${pcode}&page=${page}&order=3">가격낮은순</a> |
		<a class="nowOrder" href="productList?pcode=${pcode}&page=${page}&order=4">별점높은순</a> |
		<a class="nowOrder" href="productList?pcode=${pcode}&page=${page}&order=5">최신순</a> |
	</div>
	<table align="center" width="1100">
	<tr>
		<c:forEach items="${plist}" var="pdto" varStatus="sts">
			<td onclick="location='productContent?pcode=${pdto.pcode}'">	
				<div><img src="../static/product/${pdto.pimg}" onmouseover="exOver(this)" onmouseout="exOut(this)" width="250" height="250"></div>
				
				<c:if test="${pdto.baeprice==0}">
					<div>무료 배송</div>
				</c:if>
				
				<div id="title">${pdto.title}</div>
				<c:if test="${pdto.halin != 0}">
					<div id="halinDiv">${pdto.halin}% <s>${pdto.price}</s></div>
				</c:if>
				<div id="halinPriceDiv">${pdto.halinPriceStr}원</div>
				<div>${pdto.baeDayStr}</div>
				<div id="star">
					<c:forEach begin="1" end="${pdto.ystar}">
					<img src="../static/star1.png">
					</c:forEach>
					<c:forEach begin="1" end="${pdto.hstar}">
					<img src="../static/star3.png">
					</c:forEach>
					<c:forEach begin="1" end="${pdto.gstar}">
					<img src="../static/star2.png">
					</c:forEach>
				</div>
				<div>
				  
					<c:if test="${pdto.juk != 0}">
						<span id="outline" style="border:1px solid #444444;font-size:12px;border-radius:10px;padding:3px;">
						<img src="../static/juk.png" width="17" valign="middle">
						최대 ${pdto.jukPriceStr}
						원 적립
						 </span>
					</c:if>
				 	
				</div>		
			</td>
			<c:if test="${sts.count%4==0}">
			</tr><tr>
			</c:if>
				<!-- jstl의 format이용하기 -->
	<c:if test="false">
		<fmt:formatNumber value="${pdto.price}" type="number" pattern="#,###"/>
		<fmt:formatNumber value="${pdto.price-(pdto.price*pdto.halin/100)}" type="number" pattern="#,###"/>
		<fmt:formatNumber value="${(pdto.price-(pdto.price*pdto.halin/100))*(pdto.juk/100)}" type="number" pattern="#,###"/>
	</c:if>
		</c:forEach>
	</tr>	
	</table>
	<div id="pageDiv">
		<c:if test="${pstart > 1}">
			<span class="pageLink"><a href="productList?pcode=${pcode}&page=${pstart-1}">이전</a></span>
		</c:if>
		<c:if test="${!(pstart > 1)}">
			<span class="pageLink">이전</span>
		</c:if>
		<c:forEach begin="${pstart}" end="${pend}" var="i">
			<c:if test="${page == i}">
				<span class="pageLink" id="nowPg" style="border:1px solid blue;">${i}</span>
			</c:if>
			<c:if test="${!(page == i)}">
			<span class="pageLink"><a href="productList?pcode=${pcode}&page=${i}">${i}</a></span>
			</c:if>
		</c:forEach>
		<c:if test="${pend < totalPg}">
			<span class="pageLink"><a href="productList?pcode=${pcode}&page=${pend+1}">다음</a></span>
		</c:if>
		<c:if test="${pend >= totalPg}">
			<span class="pageLink">다음</span>
		</c:if>
	</div>
</section>
</body>
</html>