<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   function getJung(dae)
   {
	   //alert(document.pform.dae.value);
	   //alert(dae);
	   if(dae=="")
	   {
		   
	   }	
	   else
	   {
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   var jungs=JSON.parse(chk.responseText);
			   
			   document.pform.jung.options.length=jungs.length+1;
			   
			   var i=1;
			   for(jung of jungs)
			   {  
				   document.pform.jung.options[i].value=jung.code;
				   document.pform.jung.options[i].text=jung.name;
				   i++;
			   }	   
		   }
		   chk.open("get","getJung?dae="+dae);
		   chk.send();
	   }	   
   }
   
   function getSo(jung)
   {
	   if(jung=="")
	   {
		   
	   }
	   else
	   {
		   // 대분류코드 읽어오기
		   var dae=document.pform.dae.value;
		   
		   var daejung=dae+jung;
		   
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var sos=JSON.parse(chk.responseText);
			   
			   // select태그의 길이를 정해준다 => 원래있던 소분류는 남겨야 된다
			   
			   document.pform.so.options.length=sos.length+1;
			   var i=1;
			   for(so of sos)
			   {
				   document.pform.so.options[i].value=so.code;
				   document.pform.so.options[i].text=so.name;
				   i++;
			   }	   
		   }
		   chk.open("get","getSo?daejung="+daejung);
		   chk.send();
	   }	   
   }
   
   function getPcode() {
	   // 대,중,소,제 코드를 읽어오기
	   var dae = document.pform.dae.value;
	   var jung = document.pform.jung.value;
	   var so = document.pform.so.value;
	   var company = document.pform.company.value;
	   
	   var pcode = "p" + dae + jung + so + company;
	   
	   var chk = new XMLHttpRequest();
	   chk.onload=function() {
		   document.pform.pcode.value=chk.responseText;
	   }
	   chk.open("get","getPcode?pcode="+pcode);
	   chk.send();
	   
   }
   
   function onlyNum(price) {
	   price.value = price.value.replace(/[^0-9]/g,"");
   }
   
   /*
   function submitChk() {
	   if(isNaN(document.pform.price.value)) {
		   document.pform.price.value="";
	   }
   }
   */
 </script>
</head>
<body> <!-- /admin/proWrite.jsp -->
  <!-- 
    상품등록 : 상품코드 , 상품이미지(메인그림, 상품상세) , 상품명 , 상품가격
             별점, 상품할인율, 수량, 배송비 , 배송기간 , 적립율
   -->
   <form name="pform" method="post" action="proWriteOk" enctype="multipart/form-data" onsubmit="submitChk()">
     <table width="800" align="center">
       <caption> <h3> 상품 등록 </h3> </caption>
       <tr>
         <td> 상품코드 </td>
         <td> 
            <input type="text" name="pcode">
            <select name="dae" onchange="getJung(this.value)">
              <option value=""> 대분류 </option>
             <c:forEach items="${dlist}" var="ddto">
              <option value="${ddto.code}"> ${ddto.name} </option>
             </c:forEach> 
            </select>
            <select name="jung" onchange="getSo(this.value)">
              <option value=""> 중분류 </option>
            </select>
            <select name="so">
              <option value=""> 소분류 </option>
            </select>
            <select name="company">
              <option value=""> 제조회사 </option>
             <c:forEach items="${clist}" var="cdto">
              <option value="${cdto.code}"> ${cdto.name} </option>
             </c:forEach> 
            </select>
            <input type="button" onclick="getPcode()" value="상품코드생성">
         </td>
       </tr>
       <tr>
       		<td> 메인 그림 </td>
       		<td>
       			<input type="file" name="expimg0"> <br>
       			<input type="file" name="expimg1"> <br>
       			<input type="file" name="expimg2"> <br>
       			<input type="file" name="expimg3"> <br>
       		</td>
       </tr>
       <tr>
       		<td> 상세 그림 </td>
       		<td> <input type="file" name="exdimg"> </td>
       </tr>
       <tr>
       		<td> 상 품 명 </td>
       		<td> <input type="text" name="title"> </td>
       </tr>
       <tr>
       		<td> 가 격 </td>
       		<td> <input type="text" name="price" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr>
       		<td> 할 인 율 </td>
       		<td> <input type="text" name="halin" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr>
       		<td> 수 량 </td>
       		<td> <input type="text" name="su" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr>
       		<td> 배 송 비 </td>
       		<td> <input type="text" name="baeprice" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr>
       		<td> 배송 기간(일) </td>
       		<td> <input type="text" name="baeday" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr>
       		<td> 적립률 </td>
       		<td> <input type="text" name="juk" onkeyup="onlyNum(this)"> </td>
       </tr>
       <tr align="center">
       		<td colspan="7"><input type="submit" value="상품등록"></td>
       </tr>
     </table>
   </form>
</body>
</html>









