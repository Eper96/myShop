<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
    #main {
      position:relative;
      width:600px;
      margin:auto;
    }
    #main #calendar {
     position:absolute;
     left:100px;
     top:40px;
    }
     #main #calendar #cal2 {
       background:white;
       border-spacing:0px;
    }
    #main #calendar #cal2 caption {
       background:white;
       border:1px solid black;
       height:36px;
       line-height:36px;
       padding-top:3px;
    }
     #main #calendar  #cal2  tr td {
       width:24px;
       height:24px;
       border:1px solid black;
       background:white;
       padding:2px;
       text-align:center;
       cursor:pointer;
    }
     #main #calendar  #cal2  tr td:hover {
       background:purple;
       color:white;
    }
   
 </style>
  <script>
   function makeCal(y,m,n) // class='nalJa'의 index
   {
	   
	   if(y==-1)
	   {
		   var today=new Date(); // 오늘의 요일, 이번달의 총일수
		   y=today.getFullYear();
		   m=today.getMonth(); // 0~11
	   }	

	   if(m==-1) // 1월에서 이전으로 클릭
	   {
		   y--;
		   m=11;
	   }
	   if(m==12) // 12월에서 다음으로 클릭
	   {
		   y++;
		   m=0;
	   }
	   
	   // 1일의 요일을 구하기 위해 today를 이용하여 이번년,이번달,1일 => 날짜객체를 생성
	   var xday=new Date(y,m,1);
	   
	   // 1일의 요일
	   var yoil=xday.getDay(); // 0~6(일~토)
	   
	   // 총일수 => 지원하지 않는 언어에 자주 사용하는 방식
	   var nums=[31,28,31,30,31,30,31,31,30,31,30,31];
	 
	   var chong=nums[m];
	   
	   // 윤년인 경우에는 2월이 29일이다
	   if(m==1) // 2월달인 경우
	   {
		   if( (y%4==0 && y%100!=0) || y%400==0 )
			   chong++;
	   }	   
	   
	   // 몇 주 =>  (1주빈칸+총일수)/7 => ???.???  => 소수점은 무조건 올림으로 처리
	   var ju=Math.ceil((chong+yoil)/7);
	   
	   var calData="<table  align='center' border='0' id='cal2'>";
	   calData=calData+"<caption>";
	   calData=calData+" <a href='javascript:makeCal("+y+","+(m-1)+","+n+")'> 이전 </a> ";
	   calData=calData+y+"년 "+(m+1)+"월 ";
	   calData=calData+" <a href='javascript:makeCal("+y+","+(m+1)+","+n+")'> 다음 </a>";
	   calData=calData+" </caption>";
	   calData=calData+"<tr>";
	   calData=calData+" <td> 일 </td>";
	   calData=calData+" <td> 월 </td>";
	   calData=calData+" <td> 화 </td>";
	   calData=calData+" <td> 수 </td>";
	   calData=calData+" <td> 목 </td>";
	   calData=calData+" <td> 금 </td>";
	   calData=calData+" <td> 토 </td>";
	   calData=calData+"</tr>";
	   
	   var day=1;
	   for(i=0;i<ju;i++)
	   {
		   calData=calData+" <tr> ";
		   
		   for(j=0;j<7;j++)
		   {
			   if( (i==0 && j<yoil) || day>chong ) // (1주차에 1일의 요일이전) ||  day가 총일수보다 크면 
			   {
				   calData=calData+" <td> &nbsp; </td>";
			   }	
			   else
			   {                            // nalJaSend(2025,1,20,0)
				   calData=calData+" <td onclick='nalJaSend("+y+","+m+","+day+","+n+")'> "+day+" </td> ";
				   day++;                     // nalJaSend(0)
			   }			   
		   }	   
		   
		   calData=calData+" </tr> ";
	   }	   
	   
	   calData=calData+"</table>";
	   document.getElementById("calendar").innerHTML=calData;
	   
	   event.stopPropagation(); // 다음 이벤트로 진행을 중지시킨다..
   }
   function nalJaSend(y,m,d,n) // m은 0~11  =>  +1
   {
	   // 년,월,일을 가져와서 시작일과 최종일에 값을 넣어주는것 인덱스에 해당되는 n값도 가져온다
	   m=m+1;
	   // m,d를 문자형으로 변환
	   m=m+"";
	   m=m.padStart(2,"0");
	   //if(m.length==1)
	   //   m="0"+m;
	   
	   d=d+"";
	   d=d.padStart(2,"0");
	   //if(d.length==1)
	   //   d="0"+d;
	   
	   var nalJa=y+"-"+m+"-"+d; // 2025-02-11
	   
	   
	   
	   // 입력하기전 시작일과 최종일의 날짜를 비교해서 => 시작일이 클경우 메시지를 띄운다
	   if(n==0) // 시작일이 클릭되어 시작일 날짜가 들어올 경우
	   {
		   if(document.getElementsByClassName("nalJa")[1].value=="")
		   {
			   document.getElementsByClassName("nalJa")[n].value=nalJa;
			   
		   }	
		   else // 날짜비교
		   {
			    var xday1=new Date(nalJa);
			    var xday2=new Date(document.getElementsByClassName("nalJa")[1].value);
			    
			    if(xday1>xday2)
			    {
			    	// 시작일이 큰 경우
			    	alert("시작일이 최종일 보다 큽니다");	
			    	document.getElementsByClassName("nalJa")[0].value="";
			    }	
			    else
			    {
			    	document.getElementsByClassName("nalJa")[n].value=nalJa;
			    }	
		   }	   
	   }	
	   
	   if(n==1) // 최종일이 클릭되어 최종일 날짜가 들어올 경우
	   {
		   if(document.getElementsByClassName("nalJa")[0].value=="")
		   {
			   document.getElementsByClassName("nalJa")[n].value=nalJa;
		   }	
		   else // 날짜비교  => 시작일이 입력되어 있는 상태에서 최종일이 클릭되었을때
		   {
			    var xday1=new Date(document.getElementsByClassName("nalJa")[0].value);
			    var xday2=new Date(nalJa);
			    
			    if(xday1>xday2)
			    {
			    	// 시작일이 큰 경우
			    	alert("시작일이 최종일 보다 큽니다");	
			    	document.getElementsByClassName("nalJa")[1].value="";
			    }	
			    else
			    {
			    	document.getElementsByClassName("nalJa")[n].value=nalJa;
			    }	
		   }	   
	   }	   
	   
	   
	   
	   // 입력폼에 날짜를 전달한 후 => 달력을 숨기기
	   document.getElementById("calendar").innerHTML="";
   }
 
   
   window.onclick=function()
   {
 
	   document.getElementById("calendar").innerHTML="";
   }
 </script>
</head>
<body>  <!-- javascript/cal4.jsp -->
 <h3> 시작일 보다 이전의 최종일 선택 불가 </h3>
 <div id="main">
  <input type="text" class="nalJa" name="start" placeholder="시작일" onclick="makeCal(-1,-1,0)"> -
  <input type="text" class="nalJa" name="end" placeholder="최종일" onclick="makeCal(-1,-1,1)">
  <div id="calendar"></div> 
 </div>
</body>
</html>








