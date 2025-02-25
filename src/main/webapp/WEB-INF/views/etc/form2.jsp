<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<script>
function test()
{
	  var pcodes=""; //선택된 상품의 상품코드를 ,로 구분하여 문자열로 저장
	  var sus="";    //   "     "   수량을   "   "    "
	  
	  var subChk=document.getElementsByClassName("subChk");
	  var pcode=document.getElementsByClassName("pcode");
	  var su=document.getElementsByClassName("su");
	  
	  for(i=0;i<subChk.length;i++)
	  {
		  if(subChk[i].checked)
		  {
			  pcodes=pcodes+pcode[i].value+",";
			  sus=sus+su[i].value+",";
		  }	  
	  }	  
	  
	  alert(pcodes+" "+sus);
}
</script>
</script>
 
 
</head>
<body> <!-- form2.jsp -->
  <form>
   <input type="button" value="선택구매" onclick="test()">
   <hr>
   
   <input type="checkbox"  class="subChk" onclick="subCheck()">상품1
   <input type="hidden" name="pcode" class="pcode" value="11">
   <input type="text" name="su" class="su">
   <hr>       
   <input type="checkbox"  class="subChk" onclick="subCheck()">상품2
   <input type="hidden" name="pcode" class="pcode" value="22">
   <input type="text" name="su" class="su">
   <hr>       
   <input type="checkbox"  class="subChk" onclick="subCheck()">상품3
   <input type="hidden" name="pcode" class="pcode" value="33">
   <input type="text" name="su" class="su">
   <hr>       
   <input type="checkbox"  class="subChk" onclick="subCheck()">상품4
   <input type="hidden" name="pcode" class="pcode" value="44">
   <input type="text" name="su" class="su">
   <hr>       
   <input type="checkbox" class="subChk" onclick="subCheck()">상품5
   <input type="hidden" name="pcode" class="pcode" value="55">
   <input type="text" name="su" class="su">
   <hr>         
   </form>
</body>
</html>