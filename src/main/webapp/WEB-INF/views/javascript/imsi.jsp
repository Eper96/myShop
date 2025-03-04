<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#first {
		width:1100px;
		height:40px;
		margin:auto;
		background:red;
	}
	
	#second {
		width:1100px;
		height:100px;
		margin:auto;
		background:yellow;
	}
	
	#third {
		width:1100px;
		height:100px;
		margin:auto;
		background:blue;
		position:relative;
	}
	
	#third #layer {
		width:50px;
		height:120px;
		background:black;
		position:absolute;
		left:1150px;
		top:100px;
	}
	
	#fourth {
		width:1100px;
		height:1000px;
		margin:auto;
		background:grey;
	}
	
	#fifth {
     	width:1100px;
     	height:100px;
     	margin:auto;
     	background:black;
	}
</style>
<script>

	document.onscroll = function() {
		var w = window.innerWidth;
		w=w-1100;
		w=w/2;
		// scrollTop이 140이 넘으면 fixed, 미만이면 absolute
		var num=document.documentElement.scrollTop;
		if(num > 140){
			document.getElementById("layer").style.position="fixed";
			document.getElementById("layer").style.left=(1160+w-10)+"px";
		} else {
			document.getElementById("layer").style.position="absolute";
			document.getElementById("layer").style.left=1160+"px";
		}
	};
</script>
</head>
<body>  <!-- javascript/imsi.jsp -->

<div id="first"></div>
<div id="second"></div>
<div id="third">
	<div id="layer"></div>
</div>
<div id="fourth"></div>
<div id="fifth"></div>


</body>
</html>