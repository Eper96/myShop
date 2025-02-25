<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function NaNCheck(val) {
		// isNaN() : 숫자가 아니냐 => 숫자 false , 문자 true
		if(isNaN(val)) {
			document.pform.su.value="";
			
		}	
	}
	//var str = "문자문자 english Korean 한국 대한민국"
	//str = str.replace("한국", "일본");
	//str = str.replace(/english/g,"Japanese");
	//alert(str);
	
	var str2 = "1j5lk3j4lk53";
	str2 = str2.replace(/[^0-9]/g,"");
	//alert(str2);
	function chgNumber(my) {
		my.value=my.value.replace(/[^0-9]/g,"");
	}
	
	function chgString(my) {
		my.value = my.value.replace(/[0-9]/g,"");
	}
	
	function chgHan(my) {
		my.value=my.value.replace(/[a-zA-z0-9]/g,"");
	}
	function chgEng(my) {
		my.value=my.value.replace(/[^a-zA-z]/g,"");
	}
</script>
</head>
<body>  <!-- etc/numberString.jsp -->
	<form name="pform">
		수량 <input type="text" name="su" onblur="NaNCheck(this.value)"> <p>
		
		가격 <input type="text" name="price" onkeyup="chgNumber(this)"> <p>
		
		문자만 <input type="text" name="munja" onkeyup="chgString(this)"> <p>
		
		한글만 <input type="text" name="han" onkeyup="chgHan(this)"> <p>
		
		영어만 <input type="text" name="eng" onkeyup="chgEng(this)"> <p>
		<input type="submit" value="저장">
	</form>

</body>
</html>