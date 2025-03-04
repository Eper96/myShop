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
     left:30px;
     top:40px;
    }
 
     #main #calendar #cal2 {
       background:white;
       border-spacing:0px;
       display:inline-block;
       margin-left:10px;
       vertical-align:top;
    }
    #main #calendar #cal2 caption {
       background:white;
       border:1px solid black;
       height:20px;
       line-height:20px;
    }
     #main #calendar  #cal2  tr td {
       width:15px;
       height:15px;
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
   var add=0;
   function makeCal(y,m,n) // class='nalJa'의 index
   {
	   var start=document.getElementById("start");
	   var end=document.getElementById("end");
	   start.value="";
	   end.value="";
 
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
	    
	   if(n==1)
	   {
		   var imsi=new Date(y,m-1,1);
		   n=nums[n];
		   
		   if( (y%4==0 && y%100!=0) || y%400==0 )
			   n++;
		   
		   // 2번째 달력의 td의 시작값을 이전달의 총일수로 시작
	   }
	   
	   // 몇 주 =>  (1주빈칸+총일수)/7 => ???.???  => 소수점은 무조건 올림으로 처리
	   var ju=Math.ceil((chong+yoil)/7);
	   
	   var calData="<table  align='center' border='0' id='cal2'>";
	   calData=calData+"<caption>";
 
	   calData=calData+y+"년 "+(m+1)+"월 ";
 
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
			   if( (i==0 && j<yoil) || day>chong )  
			   {
				   calData=calData+" <td> &nbsp; </td>";
			   }	
			   else
			   {                         
				   calData=calData+" <td class='td'  onclick='nalJaSend("+y+","+m+","+day+","+n+")'> "+day+" </td> ";
				   day++;                     
			   }			   
		   }	   
		   
		   calData=calData+" </tr> ";
	   }	   
	   
	   calData=calData+"</table>";
	   
       return calData;
	   
	   
   }
   function total(y,m)
   {
	   
	   if(y==-1)
	   {
		  var today=new Date();
		  y=today.getFullYear();
		  m=today.getMonth();
	   } 	   
	   calData=makeCal(y,m,0);
	   calData="<div>"+calData+makeCal(y,m+1,1)+"</div>";
	   document.getElementById("calendar").innerHTML=calData;
   }
   var std;
   function nalJaSend(y,m,d,n) // m은 0~11  =>  +1
   {
	   //alert(n+d);
	   var dd=n+d; // 클릭된 td의 인덱스에 해당됨
	   // 년,월,일을 가져와서 시작일과 최종일에 값을 넣어주는것 인덱스에 해당되는 n값도 가져온다
	   m=m+1;
	   // m,d를 문자형으로 변환
	   m=m+"";
	   m=m.padStart(2,"0");

	   
	   d=d+"";
	   d=d.padStart(2,"0");

	   
	   var nalJa=y+"-"+m+"-"+d; 
	   
	   var start=document.getElementById("start");
	   var end=document.getElementById("end");
	   
	   if(start.value!="" && end.value!="")
	   {
		   start.value="";
		   end.value="";
		   for(i=0;i<document.getElementsByClassName("td").length;i++)
		   {
			   document.getElementsByClassName("td")[i].style.background="white";
			   document.getElementsByClassName("td")[i].style.color="black";
		   }
		   start.value=nalJa;
		   document.getElementsByClassName("td")[dd-1].style.background="purple";
		   document.getElementsByClassName("td")[dd-1].style.color="white";
		   
		   std=dd-1;
	   }	   
	   else if(start.value=="" && end.value=="")
	   {
		   start.value=nalJa;
		   document.getElementsByClassName("td")[dd-1].style.background="purple";
		   document.getElementsByClassName("td")[dd-1].style.color="white";
		   std=dd-1;
	   }	   
	   else if(start.value!="" && end.value=="")
	   {
		   var ss=new Date(start.value);
		   var ee=new Date(nalJa);
 
		   if(ss<ee)
		   {
			   end.value=nalJa;
			   for(i=std;i<dd;i++)
			   {
				   document.getElementsByClassName("td")[i].style.background="purple";
				   document.getElementsByClassName("td")[i].style.color="white";
			   }	
               
			   for(i=0;i<document.getElementsByClassName("td").length;i++)
			   {
				   document.getElementsByClassName("td")[i].setAttribute("onmouseout","");
				   document.getElementsByClassName("td")[i].setAttribute("onmouseover","");
			   }	
		   }	 
		   else if(ss.getTime()==ee.getTime())
			    {
			        start.value="";
			        end.value="";
			        document.getElementsByClassName("td")[dd-1].style.background="white";
					document.getElementsByClassName("td")[dd-1].style.color="black";
                    
			    }
	   }
   }
 
   function over(d)
   {    
	   if(std!="")
	   for(i=std;i<d;i++)
	   {
		   document.getElementsByClassName("td")[i].style.background="purple";
	   }	   
   }
   function out(d)
   {
	   for(i=std;i<d;i++)
	   {
		   document.getElementsByClassName("td")[i].style.background="white";
	   }
   }
 </script>
</head>
<body>  <!-- javascript/cal6.jsp -->
 <h3> 2달 달력 나오고 모든 날짜 선택가능</h3>
 <div id="main">
  <input type="text" id="start" name="start" placeholder="시작일" readonly> -
  <input type="text" id="end" name="end" placeholder="최종일" readonly>
  <input type="button" value="날짜선택" onclick="total(-1,-1)">
  <div id="calendar"></div> 
 </div>
 
</body>
</html>








