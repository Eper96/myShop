<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	
	function check() {
		try {
			test2();
		} catch(err) {
			alert(err.message);
		}
		
		alert("오류발생 이후 실행");
	}
	
	function test() {
		alert("test정상실행");
	}
</script>
</head>
<body> <!-- javascript/exception.jsp -->

   <input type="button" value="클릭" onclick="check()">

</body>
</html>