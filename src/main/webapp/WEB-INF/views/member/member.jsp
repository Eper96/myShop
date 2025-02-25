<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		margin-bottom:60px;
	}
	section div {
		margin-top:15px;
	}
	section #mform {
		margin:auto;
	}
	section #txt {
		width:420px;
		height:42px;
	}
	section .email {
		width:130px;
		height:42px;
	}
	section #select {
		width:132px;
		height:48px;
		border:2px solid #FFE08C;
		border-radius:5px;
	}
	section #submit {
		width:427px;
		height:46px;
		background:#FFE08C;
		color:#CC723D;
	}
	section input {
		border-radius:5px;
		border:2px solid #FFE08C;
		outline:none;
	}
	section #emailInput {
		vartical-align:middle;
	}
</style>
<script>
	function useridChk(userid) {
		
		if(userid.length < 4) {
			document.getElementById("idMsg").innerText="4자 이상 입력하세요";
			document.getElementById("idMsg").style.color="orange";
			document.getElementById("idMsg").style.fontSize="12px";
			uchk=0;
		} else {
			var chk = new XMLHttpRequest();
			chk.onload = function() {
				if (chk.responseText == 0) {
					document.getElementById("idMsg").innerText="사용가능한 아이디";
					document.getElementById("idMsg").style.color="blue";
					document.getElementById("idMsg").style.fontSize="12px";
					uchk=1;
				} else {
					document.getElementById("idMsg").innerText="사용 불가능한 아이디";
					document.getElementById("idMsg").style.color="red";
					document.getElementById("idMsg").style.fontSize="12px";
					uchk=0;
				}
			}
			chk.open("get","useridChk?userid=" + userid);
			chk.send();
		}
	}
	var uchk=0;
	var pchk=0;
	function check() {
		var emailOk = document.memForm.uid.value + "@" + document.memForm.server.value;
		document.memForm.email.value=emailOk;
		if (uchk == 0) {
			return false;
			} else if(pchk==0) {
				return false;
			} else if (document.memForm.name.value=="") {
				return false;
			} else if (document.memForm.phone.value.length == 0) {
				return false
			} else {
				
				return true;
			}
	}
	
	function pwdSame() {
		var pwd1 = document.memForm.pwd.value;
		var pwd2 = document.memForm.pwd2.value;
		
		if (pwd2.length != 0) {
			if (pwd1==pwd2) {
				document.getElementById("pwdMsg").innerText="비밀번호가 일치합니다.";
				document.getElementById("pwdMsg").style.color="blue";
				document.getElementById("pwdMsg").style.fontSize="12px";	
				pchk=1;
			} else {
				document.getElementById("pwdMsg").innerText="비밀번호가 일치하지 않습니다.";
				document.getElementById("pwdMsg").style.color="red";
				document.getElementById("pwdMsg").style.fontSize="12px";	
				pchk=0;
			}
		}
		
	}
	
	function getServer(my) { // my=document.memForm.dserver
		
		//alert(my.value);
		document.memForm.server.value = my.value;
		
	}
</script>
</head>
<body>
	<section>
		<div>
			<form method="post" action="memberOk" onsubmit="return check()" name="memForm">
			<input type="hidden" name="email">
			  <h3> 회원 가입 </h3>
				<div>
					<input type="text" name="userid" id="txt" onblur="useridChk(this.value)" placeholder="아이디(4자 이상)">
					<p> <span id="idMsg"></span>
				</div>
				<div> <input type="text" name="name" id="txt" placeholder="이 름"> </div>
				<div> <input type="password" name="pwd" id="txt" onkeyup="pwdSame()" placeholder="비밀번호"> </div>
				<div>
					<input type="password" name="pwd2" id="txt" onkeyup="pwdSame()" placeholder="비밀번호 확인">
					<p> <span id="pwdMsg"></span>
				</div>
				<div id="emailInput">
					<input type="text" name="uid" class="email">@<input type="text" name="server" class="email">
					<select name="dserver" id="select" onchange="getServer(this)">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="coupang.com">coupang.com</option>
					</select>
				</div>
				<div> <input type="text" name="phone" id="txt" placeholder="전화번호"> </div>
				<div> <input type="submit" value="회원가입" id="submit"> </div>
			</form>
		</div>
	</section>

</body>
</html>