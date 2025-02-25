<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
	
	}
	section .pform {
		display:none;
	}
	section .tdPay {
		wdith:1100px;
		height:150px;
		border:1px solid black;
	}
	section .tdPay:last-of-type {
		height:35px;
		border:1px solid black;
	}
	section .pay {
		display:none;
	}
</style>
<script>
	function addBaesong() {
		open("baesongWrite","op","width=500,height=500"); // 나타낼 문서, 창 이름, 창의 속성(가로세로)
	}
	function chgBaesong() {
		open("baesongList","op","width=500,height=600");
	}
	function viewForm(n) {
		var pform = document.getElementsByClassName("pform");
		for (i = 0; i < pform.length; i++) {
			pform[i].style.display="none";
		}
		pform[n].style.display="block";
	}
	window.onpageshow = function() {
		document.getElementsByClassName("pform")[0].style.display="block";
		document.getElementsByClassName("pay")[0].style.display="block";
		document.getElementsByClassName("pay")[1].style.display="block";
	}
	var payChk=0;
	function viewHide() {
		// class="pay"의 인덱스 2~5까지의 내용을 전부 보이기 or 전부 숨기기
		var pay = document.getElementsByClassName("pay");
		
		if(payChk%2==0) {
			for (i = 2; i < pay.length; i++) {
				pay[i].style.display="block";
				document.getElementById("arrow").innerText="▲";
			}
		} else {
			for (i = 2; i < pay.length; i++) {
				pay[i].style.display="none";
				document.getElementById("arrow").innerText="▼";
			}
		}
		payChk++;
	}
	
	var myJuk=${mdto.juk};
	function calJuk(my) {
		// isNaN(); 문자면 true, 숫자면 false
		var num = my.value;
		if(isNaN(num) || num.length==0) {
			alert("숫자만 입력이 가능합니다.");
			my.value = 0;
			document.getElementById("dtoJuk").innerText=comma(${mdto.juk});
		} else {
			if (num>myJuk) {
				my.value="0";
			} else {
				// 보유금액 - num 을 계산하여 전달.
				var result = myJuk-parseInt(num); // 자바스크립트에서 덧셈을 제외한 모든 연산은(뺄셈은)계산이 된다. 
				document.getElementById("dtoJuk").innerText=comma(result);
				
				// 총 결제금액에서 사용된 적립금을 차감한 뒤 값을 전달
				var ocp = parseInt(document.getElementById("oriChongPrice").value);
				document.getElementById("chongPrice").innerText=comma(ocp-num)+"원";
			}
		}
		
		
	}
	function comma(price) {
		return new Intl.NumberFormat().format(price);
	}
</script>
</head>
<body>  <!-- product/productGumae.jsp -->
<section>
	<form method="post" action="gumaeOk">
	<!-- 장바구니에서 1개 이상의 상품이 구매를 위해 넘어온다..
     name="pcode"는 상품의 코드별로 ,로서 구분하여 만든뒤 전달
     name="su"는 상품의 수량별로 ,로 구분
    -->
	<input type="hidden" name="baeId" id="baeId" value="${bdto.id}">
	
	<!-- 구매자 정보 -->
	<table width="1100" align="center">
		<caption><h3 align="left">구매자 정보</h3></caption>
		<tr>
			<td>이 름</td>
			<td>${mdto.name}</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${mdto.email}</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>${mdto.phone}</td>
		</tr>
	</table>
	<!-- 배송지 정보 -->
	<table width="1100" align="center">
		<caption><h3 align="left">배송지 정보
		<c:if test="${bdto!=null}">
		  <input type="button" value="배송지변경" onclick="chgBaesong()">
		</c:if>
		<c:if test="${bdto==null}">
		  <input type="button" value="배송지등록" onclick="addBaesong()">
		</c:if>
		</h3></caption>
		<tr>
			<td>이 름</td>
			<td id="name">${bdto.name}</td>
		</tr>
		<tr>
			<td>배송주소</td>
			<td id="juso">${bdto.juso} ${bdto.jusoEtc}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td id="phone">${bdto.phone}</td>
		</tr>
		<tr>
			<td>배송요청사항</td>
			<td id="reqStr">${bdto.reqStr}</td>
		</tr>
	</table>
	
	
	<!-- 배송상품 : 배송예정일, 상품명, 구매수량, 배송비 -->
	<table width="1100" align="center">
			<caption> <h3 align="left"> 배송상품 </h3> </caption>
			<c:set var="cPrice" value="0"/>
			<c:set var="cBPrice" value="0"/>
		<c:forEach items="${plist}" var="pdto">
		<input type="hidden" name="pcode" value="${pdto.pcode}">
		<input type="hidden" name="su" value="${pdto.su}">
		<c:set var="cPrice" value="${cPrice + (pdto.price * pdto.su)}"/>
		<c:set var="cBPrice" value="${cBPrice + pdto.baeprice}"/>
		<%-- <c:set var="imsiPcode" value="${imsiPcode}${pdto.pcode}/"/>
		<c:set var="imsiSu" value="${imsiSu}${pdto.su}/"/> --%>
	    <tr>
	      <td colspan="2"> ${pdto.baeDayStr} </td> <!-- 배송예정일 -->
	    </tr>
	    <tr>
	      <td> ${pdto.title} </td>  <!-- 상품명 -->
	      <tr>
	      <td>
	        수량 :  ${pdto.su}개  / 
	        <c:if test="${cBPrice==0}">
	         무료배송
	        </c:if>
	        <c:if test="${cBPrice!=0}">
	         <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원
	        </c:if>      
	      </td>  <!-- 수량, 배송비관련 -->
	      </tr>
	      <c:set var="cPrice" value="${cPrice}"/>
	    </c:forEach>
	    <input type="hidden" id="oriChongPrice" value="${cPrice+cBPrice}">
	    <%-- <input type="hidden" name="pcode" value="${imsiPcode}">
		<input type="hidden" name="sus" value="${imsiSu}"> --%>
	</table>
	
	<!-- 결제정보 -->
	<table width="1100" align="center">
	<caption><h3 align="left">결제 정보</h3></caption>
		<tr>
			<td width="140"> 총 상품가격 </td>
			<td>

			<fmt:formatNumber value="${cPrice}" type="number" pattern="#,###"/>원
			 </td>
		</tr>
		<tr>
			<td> 할인쿠폰 </td>
			<td> 0원 </td>
		</tr>
		<tr>
			<td> 배송비 </td>
			<td> <fmt:formatNumber value="${cBPrice}" type="number" pattern="#,###"/>원 </td>
		</tr>
		<tr>
			<td> 적립금 사용 </td>
			<td>
			 <input type="text" name="useJuk" onblur="calJuk(this)" value="0" size="4" style="text-align:right">원 사용 ||
			 보유 : <span id="dtoJuk"><fmt:formatNumber value="${mdto.juk}" type="number" pattern="#,###"/></span>원 </td>
		</tr>
		<tr>
			<td> 총 결제금액 </td>
			<td>
				<span id="chongPrice"> 
					<fmt:formatNumber value="${cBPrice + cPrice}" type="number" pattern="#,###"/>원
				</span>
			</td>
		</tr>
	</table>
	
	<!-- 결제수단 -->
	<table width="1100" align="center">
		<caption><h3 align="left">결제수단</h3></caption>
		<tr>
			<td class="tdPay">
				<div class="pay">
					<input type="radio" name="pay" value="0" onclick="viewForm(this.value)"> 신용/체크카드
					<div class="pform"> <!-- 입력할 폼 생성 -->
						<select name="card1">
			              <option value="0"> 신한카드 </option>
			              <option value="1"> 우리카드 </option>
			              <option value="2"> 농협카드 </option>
			              <option value="3"> KB카드 </option>
			            </select>
					</div>
				</div>
				<div class="pay">
					<input type="radio" name="pay" value="1" onclick="viewForm(this.value)"> S페이
					<div class="pform"> <!-- 입력할 폼 생성 -->
			             <select name="halbu1">
			               <option value="0"> 일시불 </option>
			               <option value="1"> 2개월 </option>
			               <option value="2"> 3개월 </option>
			               <option value="3"> 6개월 </option>
			               <option value="4"> 12개월 </option>
			             </select>
					</div>
				</div>
			</td>
		</tr>
		<tr> 
			<td class="tdPay">
				<div onclick="viewHide()"> 다른 결제 수단 <span id="arrow">▼</span></div>
				
				<div class="pay">
					<input type="radio" name="pay" value="2" onclick="viewForm(this.value)"> 계좌이체
					<div class="pform"> <!-- 입력할 폼 생성 -->
						<select name="bank1">
			              <option value="0"> 신한은행 </option>
			              <option value="1"> 농협은행 </option>
			              <option value="2"> 우리은행 </option>
			              <option value="3"> KB은행 </option>
			            </select>
					</div>
				</div>
				<div class="pay">
					<input type="radio" name="pay" value="3" onclick="viewForm(this.value)"> 법인카드
					<div class="pform"> <!-- 입력할 폼 생성 -->
						<select name="card2">
			              <option value="0"> 신한카드 </option>
			              <option value="1"> 우리카드 </option>
			              <option value="2"> 농협카드 </option>
			              <option value="3"> KB카드 </option>
			            </select>
					</div>
				</div>
				<div class="pay">
					<input type="radio" name="pay" value="4" onclick="viewForm(this.value)"> 휴대폰
					<div class="pform"> <!-- 입력할 폼 생성 -->
						<select name="tel">
			              <option value="0"> SKT </option>
			              <option value="1"> KT </option>
			              <option value="2"> LG </option>
			              <option value="3"> 알뜰통신 </option>
			            </select>
					</div>
				</div>
				<div class="pay">
					<input type="radio" name="pay" value="5" onclick="viewForm(this.value)"> 무통장입금
					<div class="pform"> <!-- 입력할 폼 생성 -->
						<select name="bank2">
			              <option value="0"> 신한은행 </option>
			              <option value="1"> 농협은행 </option>
			              <option value="2"> 우리은행 </option>
			              <option value="3"> KB은행 </option>
			            </select>
					</div>
				</div>
			</td>
		</tr>
	</table>
		<div align="center"><input type="submit" value="구매하기"></div>
	</form>
</section>
</body>
</html>