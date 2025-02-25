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
      width:480px;
      margin:auto;
   }
   section form div {
      width:480px;
      margin:auto;
      margin-top:8px;
   }
   section input[type=text] {
      width:460px;
      height:30px;
      border:1px solid green;
   }
   section input[type=button] {
      width:93px;
      height:35px;
      vertical-align:middle;
      background:green;
      color:white;
      border:1px solid green;
      font-size:16px;
      border:1px solid green;
   }
   section input[type=submit] {
      width:466px;
      height:35px;
      background:green;
      color:white;
      border:1px solid green;
      font-size:16px;
   }
   section select {
      width:466px;
      height:35px;
      border:1px solid green;
   }
   section input[type=checkbox] {
      border:1px solid green;
      width:16px;
      height:16px;
   }
   
   section #zip{
      width:360px;
      height:30px;
   }
 </style>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script>
  function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
  {
    new daum.Postcode({
        oncomplete: function(data) {
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.pkc.zip.value = data.zonecode; // 우편번호
          document.pkc.juso.value = addr;  // 주소
          // 커서를 상세주소 필드로 이동한다.
          document.pkc.jusoEtc.focus();
      }
    }).open();
  }
  
  window.onload=function()
  {
	  document.pkc.req.value=${bdto.req};
  }
 </script> 
</head>
<body> <!-- product/baesongUpdate.jsp -->
  <section>
   <form name="pkc" method="post" action="baesongUpdateOk">
   	<c:if test="${param.ck != null}">
   	<input type="hidden" name="ck" value="${param.ck}">
   	</c:if>
    <input type="hidden" name="id" value="${bdto.id}">
    <h3 align="center"> 배송지 수정 </h3>
    <div> <input type="text" name="name" placeholder="받는 사람" value="${bdto.name}"> </div>
    <div>
      <input type="text" name="zip" id="zip" placeholder="우편번호" readonly value="${bdto.zip}">
      <input type="button" value="주소찾기" onclick="juso_search()">
    </div>
    <div> <input type="text" name="juso" readonly placeholder="주 소" value="${bdto.juso}"> </div>
    <div> <input type="text" name="jusoEtc" placeholder="상세주소" value="${bdto.jusoEtc}"> </div>
    <div> <input type="text" name="phone" placeholder="전화번호" value="${bdto.phone}"> </div>
    <div> 
      <select name="req">
        <option value="0"> 문 앞 </option>
        <option value="1"> 직접 받고 부재시 문 앞</option>
        <option value="2"> 경비실 </option>
        <option value="3"> 택배함 </option>
        <option value="4"> 기 타 </option>
      </select>
    </div>
    <div>
     <c:if test="${bdto.gibon==1}">
       <c:set var="ck" value="checked"/>
     </c:if>
      <input type="checkbox" ${ck} name="gibon" value="1">
      기본 배송지로 선택합니다.
    </div>
    <div> <input type="submit" value="배송지 수정"> </div>
   </form>
  </section>
</body>
</html>












