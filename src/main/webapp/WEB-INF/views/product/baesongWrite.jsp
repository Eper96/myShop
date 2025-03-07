<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
 </script> 
</head>
<body>  <!-- product/baesongWrite.jsp -->
<section>
	<form name="pkc" method="post" action="baesongWriteOk">
		<h3>배송지 등록</h3>
		<div> <input type="text" name="name"> </div>
		<div>
			<input type="text" name="zip">
			<input type="button" value="주소 찾기" onclick="juso_search()">
		</div>
		<div><input type="text" name="juso"></div>
		<div><input type="text" name="jusoEtc"></div>
		<div><input type="text" name="phone"></div>
		<div>
			<select name="req">
				<option value="0"> 문 앞 </option>
				<option value="1"> 직접 받고 부재시 문 앞 </option>
				<option value="2"> 경비실 </option>
				<option value="3"> 택배함 </option>
				<option value="4"> 기타 </option>
			</select>
		</div>
	<div>
		<input type="checkbox" name="gibon" value="1">
		기본 배송지로 설정하기
	</div>
	<div><input type="submit" value="배송지 등록"></div>
	</form>
	
	
</section>

</body>
</html>