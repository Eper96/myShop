<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
   #dal a {
     text-decoration:none;
     color:black
   }
   #dal a:hover {
     text-decoration:underline;
     color:green;
   }
   #dal .sun {
     color:red;
   }
   #dal .sat {
     color:blue;
   }
 </style>
 <script>
   function init(y,m)
   { 
	   document.getElementById("pkc").style.visibility="visible";
	   // 달력이 위해 필요한 값 : 총일수, 1일의 요일, 주수
	   // Date()에서 월은 0~11까지 
	   var mon=[31,28,31,30,31,30,31,31,30,31,30,31];
       
       // 이번달 달력을 구하고자 합니다.
       var y;
       var m;
       if(!y)  // 년도의 값이 없다면  오늘기준의 년,월 구하기
       {
    	   var today=new Date();
    	   var y=today.getFullYear();
           var m=today.getMonth();
       }
       else   // 년도의 값이 넘어오면 넘어오는 값을 이용
       {
    	   if(m<0)  // 월의 값이 0보다 작다는 것은 1월에서 이전을 클릭했을 경우이므로
    	   {
    		   y=y-1;   // 이전년도 
    		   m=11;    // 12월
    	   }
    	   else if(m>11)  // 월의 값이 11보다 크다는 것은 12월에서 다음을 클릭했을 경우이므로
    		    {
    		       y=y+1;  // 다음년도
    		       m=0;    // 1월
    		    }
       }
       
       var dday=new Date(y,m,1);
       
       // 총일수
       var chong=mon[m];
       // m의 값이 1일때(2월) => 윤년이라면 => chong++
       if(m==1) // 2월인 경우
       {
    	  if((y%4==0 && y%100!=0) || y%400==0) // 윤년이라면 => (년도%4 == 0 && 년도%100!=0) || 년도%400==0 
    		  chong++;
       }
       //alert(chong);
       
       // 1일의 요일
       var yoil=dday.getDay();
       
       // 몇주
       var ju=Math.ceil((yoil+chong)/7);
       //alert(ju);
       
       var today=new Date(); // 시:분:초 가 존재
       
       // 날짜를 00시00분00초를 기준으로 하기위하여
       today=new Date(today.getFullYear(),today.getMonth(),today.getDate());  // 00:00:00       
       var afterDay=new Date(today.getFullYear(),today.getMonth(),today.getDate());
       var beforeDay=new Date(today.getFullYear(),today.getMonth(),today.getDate());
       
       // 각각 일주일 전, 후의 날짜객체로 변경하기
       afterDay.setDate(today.getDate()+7);
       beforeDay.setDate(today.getDate()-7);
       
        
       
       // 달력 폼을 갖출 테이블태그로 하나의 변수에 누적시킨다..
       var calendar="<table id='dal' width='240' border='1'>";
       // 달력위에 제목으로 년월 출력
       calendar=calendar+"<caption> <a href='javascript:init("+y+","+(m-1)+")'> 이전 </a>";
       calendar=calendar+y+"년 "+(m+1)+"월 ";
       calendar=calendar+" <a href='javascript:init("+y+","+(m+1)+")'> 이후</a> </caption>";
       calendar=calendar+"<tr>";
       calendar=calendar+"<td class='sun'> 일 </td>";
       calendar=calendar+"<td> 월 </td>";
       calendar=calendar+"<td> 화 </td>";
       calendar=calendar+"<td> 수 </td>";
       calendar=calendar+"<td> 목 </td>";
       calendar=calendar+"<td> 금 </td>";
       calendar=calendar+"<td class='sat'> 토 </td>";
       calendar=calendar+"</tr>";
       
 
       var day=1;
       for(i=0;i<ju;i++) // 주를 출력 (행)
       {
    	   calendar=calendar+"<tr>";
    	   
    	   for(j=0;j<7;j++)
    	   {
    		   var dday=new Date(y,m,day);
    		   
    		   calendar=calendar+"<td>";
    		   if((i==0 && j<yoil) || chong<day ) // 첫번째줄(i==0)이고 j값이 yoil보다 적을때 빈칸
    		     calendar=calendar+"&nbsp;";
    		   else
    		   {
    			 var str="";
    			 if(j==0)  // 일요일
    				 str="class='sun'";
    			 else if(j==6)  // 토요일
    				    str="class='sat'";
    			 
    			 if(dday>=beforeDay && dday<=afterDay) // 일주일 전 날짜 포함(제외하려면 =를 지우세요)
      		     {
    		 		 // 날짜를 클릭하면 type=text에 YYYY-MM-DD 형식으로 전달
        		     calendar=calendar+"<a "+str+" href='javascript:input("+y+","+m+","+day+")'>"+ day +"</a>";        // 숫자를 출력했을때만 day를 1씩 증가
      		     }	   
      		     else
      		     {
      		    	// 날짜를 클릭하면 type=text에 YYYY-MM-DD 형식으로 전달
        		     calendar=calendar+"<span "+str+" style='opacity:0.4'>"+ day +"</span>";        // 숫자를 출력했을때만 day를 1씩 증가
      		     }	   
    		     day++;
    		   }
    		     
    		   calendar=calendar+"</td>";
    		   
    	   }	   
    	   
    	   calendar=calendar+"</tr>";
       }	    
       
       calendar=calendar+"</table>";
       
       document.getElementById("pkc").innerHTML=calendar;
       
   }
   function input(y,m,d) // 년,월,일을 가져와서 YYYY-MM-DD로 변경후 text에 전달
   {
       // 월,일이 1자리일 경우 앞에 0붙이기
       var mm=(m+1)+"";
       var dd=d+"";
       if(mm.length==1)  // 1자리일 경우 0을 붙임  :  2 => 02
    	   mm="0"+mm;
       if(dd.length==1)
    	   dd="0"+dd;
	   
        
    	var nalja=y+"-"+mm+"-"+dd; // YYYY-MM-DD형식으로
    		 
    	document.getElementById("inday").value=nalja; // text에 전달
    	  
    	document.getElementById("pkc").style.visibility="hidden"; // 달력 숨기기
      
       
	   
   }
   
 </script>
</head>
<body>  <!-- javascript/cal2.jsp -->
  <h3> 오늘 기준으로 일주일 전후만 선택가능</h3>
  <div id="main" style="position:relative">
    <input type="text" id="inday" onfocus="init()">
    <div id="pkc" style="position:absolute;"></div>
  </div>
  <xmp id="aa">
  
  </xmp>
</body>
</html>








