<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section {
	width: 1100px;
	margin: auto;
	margin-top: 60px;
	position:relative;
}

section #first {
	
}
section #cartLayer {
	position:absolute;
	left:580px;
	top:400px;
	background:white;
	font-size:12px;
	width:200px;
	height:60px;
	border:1px solid #5F0080;
	text-align:center;
	padding-top:5px;
	visibility:hidden;
}
section #cartLayer input {
	font-size:12px;
	background:#5F0080;
	color:white;
	cursor:pointer;
}
section #first #left {
	display: inline-block;
	width: 500px;
	height: 500px;
}

section #first #right {
	display: inline-block;
	width: 590px;
	height: 500px;
	vertical-align: top;
}

section #first #right #starDiv {
	border-bottom: 1px solid #cccccc;
	margin-bottom: 30px;
}

section #first #right div {
	margin-top: 5px;
}

section #first #right #titleDiv {
	font-size: 30px;
	font-weight: 800;
}

section #first #right #titleDiv img {
	margin-left: 15px;
}

section #first #right #halinDiv {
	font-size: 17px;
}

section #first #right #halinDiv s {
	color: #cccccc;
}

section #first #right #halinPriceDiv {
	font-size: 24px;
	color: red;
	border-bottom: 1px solid #cccccc;
	margin-bottom: 30px;
}

section #first #right #baedayStrDiv {
	font-size: 17px;
}

section #first #right #baepriceDiv {
	font-size: 15px;
	border-bottom: 1px solid #cccccc;
	margin-bottom: 30px;
}

section #first #right #jukpriceDiv {
	font-size: 18px;
	border-bottom: 1px solid #cccccc;
	margin-bottom: 30px;
}

section #first #right #number {
	display: inline-block;
	width: 74px;
	height: 26px;
	border: 1px solid #cccccc;
	border-radius: 3px;
	padding-top: 4px;
}

section #first #right #su {
	width: 20px;
	text-align: center;
	border: none;
	outline: none;
	font-size: 15px;
	font-weight: 500;
}

section #first #right #number img {
	cursor: pointer;
	margin-bottom:1px;
}

section #first #right #cartBtn {
	width: 180px;
	height: 32px;
	background: white;
	vartical-align: top;
	color: #5F0080;
	border: 1px solid #5F0080;
	border-radius: 3px;
}

section #first #right #gumaeBtn {
	width: 180px;
	height: 32px;
	background: #5F0080;
	color: white;
	vartical-align: top;
	border: 1px solid #5F0080;
	border-radius: 3px;
}
section #menu {
	width:1100px;
	height:50px;
	margin:auto;
	text-align:center;
	margin-top:50px;
	margin-bottom:20px;
	line-height:50px;
	
}
section #menu ul {
	width:1100px;
	height:50px;
	padding-left:0px;
}
section #menu li {
	display:inline-block;
	list-style-type:none;
	width:270px;
	margin-left:-6px;
	height:50px;
	text-align:center;
	border:1px solid black;
	background:white;
}
section #second {
	
}

section #third {
	
}

section #third .inReview {
	width:1100px;
	height:150px;
	overflow:auto;
	border:1px solid black;
	margin-top:20px;
	padding:10px;
}

section #fourth {
	width:1100px;
	margin:auto;
	margin-top:50px;
}
section #fourth #left {
	float:left;
	font-size:20px;
}

section #fourth #right {
	float:right;
}
section #fourth table {
	cell-spacing:0px;
}
section #fourth table tr td {
	height:50px;
	border-bottom:1px solid black;
}
section #fourth table tr:first-child td {
	border-top:2px solid black;
}
section #fourth table tr:last-child td {
	border-bottom:2px solid black;
}

section #fourth #q {
	background:#cccccc;
	color:white;
	padding:2px;
}
section #fourth #a {
	background:blue;
	color:white;
	padding:2px;
	margin-left:20px;
}
section #fifth {
	width:1100px;
	margin:auto;
	margin-top:60px;
}
section #modal {
	display:none;
	position:fixed;
	left:0px;
	top:0px;
	width:100%;
	height:100%;
	background-color:rgba(0,0,0,0.6);
}
section #qnaForm {
	width:300px;
	height:400px;
	border:1px solid black;
	background:white;
	position:fixed;
	left:300px;
	top:200px;
	visibility:hidden;
}
section #qnaForm form > div {
	text-align:center;
	margin-top:8px;
}
section #qnaForm form > div input[type=submit] {
	width:286px;
	height:30px;
}
section #qnaForm form > div textarea {
	width:280px;
	height:240px;
}

section #qnaForm #ptitle {
	border:none;
	outline:none;
	overflow:hidden;
	width:96%;
	text-align:center;
	font-weight:900;
}

section h3 {
	padding-top:40px;
}
section #menu a {
	text-decoration:none;
	color:black;
}
</style>
<script>
	
	function downSu() {
		var valueSu=document.getElementById("su").value;
		if ( valueSu > 1) {
			document.getElementById("su").value=--valueSu;
		}
		
	}
	
	function upSu() {
		var valueSu=document.getElementById("su").value;
		document.getElementById("su").value=++valueSu;
	
	}
	
	function jjimOk() {
		<c:if test="${userid!=null}">
			// 로그인을 했으면 비동기방식으로 찜테이블에 추가
			var chk = new XMLHttpRequest();
			chk.onload = function() {
				if(chk.responseText=="0") {
					location="../login/login?pcode=${pdto.pcode}";
				} else {
					// 찜테이블에 저장 완료
					document.getElementById("heart").src="../static/jjim2.png";
					document.getElementById("heart").setAttribute("onclick","jjimDelete()");
				}
			}			
			chk.open("get","jjimOk?pcode=${pdto.pcode}");
			chk.send();
		</c:if>
		
		
		<c:if test="${userid==null}">
		// 로그인을 하지 않았으면 login으로 이동.
		location="../login/login?pcode=${pdto.pcode}";
		</c:if>
	}
	
	function jjimDelete() {
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			if (chk.responseText == "0") {
				location="../login/login?pcode=${pdto.pcode}";
			} else {
				document.getElementById("heart").src="../static/jjim1.png";
				document.getElementById("heart").setAttribute("onclick","jjimOk()");
			}
		}
		chk.open("get","jjimDelete?pcode=${pdto.pcode}");
		chk.send();
	}

	function addCart() {	
		var su = document.getElementById("su").value;
		// cart테이블에 비동기방식으로 상품코드, 아이디, 수량을 저장
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			if(chk.responseText != "1") {
				alert("오류발생");
				//location="../login/login?pcode=${pdto.pcode}";	
			} else {
				
				
				// 장바구니 메세지 띄우기
				document.getElementById("cartLayer").style.visibility="visible";
				
				// setTimeout("함수명",시간); = setTimeout(function(){},시간)
				setTimeout(function() {
					document.getElementById("cartLayer").style.visibility="hidden";
				},3000)
			}
			getNum();
		}
		chk.open("get","addCart?pcode=${pdto.pcode}&su="+su);
		chk.send();	
	}
	
	function cookieDel() {
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			
		}
		chk.open("get","cookieDel");
		chk.send();
	}
	function cookieView() {
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			document.getElementById("cookieView").innerText=chk.responseText;
			
		}
		chk.open("get","cookieView");
		chk.send();
	}
	window.onscroll = function() {
		//document.getElementById("ims").innerText=document.documentElement.scrollTop;
		var top = document.documentElement.scrollTop;
		if(top>=790) {
			document.getElementById("menu").style.position="fixed";
			document.getElementById("menu").style.top="-65px";
		} else {
			document.getElementById("menu").style.position="relative";
			document.getElementById("menu").style.top="0px";
		}
	}
</script>
</head>
<body>
	<!-- product/productContent.jsp -->
	<section>
		<div id="cartLayer">현재 상품을 장바구니에 담았습니다. <p>
			<input type="button" value="장바구니로 이동하기" onclick="location='../member/cartView'">
		</div>
		<div id="first">
			<div id="left">
				<img src="../static/product/${pdto.pimg}" width="440" height="440">
			</div>
			<div id="right">
				<div id="titleDiv">
					${pdto.title}
					<c:if test="${jjimChk == 1}">
						<img style="cursor: pointer;" src="../static/jjim2.png"
							onclick="jjimDelete()" id="heart" valign="middle">
					</c:if>
					<c:if test="${jjimChk == 0}">
						<img style="cursor: pointer;" src="../static/jjim1.png"
							onclick="jjimOk()" id="heart" valign="middle">
					</c:if>
				</div>
				<div id="starDiv">
					<c:forEach begin="1" end="${pdto.ystar}">
						<img src="../static/star1.png" width="20">
					</c:forEach>
					<c:forEach begin="1" end="${pdto.hstar}">
						<img src="../static/star3.png" width="20">
					</c:forEach>
					<c:forEach begin="1" end="${pdto.gstar}">
						<img src="../static/star2.png" width="20">
					</c:forEach>
					${pdto.review}개 상품평
				</div>
				<c:if test="${pdto.halin != 0}">
					<div id="halinDiv">${pdto.halin}%
						<s>${pdto.price}</s>
					</div>
				</c:if>
				<div id="halinPriceDiv">${pdto.halinPriceStr}원</div>
				<div id="baedayStrDiv">${pdto.baeDayStr}</div>
				<div id="baepriceDiv">
					<c:if test="${pdto.baeprice == 0}">
				무료배송
				</c:if>
					<c:if test="${pdto.baeprice != 0}">
				배송비 : ${pdto.baePriceStr}원
				</c:if>
				</div>
				<div id="jukpriceDiv">
					<img src="../static/juk.png" valign="middle">${pdto.jukPriceStr}원
					적립
				</div>

				<div>
				  <form method="post" action="productGumae">
				  <input type="hidden" value="${pdto.pcode}" name="pcode">
						<div id="number">
							<img src="../static/minus.png" valign="middle" onclick="downSu()">
							<input type="text" name="su" value="1" id="su" readonly> <img
								src="../static/plus.png" valign="middle" onclick="upSu()">
						</div>
						<input type="button" value="장바구니" id="cartBtn" onclick="addCart()">
						<input type="submit" value="바로구매" id="gumaeBtn"> <p>
						<!-- <input type="button" value="쿠키확인" onclick="cookieView()">
						<div id="cookieView"></div>
						<input type="button" value="cart쿠키변수 삭제" onclick="cookieDel()"> -->
				  </form>
				</div>
				<!-- 수량, 장바구니, 바로구매 -->
			</div>
		<div id="menu"> <!-- 상품정보, 상품문의, 상품평 링크 -->
			<ul>
				<li><a href="#menu1"> 상품상세 </a><span id="ims"></span></li>
				<li><a href="#menu2"> 상품평 </a></li>
				<li><a href="#menu3"> 상품문의 </a></li>
				<li><a href="#menu4"> 배송/교환/반품 </a></li>
			</ul>
		</div>
		</div>
		<!-- 상품이미지,정보 -->
		<div id="second">
			<h3 id="menu1">상품 상세</h3>
			<img src="../static/product/${pdto.dimg}" width="1100">
		</div>
		<!-- 상품상세이미지 -->
		<div id="third">
			<div>
			<h3 id="menu2">상품평</h3>
		      	 <c:forEach begin="1" end="${pdto.ystar}">
		          <img src="../static/star1.png" width="40" valign="middle">
		         </c:forEach>
		         <c:forEach begin="1" end="${pdto.hstar}">
		          <img src="../static/star3.png" width="40" valign="middle">
		         </c:forEach>
		         <c:forEach begin="1" end="${pdto.gstar}">
		          <img src="../static/star2.png" width="40" valign="middle">
		         </c:forEach>
		         ${pdto.review}개 상품평
	    	</div>
	    	
	    	<c:forEach items="${rlist}" var="rdto">
		    	<div class="inReview">
		    	
		    		<c:forEach begin="1" end="${rdto.star}">
		    			<img src="../static/star1.png" width="20">
		    		</c:forEach>
		    		
		    		<c:forEach begin="1" end="${5-rdto.star}">
		    			<img src="../static/star2.png" width="20">
		    		</c:forEach>
		    		<span style="font-size:12px;">(${rdto.writeday})</span>
		    			
			    	<div>${rdto.labeledUserid}</div>
			    	<div>${rdto.title}</div>
			    	<div>${rdto.content}</div>
			    	<div id="upDel" align="right">
			    	  <c:if test="${userid!=rdto.userid}">
			    		신고하기
			    	  </c:if>
			    	  <c:if test="${userid==rdto.userid}">
			    		<a href="../member/reviewUpdate?id=${rdto.id}&pcode=${pdto.pcode}"> 수정 </a> |
			    		 <a href="../member/reviewDelete?id=${rdto.id}&pcode=${pdto.pcode}&gid=${rdto.gid}"> 삭제 </a>
			    	  </c:if>
			    	</div>
		    	</div>
	    	</c:forEach>
		</div>
		<!-- 상품평 -->
		<div id="fourth">
			<div>
				<div id="left"><h3 id="menu3">상품문의</h3></div>
				<div id="right"><input type="button" value="문의하기" onclick="qnaView()"></div>
			</div> <!-- 상품문의 + 링크 -->
			<div>
			<table width="1100" align="center">
				<c:forEach items="${qlist}" var="qdto">					
						<tr>
							<td width="100">
								<c:if test="${qdto.qna == 1}">
								  <span id="q">질문</span>
								</c:if>
								<c:if test="${qdto.qna == 2}">
								  →<span id="a">답변</span>
								</c:if>
							</td>  <!-- 질문인지 답변인지 출력하는 부분 -->
							<td width="150"> ${qdto.userid} </td>  <!-- 질문자 -->
							<td> ${qdto.content} 
							</td>  <!-- 질문 내용 -->			
							<td width="150"> ${qdto.writeday} </td>  <!-- 작성일 -->
							<c:if test="${userid==qdto.userid}">
								<td><a href="qnaDelete?id=${qdto.id}&pcode=${qdto.pcode}">삭제</a></td>
							</c:if>				
							<c:if test="${userid!=qdto.userid}">
								<td><span></span></td>
							</c:if>
						</tr>					
				</c:forEach>
				</table>
			</div>
		</div>
		<!-- 상품문의 -->
		<div id="fifth"> 
			<h3 id="menu4"> 배송/교환/반품 안내 </h3>
			<img src="../static/change.png" width="1100"> 
		</div>
		<!-- 배송/교환/반품관련 -->
		
		<div id="modal">
			<div id="qnaForm">
				<form method="post" action="qnaWriteOk">
				<input type="hidden" name="pcode" value="${pdto.pcode}">
				<div> 상품명 <input type="text" value="${pdto.title}" name="ptitle" id="ptitle" readonly> </div>
				<div> <textarea name="content" id="qnaContent" maxlength="200" onkeyup="wordLen(this)"></textarea> </div>
				<div>총 글자 수(<span id="chongWord">0</span>)</div>
				<div> <input type="submit" value="문의저장"> </div>
				</form>	
			</div>
		</div>
	</section>
<script>
	function qnaView() {
		// 브라우저의 가로 세로를 구해서 id="qnaForm"을 중앙에 위치 시키기
		var w = window.innerWidth;
		var h = window.innerHeight;
		w = w/2;
		h = h/2;
		w = w - 150;
		h = h - 200;
		document.getElementById("qnaForm").style.left=w+"px";
		document.getElementById("qnaForm").style.top=h+"px";
		
		document.getElementById("qnaForm").style.visibility="visible";
		
		document.getElementById("modal").style.display="block";
	}
	function wordLen(my) {
		var len = my.value.trim().length;
		document.getElementById("chongWord").innerText=len;
	}
</script>
</body>
</html>