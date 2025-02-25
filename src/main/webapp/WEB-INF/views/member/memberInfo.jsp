<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
   section table {
       border-spacing:0px;
    }
    section  table tr td {
       height:40px;
       border-bottom:1px solid #CC723D;
       padding-top:6px;
       padding-bottom:6px;
    }
    section table tr:first-child td {
       border-top:2px solid #FFE08C;
    }
    section table tr:last-child td {
       border-bottom:2px solid #FFE08C;
    }
    section input[type=password] {
    	border-radius:8px;
    	border-color:#CC723D;
    	outline-color:#FFE08C;
    }
    section #emailTr #email {
    	width:200px;
    	height:26px;
    	font-size:16px;
    }
    section #emailTr input[type=button] {
    	width:40px;
    	height:33px;
    	vertical-align:middle;
    }
 </style>
 <script>
 	function chgEmail() {
 		var email = document.getElementById("email").value;
 		var chk = new XMLHttpRequest();
 		chk.onload=function() {
 			if(chk.responseText=="0") {
 				location="../login/login";
 			} else {
 				alert("수정 완료");
 			}
 			
 		}
 		chk.open("get","chgEmail?email="+email);
 		chk.send();
 	}
 	function nPwdChk() {
 		var nPwd = document.cpform.nPwd;
 		var nPwd2 = document.cpform.nPwd2;
 		if (nPwd.value == nPwd2.value) {
 			document.getElementById("pmsg2").innerText="비밀번호 확인 일치";
 			document.getElementById("pmsg2").style.color="blue";
 			document.getElementById("pmsg2").style.fontSize="12px";
 		} else {
 			document.getElementById("pmsg2").innerText="비밀번호 확인 불일치";
 			document.getElementById("pmsg2").style.color="red";
 			document.getElementById("pmsg2").style.fontSize="12px";
 		}
 		
 	}
 	/*
 	function isPwd() {
 		var oldPwd = document.cpform.oldPwd.value;
 		var nPwd = document.cpform.nPwd;
 		var nPwd2 = document.cpform.nPwd2;
 		var chk = new XMLHttpRequest();
 		chk.onload = function() {
 			if (chk.responseText == "0") {
 				location="../login/login";
 			} else if (chk.responseText != "1") {
 				
 				document.getElementById("pmsg").innerText="현재 비밀번호가 일치하지 않습니다.";
 	 			document.getElementById("pmsg").style.color="red";
 	 			document.getElementById("pmsg").style.fontSize="12px";
 			} else {
 				document.getElementById("pmsg").innerText="";
 			}
 		}
 		chk.open("get","oldPwdChk?oldPwd="+oldPwd);
 		chk.send();
 	}
 	*/
 	
 	function pwdCheck(my) {
 		//var oldPwd = document.cpform.oldPwd;
 		var oldPwd = my.oldPwd.value;
 		var nPwd = my.nPwd.value;
 		var nPwd2 = my.nPwd2.value;
 		if (oldPwd.trim().length==0) {
 			alert("현재 비밀번호를 입력하세요.");
 			my.oldPwd.value="";
 			my.oldPwd.focus();
 			return false;
 		}
 			else if (nPwd.trim() != nPwd2.trim()) {
	 			alert("비밀번호 확인이 다릅니다.")
	 			return false;
	 		} else {
	 			return true;
	 		}
 	}
 </script>
</head>
<body>  <!-- member/memberInfo.jsp -->
	<section>
		<table width="800" align="center">
			<caption><h3> 회원 정보 </h3></caption>
			<tr>
				<td width="250"> 아이디 </td>
				<td align="left">|</td>
				<td> ${mdto.userid}</td>
			</tr>
			<tr>
				<td> 이름 </td>
				<td align="left">|</td>
				<td> ${mdto.name}</td>
			</tr>
			<tr id="emailTr">
				<td> 이메일 </td>
				<td align="left">|</td>
				<td>
					<input type="text" id="email" value="${mdto.email}">
					<input type="button" value="수정" onclick="chgEmail()">
				</td>
			</tr>
			<tr>
				<td> 전화번호 </td>
				<td align="left">|</td>
				<td> ${mdto.phone} <input type="button" value="전화번호수정" id="pbtn" onclick="phoneView(this)"> 
						<form id="pform" method="post" action="chgPhone">
						<input type="text" id="phone" name="phone" value="${mdto.phone}">
						<input type="submit" value="수정하기">
						</form>
				</td>
			</tr>
			<tr>
				<td> 보유 적립금 </td>
				<td align="left">|</td>
				<td> <fmt:formatNumber value="${mdto.juk}" type="number" pattern="#,###"/>원</td>
			</tr>
			<tr>
				<td colspan="2"> 비밀번호 변경 </td>
				<td>
					<form name="cpform" method="post" action="chgPwdOnInfo" onsubmit="return pwdCheck(this)">
						현재 비밀번호 <input type="password" name="oldPwd" class="pwd" onblur="isPwd()"> 
						<c:if test="${param.err==0}">
            			<div style="color:red;font-size:12px;">현재 비밀번호가 일치하지 않습니다.</div>
          				</c:if><p>
						새 비밀번호&nbsp;&nbsp;&nbsp; <input type="password" name="nPwd" class="pwd"> <p>
						비밀번호 확인 <input type="password" name="nPwd2" class="pwd" onkeyup="nPwdChk()">&nbsp;<span id="pmsg2" align="center"></span> <p>
						<input type="submit" value="비밀번호 변경">
					</form>
				</td>
			</tr>
		</table>
	</section>
<style>
	section #pform {
		display:none;
	}
	section #phone {
		width:200px;
		height:26px;
		font-size:16px;
	}
</style>
<script>
	function phoneView(my) {
		document.getElementById("pform").style.display="block";
		my.value="수정 취소";
		my.setAttribute("onclick","phoneHide(this)");
		// my.onclick="함수명"; 안됨.
	}
	function phoneHide(my) {
		document.getElementById("pform").style.display="none";
    	my.value="전화번호수정";
    	my.setAttribute("onclick","phoneView(this)");
	}
</script>
</body>
</html>