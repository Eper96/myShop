<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    section {
      width:1100px;
      margin:auto;
      font-family: 'GmarketSansMedium';
      margin-bottom:100px;
    }
    section .pro {
      width:1100px;
      height:50px;
      line-height:50px;
      border:1px solid #cccccc;
    }
    section table tr td{
      padding-left:10px;
    }
    section tr:last-child td {
      width:550px;
      height:200px;
      vertical-align:top;
      border-bottom:1px solid #cccccc;
      border-left:1px solid #cccccc;
    }
    section tr:last-child td:first-child {
      border-left:none;
    }
    section tr:last-child td div {
      margin-top:10px; 
    }
    section table .hpro{
      display:none;
    }
    section .bleft , section .pleft {
      display:inline-block;
      width:130px;
    }
    section #title {
      font-size:20px;
      font-weight:900;
    }
    section h3 {
      font-size:22px;
    }
  </style>
  <script>
  	function viewHpro(my) {
  		document.getElementsByClassName("hpro")[my].style.display="table-row";
  		document.getElementsByClassName("upBtn")[my].style.display="inline";
  		document.getElementsByClassName("downBtn")[my].style.display="none";
  	}
  	
  	function hideHpro(my) {
  		document.getElementsByClassName("hpro")[my].style.display="none";
  		document.getElementsByClassName("upBtn")[my].style.display="none";
  		document.getElementsByClassName("downBtn")[my].style.display="inline";
  	}
  </script>
</head>
<body>
  <section>
    <h3 align="left"> 주문완료 </h3>
    <hr>
    <div align="center" style="height:50px;line-height:50px;"> 주문이 완료되었습니다. 감사합니다. </div>
    <hr>
    <table width="1100" align="center">
      <caption> <h3 align="left"> 상품 배송 정보 </h3></caption>
      <c:forEach items="${plist}" var="pdto" varStatus="sts">
        <tr>
         <td colspan="2" class="pro"> 
           <div style="float:left;"> ${pdto.baeDayStr} (상품 ${pdto.su}개) </div>
           <div style="float:right;margin-right:10px;">
             <span onclick="hideHpro(${sts.index})" class="upBtn" id="upBtn" style="display:none;"> ∧ </span>    
             <span onclick="viewHpro(${sts.index})" class="downBtn" id="downBtn"> ∨ </span>
           </div> 
         </td>
        </tr>
        <tr class="hpro">
         <td colspan="2" class="pro"> 
           <img valign="middle" src="../static/product/${pdto.pimg}" width="30" height="30">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           ${pdto.title}
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <fmt:formatNumber value="${pdto.price}" type="number" pattern="#,###"/>원
         </td>
        </tr>
      </c:forEach> 
        <tr>
         <td colspan="2"> &nbsp; </td>
        </tr>
        <tr>
          <td> 
             <div id="title"> 받는 사람 정보</div>
             <div> 
                <span class="bleft"> 받는사람 </span>
                <span class="bright"> ${bdto.name} </span>
             </div>
             <div>
                <span class="bleft"> 받는 주소 </span>
                <span class="bright"> ${bdto.zip} ${bdto.juso} ${bdto.jusoEtc}</span>
             </div>
             <div>
                <span class="bleft"> 배송요청사항 </span>
                <span class="bright"> ${bdto.reqStr} </span>
             </div>
          </td>
          <td> 
             <div id="title"> 결제 정보 </div>
             <div>
                <span class="pleft"> 주문금액 </span>
                <span class="pright"> ${halinPriceAll}원 </span>
             </div>
             <div>
                <span class="pleft"> 배송비 </span>
                <span class="pright"> ${baePriceAll}원 </span>
             </div>
             <div>
                <span class="pleft"> 적립금사용 </span>
                <span class="pright"> ${useJuk}원 </span>
             </div>
             <div>
                <span class="pleft"> 총 결제금액 </span>
                <span class="pright"> ${chongPrice}원 </span>
             </div>
          </td>
        </tr>
    </table>
  </section>
</body>
</html>









