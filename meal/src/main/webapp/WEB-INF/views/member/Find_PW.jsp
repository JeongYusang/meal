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
<title>너도 요리할 수 있어</title>
<style>
#pwd01 {
max-width: 100%;
text-align: center;
}

#pwd01 table#PWtable {
margin-left: auto;
margin-right: auto;
border-collapse: separate;
border-spacing: 0px 50px;
text-align: end;
}


#pwd01 td.name1{
height: 50px;
font-size: x-large;
border-top: none;
border-bottom: 1px solid #00000040;
border-left: none;
border-right: 1px solid #00000040;
vertical-align: inherit;
text-align: center;
background-color: aliceblue;
border-radius: 4px;
}

#pwd01 td.name2{
height: 50px;
font-size: x-large;
border-top: none;
border-bottom: none;
border-left: none;
border-right: none;
border-radius: 4px;
}

#pwd01 td.ID1{
height: 50px;
font-size: x-large;
border-top: none;
border-bottom: 1px solid #00000040;
border-left: none;
border-right: 1px solid #00000040;
vertical-align: inherit;
text-align: center;
background-color: aliceblue;
border-radius: 4px;
}

#pwd01 td.ID2{
height: 50px;
font-size: x-large;
border-top: none;
border-bottom: none;
border-left: none;
border-right: none;
border-radius: 4px;
}

#pwd01 td.click1 input#pub1{
width: 150px;
font-size: larger;
background-color: rgb(152 251 152 / 37%);
border: 1px outset;
border-radius: 4px;
}

#pwd01 td.click2 input#pub2{
width: 150px;
font-size: larger;
background-color: rgb(152 251 152 / 37%);
border: 1px outset;
border-radius: 4px;
}



#pwd01 input {
width: 300px;
height: 45px;
}

</style>
</head>
<body>
<form action="${contextPath}/main/FindPWResult.do" method="post">
	<div  id="pwd01">
	<h2>비밀번호 찾기</h2>
		<table id="PWtable">
			<tr>
				<td class="name1">이름</td>
				<td class="name2"><input type="text" name="member_name" placeholder="이름을 입력하세요" required="required"/></td>
			</tr>
			<tr>
				<td class="ID1">아이디</td>
				<td class="ID2"><input type="text" name="member_id" placeholder="아이디를 입력하세요" required="required"/></td>
			</tr>
			<tr>
				<td class="click1"><input type="submit" value="비밀번호 찾기" id="pub1"/></td> 
				<td class="click2"><input type="button" value="뒤로가기" onclick="location.href='loginForm.do'" id="pub2"/></td>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>