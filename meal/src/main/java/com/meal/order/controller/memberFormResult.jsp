<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="result" value="${param.result }" />
<%
request.setCharacterEncoding("UTF-8");
%>
<%
String id = (String) request.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

#frmResult {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    font-size: x-large;
}

#frmResult input.confirm {
    background-color: rgba(255, 192, 207, 0.7);
    border-radius: 4px;
    width: 150px;
    height: 44px;
}



</style>

</head>
<body>
	<section>
		<form id="frmResult" name="frmResult" method="post" action="#">
			<div id="container">
				<tr id="tr1">
					<h1>회원가입이 완료되었습니다</h1>

					<c:choose>
						<c:when test="${not empty memberInfo.u_id }">
							<td><p>${memberInfo.u_name }님의가입을환영합니다.</p></td>
							<td><p>아이디는${memberInfo.u_id } 입니다.</p></td>
							<td><p>비밀번호는 ${memberInfo.u_pw } 환영합니다.</p></td>
						</c:when>
						<c:when test="${not empty sellerInfo.s_id }">
							<td><p>${sellerInfo.s_name }님의가입을환영합니다.</p></td>
							<td><p>아이디는${sellerInfo.s_id }입니다.</p></td>
							<td><p>비밀번호는 ${sellerInfo.s_pw }입니다.</p></td>
						</c:when>

					</c:choose>

					<td><p>언제나 좋은 서비스를 제공할 수 있도록 최선을 다하겠습니다.</p></td>
				</tr>
				<tr id="tr2">
					<td id="ResultLogin"><a
						href="${contextPath }/main/loginForm.do"><input type="button" value="로그인" class="confirm" id="confirm"></a></td>
				</tr>
			</div>
		</form>
	</section>
</body>
</html>