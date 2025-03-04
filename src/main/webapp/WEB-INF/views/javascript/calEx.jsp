<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script>
  window.onload=function()
  {
	  var today=new Date();      
	  document.getElementById("aa").innerText=today.toString();
	  
	  today=new Date(today.getFullYear(),today.getMonth(),today.getDate());
	  document.getElementById("bb").innerText=today.toString();
  }
    
 
  </script>
</head>
<body>
   today : <span id="aa"></span> <p>
   today2 : <span id="bb"></span>
</body>
</html>