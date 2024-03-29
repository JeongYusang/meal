<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#select1 button#C{
	display: block;
	width: 200px;
	height: 40px;
	margin-top:15px;
	margin-bottom: 10px;
	border: none;
	border-radius: 4px;
	background-color: #96FFFF;
	font-size: 20px;
	}
	#select1 button#S{
	display: block;
	width: 200px;
	height: 40px;
	margin-top:10px;
	margin-bottom: 10px;
	border: none;
	border-radius: 4px;
	background-color: #96FFFF;
	font-size: 20px;
	}
	#select1 button#kakao-login-btn{
	display: block;
	width: 200px;
	height: 40px;
	margin-top:15px;
	margin-bottom: 10px;
	border: none;
	border-radius: 4px;
	background: rgb(252,229,30);
	font-size: 15px;
	text-align: right;
	}
	#select1 button#naver-login-btn{
	display: block;
	width: 200px;
	height: 40px;
	margin-top:10px;
	border: none;
	border-radius: 4px;
	background: rgb(40,209,17);
	font-size: 15px;
	text-align: right;
	}
</style>
</head>
<body>
<section>
	<form id="frmLogin" name="frmLogin" method="post"  action="#">
		<h1>회원가입</h1>
		너도요를 이용하시려면 회원가입을 하셔야 합니다.
	    <div id="select1">
	    <table>
	    	<tr>
	     		<td><button type="button" id="C" class="page-login" onclick="document.location.href='./memberForm.do'">일반고객 회원가입</button></td> 
	    	</tr>
	    		<tr>
	    		<td><button type="button" id="S" class="page-login" ><a href="${contextPath}/seller/sellerForm.do">판매자 회원가입</a></button></td>
	    	</tr>
	    	<tr>
	    		<td><p>간편로그인</p></td>
	    	</tr>
	    	<tr>
	    		<td><button type="button" id="kakao-login-btn" class="btn_start-btn_kakao"><a href="#">카카오로 회원가입하기</a></button></td>
	    	</tr>
	    	<tr>
	    		<td><button type="button" id="naver-login-btn" class="btn_start-btn_naver"><a href="#">네이버로 회원가입하기</a></button></td>
		    </tr>
		    </table>
		</div>
	</form>
</section>
</body>
</html>