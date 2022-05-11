<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰쓰기</title>
<style>
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}


<script>
 function closepopup(){
    self.close();   //자기자신창을 닫습니다.
} 


</script>
<link href="/assets/css/star.css" rel="stylesheet"/>
</style>
</head>
<body>
		

 	<form class="mb-3" name="myform" id="myform" method="post">
	<fieldset>
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="star" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="star" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="star" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="star" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="star" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	<div>
		<textarea class="col-auto form-control" type="text" id="reviewContents"
				  placeholder="내용을 입력해주세요"></textarea>
	</div>
<input type="submit">
</form>	

</body>
</html>