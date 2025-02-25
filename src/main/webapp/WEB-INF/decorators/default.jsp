<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	
	body {
		font-family: 'GmarketSansMedium';
		margin:0px;
	}
	#fouter {
		width:100%;
		height:40px;
		background:#FFE08C;		
	}
	#fouter #xx {
       cursor:pointer;
       color:#CC723D;
    }
	#fouter #first {
		width:1100px;
		height:40px;
		margin:auto;
		background:#FFE08C;
	}
	
	#fouter #first #left {
		display:inline-block;
		width:1000px;
		height:40px;
		line-height:40px;
		text-align:center;
		color:#CC723D;
	}
	
	#fouter #first #right {
		display:inline-block;
		width:80px;
		height:40px;
		line-height:40px;
		text-align:right;
		color:white;
	}
	
	header {
		width:1100px;
		height:75px;
		margin:auto;
	}
	
	header #logo {
		display:inline-block;
		width:250px;
		height:75px;
		line-height:75px;
	}
	
	header #search {
		display:inline-block;
		width:440px;
		height:75px;
		line-height:75px;
	}
	header #search #searchForm {
		width:370px;
		height:44px;
		border:2px solid #FFE08C;
		line-height:44px;
		border-radius:15px;
		text-align:center;
		margin-left:28px;
	}			
	header #search #searchForm input[type=text] {
		width:280px;
		border:none;
		outline:none;
		margin-left:10px;
	}
	
	header #search #searchForm #searchImg {
		width:20px;
		margin-right:5px;
	}
	
	header #memMenu {
		display:inline-block;
		width:370px;
		height:75px;
		line-height:75px;
		text-align:right;
	}
	header #memMenu #cartNum {
		color:#CC723D;
		background:#FFE08C;
		padding:1px 4px 0px 2px;
		border-radius:10px;
	}
	header #xpng {
		visibility:hidden;
	}
	header #myMain {
		position:relative;
		z-index:100;
	}	
	header #mySub {
		position:absolute;
		left:-10px;
		top:3px;
		padding-left:0px;
		border:1px solid #FFE08C;
		background:white;
		visibility:hidden;
		
	}	
	header #mySub > li {
		list-style-type:none;
		width:90px;
		height:30px;
		line-height:30px;
		text-align:center;
		border:1px solid #FFE08C;	
		border-bottom:none;
		color:#CC723D;	
	}
	header #mySub > li a {
		text-decoration:none;
		color:#CC723D;
	}
	header #mySub > li:last-child {
		border-bottom:1px solid #FFE08C;
	}
	nav {
	 	width:1100px;
	 	height:60px;
	 	margin:auto;

	}	 
	
	nav > ul {
		padding-left:0px;
	}
	
	nav > ul > li {
		display:inline-block;
		width:150px;
		height:60px;
		line-height:60px;
	}
	nav > ul > li:first-child {
		width:240px;
	}
	
	nav > ul > li:last-child {
		width:220px;
		text-align:right;
	}
	
	nav #category {
		position:relative;
		display:inline-block;
		width:100px;
		height:26px;
		line-height:26px;
		text-align:center;
		z-index:1;
	}
	
	nav #category #daeMenu {
		position:absolute;
		left:0px;
		top:26px;
		padding-left:0px;
		background:#fedcba;
		visibility:hidden;
	}
	
	nav #category #daeMenu li {
		list-style-type:none;
		width:100px;
		height:25px;
		line-height:25px;
		text-align:center;
		position:relative;
	}
	
	nav #category #daeMenu > li .jungMenu {	/* 중분류 ul태그*/
		position:absolute;
		left:100px;
		top:0px;
		padding-left:0px;
		background:#fedcba;
       	visibility:hidden;
		
	}
	nav #category #daeMenu > li .jungMenu > li {
		list-style-type:none;
		width:100px;
		height:26px;
		line-height:26px;
		text-align:center;
		position:relative;
	}
	
	nav #category #daeMenu > li .jungMenu > li > .soMenu {
		position:absolute;
		left:100px;
		top:0px;
		padding-left:0px;
		background:#fedcba;
       	visibility:hidden;
	}
	nav #category #daeMenu > li .jungMenu > li > .soMenu >li {
		list-style-type:none;
		width:100px;
		height:26px;
		line-height:26px;
		text-align:center;
	}
	footer {
       width:1100px;
       height:150px;
       margin:auto;
    }
    
	header > a {
		text-decoration:none;
		color:black;
	}
	header #memMenu > a {
		text-decoration:none;
		color:black;
	}
	nav #mainMenu #category a {
		text-decoration:none;
		color:black;
	}

</style>
<script>
	var h = 40;
	function fclose() {
		// id="fouter"내의 모든 내용 숨기기
		//document.getElementById("fouter").style.display="none";
		ss=setInterval(function() {
			h--;
			document.getElementById("fouter").style.height=h+"px";
			document.getElementById("first").style.height=h+"px";
			if(h==0){
				clearInterval(ss);
				document.getElementById("fouter").style.display="none";
			}
		},10)
		
		// 쿠키변수에 사용자가 x를 클릭하였을 때 정보저장 후 안보여주기
		
		var chk = new XMLHttpRequest();
		chk.onload=function() {
			if(chk.responseText=="0") {
				alert("오류");
			}
		}
		chk.open("get","../firstCookie");
		chk.send();
	}
	
	// dsfault.jsp는 모든 페이지가 다 사용한다.
	// 비동기방식으로 접근
	
	window.onload=function() {
		// 쿠키를 체크하여 보여줄지 말지를 결정한다.
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			var n = chk.responseText;
			if(n=="1") {
				document.getElementById("fouter").style.display="none";
			}
		}
		chk.open("get","../fcookOk");
		chk.send();
		// 장바구니의 갯수를 가져와서 출력하기
		getNum();
	}
	
	

	
	function getNum() {
		var chk = new XMLHttpRequest();
		chk.onload = function(){
			document.getElementById("cartNum").innerText=chk.responseText;
		}
		chk.open("get","../getCartNum");
		chk.send();
	}
	
	function chgX(val) {
		if(val.length == 0) {
			document.getElementById("xpng").style.visibility="hidden";
		} else {
			document.getElementById("xpng").style.visibility="visible";
			
		}
	}
	
	 function hideTxt() {
	    	document.getElementById("sword").value="";
	    	document.getElementById("xpng").style.visibility="hidden";
	    }
	 var daeChk = 0;
	 
	 function viewDae() {
		 document.getElementById("daeMenu").style.visibility="visible";
		 if (daeChk == 0){
			 var chk = new XMLHttpRequest();
			 chk.onload = function() {
				 var daes = JSON.parse(chk.responseText);
				 var str = "";
				 for ( dae of daes ) {
					 str = str + "<li onmouseover='viewJung("+dae.code+")' onmouseout='hideJung("+dae.code+")'><a href='../product/productList?pcode=p"+dae.code+"'>"+dae.name+"</a><ul class='jungMenu'></ul> </li>";
				 }
				 
				 document.getElementById("daeMenu").innerHTML=str;
				 daeChk=1;
			 }
			 chk.open("get","../getDae");
			 chk.send();
		 }
		
	 }
	 function hideDae() {
		 document.getElementById("daeMenu").style.visibility="hidden";
		 
	 }
	 
	 var jungChk = [0,0,0,0,0,0,0];
	 
	 function viewJung(daecode) {
		 document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="visible";
		 
		 if(jungChk[daecode-1]==0){
			 var chk = new XMLHttpRequest();
			 chk.onload = function() {
				var jungs = JSON.parse(chk.responseText);
				var str = "";
				for (jung of jungs) {
					str = str + "<li onmouseover='viewSo(this,"+daecode+jung.code+")' onmouseout='hideSo(this)'><a href='../product/productList?pcode=p"+jung.daecode+jung.code+"'>"+jung.name+"</a><ul class='soMenu'></ul> </li>";
				}
				document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
				jungChk[daecode-1] = 1;
			 }
			 chk.open("get","../getJung?daecode="+daecode);
			 chk.send();
			 
		 }
	 }
	 
	 function hideJung(daecode) {
	 		 document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="hidden";
	 }
	 
	 function viewSo(my,daejung) {
		 my.childNodes[1].style.visibility="visible";
	 if (my.childNodes[1].innerHTML==""){
			var chk = new XMLHttpRequest();
			chk.onload = function() {
				//alert(chk.responseText);
				var sos = JSON.parse(chk.responseText);
				var str = "";
				for (so of sos) {
					str += "<li><a href='../product/productList?pcode=p"+so.daejung+so.code+"'>" + so.name + "</a></li>";
				}
				my.childNodes[1].innerHTML=str;
			}
			chk.open("get","../getSo?daejung="+daejung);
			chk.send();
		 }
	 }
	 
	 function hideSo(my) {
		 my.childNodes[1].style.visibility="hidden";		 
	 }
	 
	 function viewMy() {
		 document.getElementById("mySub").style.visibility="visible";
	 }
	 
	 function hideMy() {
		 document.getElementById("mySub").style.visibility="hidden";
	 }
</script>
<sitemesh:write property="head"/>
</head>
<body>  <!-- default.jsp -->
	<div id="fouter">
		<div id="first">
			<div id="left">회원가입하고 50%할인 쿠폰 받아가기</div>
			<div id="right"> <span id="xx" onclick="fclose()"> X </span></div>
		</div>
	</div>
<header>
	<div id="logo"><a href="../main/main"><img src="../static/We are Glampers-logo.png" width="200" valign="middle"></a></div>
		<div id="search">
			<div id="searchForm">
				<input type="text" name="sword" id="sword" placeholder="검색어를 입력하세요" onkeyup="chgX(this.value)">
				<img src="../static/x.png" valign="middle" id="xpng" onclick="hideTxt()">
				<img src="../static/search.png" valign="middle" id="searchImg">
			</div>
		</div>
	<div id="memMenu">
		<a href="../member/cartView">장바구니(<span id="cartNum"></span>)</a> |
		<c:if test="${userid == null}">
		<a href="../login/login">로그인</a> |
		<a href="../member/member">회원가입</a> | 
		</c:if>
		
		<c:if test="${userid != null}">
		<span id="myMain" onmouseover="viewMy()" onmouseout="hideMy()">${name}님
			<ul id="mySub">
				<li> <a href="../member/jjimList">찜리스트</a> </li>
				<li> <a href="../member/memberInfo"> 회원정보 </a></li>
				<li> <a href="../member/jumunList">주문내역</a> </li>
				<li><a href="../member/baesongList"> 배송지정보 </a></li>
				<li> <a href="../member/reviewList"> 상품평 관리 </a></li>
				<li> <a href="../member/qnaList"> 문의내역 </a></li>
			</ul>
		</span> |
		<a href="../login/logout">로그아웃</a> | 
		</c:if>
		고객센터
	</div>
</header>


<nav>
	<ul id="mainMenu">
		<li> 
			<span id="category" onmouseover="viewDae()" onmouseout="hideDae()">카테고리 
				<ul id="daeMenu">
				</ul>
			</span>
		</li>
		<li> 신상품 </li>
		<li> 베스트 </li>
		<li> 알뜰쇼핑 </li>
		<li> 특가/혜택 </li>
		<li> 샛별하루배송 </li>
	</ul>
</nav>

<sitemesh:write property="body"/>

<footer><img src="../static/footer.png"> </footer>

</body>
</html>