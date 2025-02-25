<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width:1100px;
		margin:auto;
		text-align:center;
		padding-bottom: 80px;
		height:800px;
	}
	section div {
		margin-top:10px;
	}
	section #txt {
		width:420px;
		height:42px;
		border:2px solid #FFE08C;
		border-radius:8px;
		outline:none;
		padding-left:10px;
	}
	section #submit {
		width:435px;
		height:46px;
		background:#FFE08C;
		font-weight:900;
		color:#CC723D;
		border:#FFE08C;
		border-radius:8px;
	}
	section #submit:hover {
		text-decoration:underline;
		cursor:pointer;
	}
	section #txt2 {
       width:200px;
       height:30px;
       border:2px solid #FFE08C;
       outline:none;
       border-radius:8px;
       padding-left:10px;
    }
    section #submit2 {
       width:215px;
       height:33px;
       background:#FFE08C;
       color:CC723D;
       border:#FFE08C;
       border-radius:8px;
    }
    section #uform {
       display:none;
    }
    section #pform {
       display:none;
    }
    section .sear {
    	cursor:pointer;
    }
</style>
<script>
	function viewUform() {
		document.getElementById("uform").style.display="block";
		document.getElementById("pform").style.display="none";
		// 숨겨지는 비밀번호 폼의 입력값이 있을 수 있으므로 숨겨질 때 지운다..! 
		document.getElementById("pform").userid.value="";
		document.getElementById("pform").name.value="";
		document.getElementById("pform").email.value="";
	}
	function viewPform() {
		document.getElementById("pform").style.display="block";
		document.getElementById("uform").style.display="none";
		document.getElementById("uform").name.value="";
		document.getElementById("uform").email.value="";
	}
	
	function getUserid(form) {
		var name = form.name.value;
		var email = form.email.value;
		
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			
			//alert(chk.responseText);
			document.getElementById("uform").style.display="none";
			document.getElementById("uform").name.value="";
			document.getElementById("uform").email.value="";
			document.getElementById("view").innerText="아이디 : " + chk.responseText;
		}
		chk.open("get","getUserid?name="+name+"&email="+email);
		chk.send();
	}
	
	function getPwd(form) {
		
		var userid = form.userid.value;
		var name = form.name.value;
		var email = form.email.value;
		
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			document.getElementById("pform").style.display="none";
			document.getElementById("pform").userid.value="";
			document.getElementById("pform").name.value="";
			document.getElementById("pform").email.value="";
			document.getElementById("view").innerText=chk.responseText;
		}
		chk.open("get","getPwd?name="+name+"&email="+email+"&userid="+userid);
		chk.send();
	}
</script>
</head>
<body>
  <section>
    <h3 align="center"> 로그인 </h3>
    <form method="post" action="loginOk">
    	<input type="hidden" name="pcode" value="${pcode}">
    	<c:if test="${su!=null}">
    	<input type="hidden" name="su" value="${su}">
    	</c:if>
    	<c:if test="${cart!=null}">
    	<input type="hidden" name="cart" value="${cart}">
    	</c:if>
      <div> <input type="text" name="userid" id="txt" placeholder="아이디"> </div>
      <div> <input type="password" name="pwd" id="txt" placeholder="비밀번호"></div>
      <div> <input type="submit" value="로그인" id="submit"> <p>
      		<c:if test="${err==1}">
      			<span id="chkMsg" style="color:red;fontSize:12px;">아이디/비밀번호를 확인해 주세요</span>
      		</c:if>
      <div> 
        <span class="sear" onclick="viewUform()"> 아이디 찾기 </span> &nbsp;&nbsp;&nbsp;
        <span class="sear" onclick="viewPform()"> 비밀번호 찾기 </span>
      </div> 
      </div>
    </form>
    <div id="view"></div>
    <!-- 아이디 찾기 폼 -->
    <form id="uform">
    <h4>아이디 찾기</h4>
    	<div><input type="text" name="name" id="txt2" placeholder="이 름"></div>
    	<div><input type="text" name="email" id="txt2" placeholder="이메일"></div>
    	<div><input type="button" value="아이디찾기" id="submit2" onclick="getUserid(this.form)"></div>
    </form>        
    
    <!-- 비밀번호 찾기 폼 -->
    <form id="pform">
    <h4>비밀번호 찾기</h4>
    	<div><input type="text" name="userid" id="txt2" placeholder="아이디"></div>
    	<div><input type="text" name="name" id="txt2" placeholder="이 름"></div>
    	<div><input type="text" name="email" id="txt2" placeholder="이메일"></div>
    	<div><input type="button" value="비밀번호 찾기" id="submit2" onclick="getPwd(this.form)"></div>
    </form>
  </section>
</body>
</html>