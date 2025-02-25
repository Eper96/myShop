<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section {
	width: 1100px;
	height: ${height}px;
	margin:auto;
}
section #number {
	display: inline-block;
	width: 74px;
	height: 26px;
	line-height: 26px;
	border: 1px solid #cccccc;
	border-radius: 3px;
	padding-top: 4px;
}

section .su {
	width: 20px;
	text-align: center;
	border: none;
	outline: none;
	font-size: 15px;
	font-weight: 500;
}

section #number img {
	margin-bottom: 2px;
	cursor: pointer;
}

section table {
	margin-top: 40px;
	margin-bottom: 40px;
	border-spacing: 0px;
}

section table tr td {
	height: 110px;
	border-bottom: 1px solid purple;
}

section table tr:first-child td {
	border-top: 2px solid purple;
}

section table tr:last-child td {
	border-bottom: 2px solid purple;
}
</style>
<script>
	function mainCheck(my) {
		// 전체선택 체크박스가 체크되었는지 여부를 확인
		var subChk = document.getElementsByClassName("subChk");
		if (my.checked) // if(document.getElementById("mainChk").checked)
		{
			for (i = 0; i < subChk.length; i++) {
				subChk[i].checked = true;
			}
		} else {
			for (i = 0; i < subChk.length; i++) {
				subChk[i].checked = false;
			}
		}
		totalPrice();
	}

	function subCheck() {
		// class="subChk"가 모두 체크되면  id="mainChk"를 checked true
		var subChk = document.getElementsByClassName("subChk");
		var chkNum = 0;
		for (i = 0; i < subChk.length; i++) {
			if (subChk[i].checked) {
				chkNum++;
			}
		}

		if (chkNum == subChk.length) {
			document.getElementById("mainChk").checked = true;
		} else {
			document.getElementById("mainChk").checked = false;
		}
		totalPrice();
	}
	
	function totalPrice() {  // 실행되면 체크된 상품의 할인상품금액X수량을 누적시켜서 표시한다.
		var subChk = document.getElementsByClassName("subChk");
		var hPrice = document.getElementsByClassName("hPrice");  // 상품할인된 금액
		var bPrice = document.getElementsByClassName("bPrice");
		var su = document.getElementsByClassName("su");
		
		// 할인된 상품금액을 누적할 변수
		var hPriceTotal = 0;
		// 배송비를 누적할 변수
		var bPriceTotal = 0;
		
		for (i = 0; i < subChk.length; i++) {
			if(subChk[i].checked) {
				// 계산을 한다.
				var danga = hPrice[i].value * su[i].value; 
				hPriceTotal += danga;
				
				// 배송비 추가
				bPriceTotal += parseInt(bPrice[i].value);
				
			}
			
		}
		document.getElementById("hPriceAll").innerText=comma(hPriceTotal)+"원";
		document.getElementById("bPriceAll").innerText=comma(bPriceTotal)+"원";
		document.getElementById("AllPrice").innerText=comma(hPriceTotal+bPriceTotal)+"원";
	}
	
	
	function cartDel() {
		// class="subChk"인 요소중 선택된 요소의 상품id값을 ,로 구분하여 저장.
		var subChk = document.getElementsByClassName("subChk");
		var ids = "";
		for(i=0;i<subChk.length;i++){
			if(subChk[i].checked) {  // 체크된 상품의 id만 저장
				ids += subChk[i].value +",";
			}
		}
		location="cartDel?ids="+ids;
	}
	
	function comma(price) {
		return new Intl.NumberFormat().format(price);
	}
	
	function downSu(n,id,pcode) {
		// class="su" 몇 번째 인덱스인지 구해야 한다. 
		var su = document.getElementsByClassName("su");
		var num = su[n].value;
		if (num>1){
			
			num--;
			su[n].value=num;
			// 비동기방식으로 cart테이블에서 값을 빼기
			var chk = new XMLHttpRequest();
			chk.onload = function() {
				
				
			}
			chk.open("get","chgSu?num="+num+"&id="+id+"&pcode="+pcode);
			chk.send();
		}
		totalPrice();
	}
	
	function upSu(n,id,pcode) {
		var su = document.getElementsByClassName("su");
		
		var num = su[n].value;
		num++;
		su[n].value=num;
		
		// 비동기방식으로 cart테이블에서 값을 빼기
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			
			
		}
		chk.open("get","chgSu?num="+num+"&id="+id+"&pcode="+pcode);
		chk.send();
		
		totalPrice();
	}
	
	window.onpageshow=function() {
		totalPrice();
		subCheck();
	}
	
	  function gumae()
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
		if(pcodes.length!=0) {
			location="../product/productGumae?pcode="+pcodes+"&su="+sus;
		} else {
			alert("상품을 선택하세요.")
		}
	  }
	</script>
</script>
</head>
<body>
	<!-- cartView.jsp -->
	<section>
		<table width="1100" align="center">
			<caption>
				<h3>장바구니 현황</h3>
			</caption>
			<tr>
				<td>
					<c:if test="${allChk==1}">
						<c:set var="achk" value="checked" />
					</c:if> 
					<input type="checkbox" ${achk} onclick="mainCheck(this)" id="mainChk"
					style="width: 18px; height: 18px;"></td>
				<td colspan="9" align="left">
				전체선택 <input type="button"
value="선택삭제" onclick="cartDel()"> 상품금액(<span id="hPriceAll"></span>
					) + 배송비(<span id="bPriceAll"></span> ) = 총 결제금액 : <span
					id="AllPrice"></span>
					
					<c:if test="${userid!=null}">
              			<input type="button" onclick="gumae()" value="선택구매">
             		</c:if>
             		
            		<c:if test="${userid==null}"> 
             			<input type="button" onclick="location='../login/login?cart=1'" value="선택구매">
            		</c:if>
            		
				</td>
			</tr>
			<c:forEach items="${plist}" var="pdto" varStatus="sts">
				<c:set var="tt" value="" />
				<c:if test="${pdto.wchk==1}">
					<c:set var="tt" value="checked" />
				</c:if>
				<tr>
					<td width="30">
						<c:if test="${userid!=null}">
							<input type="checkbox" ${tt} class="subChk" value="${pdto.id}"
								onclick="subCheck()">
							<input type="hidden" name="pcode" class="pcode" value="${pdto.pcode}">
						</c:if>
						
						 <c:if test="${userid==null}">
							<input type="checkbox" ${tt} class="subChk" value="${pdto.pcode}"
								onclick="subCheck()">
						</c:if> 
						
						<input type="hidden" class="hPrice" value="${pdto.price}">
						<input type="hidden" class="bPrice" value="${pdto.baeprice}">
					</td>
					<td width="110"><img src="../static/product/${pdto.pimg}"
						width="100" height="100"></td>
					<td width="340">${pdto.title}</td>
					<td width="140">${pdto.baeDayStr}</td>
					<td width="120">${pdto.halinPriceStr}</td>
					<td width="100">${pdto.jukPriceStr}</td>
					<td width="100">${pdto.baePriceStr}</td>
					<td width="100">
						<div id="number">
							<img src="../static/minus.png" valign="middle"
								onclick="downSu(${sts.index},${pdto.id},'${pdto.pcode}')">
							<input type="text" name="su" value="${pdto.su}" class="su"
								readonly> <img src="../static/plus.png" valign="middle"
								onclick="upSu(${sts.index},${pdto.id},'${pdto.pcode}')">
						</div>
					</td>
					<td width="50">
						<c:if test="${userid!=null}">
							<input type="button" onclick="location='cartDel?ids=${pdto.id}'"
								class="delBtn" value="삭제">
						</c:if>
						 
						<c:if test="${userid==null}">
							<input type="button"
								onclick="location='cartDel?ids=${pdto.pcode}'" class="delBtn"
								value="삭제">
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</section>

</body>
</html>