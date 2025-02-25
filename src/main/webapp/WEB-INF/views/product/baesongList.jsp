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
body {
    font-family: 'Arial', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

#container {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    padding: 15px;
    width: 300px;
    margin-bottom: 15px;
    text-align: left;
    border: 1px solid #ddd;
}

#container > div {
    padding: 5px 0;
    border-bottom: 1px solid #eee;
}

#container > div:last-of-type {
    border-bottom: none;
    text-align: right;
}

#container .name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
}

#container .juso, 
#container .phone, 
#container .reqStr {
    font-size: 14px;
    color: #555;
}

#gibon {
    display: inline-block;
    background: #5F0080;
    color: white;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 5px;
}

#container [type=button] {
    color: white;
    background: #5F0080;
    padding: 6px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: 0.2s;
}
#container .baeId {
	display:none;
}
#container [type=button]:hover {
    background: #4a0066;
}

#submitDiv {
    margin-top: 20px;
}

#submitBtn {
    width: 150px;
    height: 40px;
    font-size: 16px;
    font-weight: bold;
    color: #5F0080;
    background: white;
    border: 2px solid #5F0080;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#submitBtn:hover {
    background: #5F0080;
    color: white;
}
</style>
<script>
	function jusoJundal(n) {
		opener.document.getElementById("name").innerText=document.getElementsByClassName("name")[n].innerText;
		opener.document.getElementById("juso").innerText=document.getElementsByClassName("juso")[n].innerText;
		opener.document.getElementById("phone").innerText=document.getElementsByClassName("phone")[n].innerText;
		opener.document.getElementById("reqStr").innerText=document.getElementsByClassName("reqStr")[n].innerText;
		opener.document.getElementById("baeId").value=document.getElementsByClassName("baeId")[n].value;
		close();
		
	}
	function upJuso() {
		
	}
	
	function delJuso() {
		
	}
</script>
</head>
<body>  <!-- product/baesongList.jsp -->
	<c:forEach items="${blist}" var="bdto" varStatus="sts">
		<div id="container">
			<div class="name">${bdto.name}</div>
			<div class="juso">${bdto.juso} ${bdto.jusoEtc}</div>
			<div class="phone">${bdto.phone}</div>
			<div class="reqStr">${bdto.reqStr}</div>
			<input type="hidden" name="baeId" class="baeId" value="${bdto.id}">
			<c:if test="${bdto.gibon==1}">
				<div><span id="gibon">기본배송지</span></div>
			</c:if>
			<div><input type="button" value="수정" onclick="location='baesongUpdate?id=${bdto.id}'"></div>
			<div><input type="button" value="삭제" onclick="location='baesongDelete?id=${bdto.id}'"></div>
			<div><input type="button" value="선택" onclick="jusoJundal(${sts.index})"></div>
		</div>
	</c:forEach>
	<div id="submitDiv"><input id="submitBtn" type="button" value="배송지 추가" onclick="location='baesongWrite'"></div>
</body>
</html>