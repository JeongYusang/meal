
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="result" value="${param.result }" />

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<title>게시물</title>

<c:if test='${not empty message }'>
	<script>
window.onload=function()
{
  result();
}

function result(){
	alert('${message}');
}
</script>
</c:if>

<script>
function fn_remove_board(url,b_gr_id){
	 var form = document.createElement("form");
	 form.setAttribute("method", "get");
	 form.setAttribute("action", url);
   var articleNOInput = document.createElement("input");
   articleNOInput.setAttribute("type","hidden");
   articleNOInput.setAttribute("name","b_gr_id");
   articleNOInput.setAttribute("value", b_gr_id);
	 
   form.appendChild(articleNOInput);
   document.body.appendChild(form);
   


   form.submit();

}
function fn_return(url){
	var form = document.createElement("form");
	form.setAttribute("method","get");
	form.setAttribute("action",url);
	document.body.appendChild(form);
	form.submit();
}
function fn_update(url,b_gr_id){
	 var form = document.createElement("form");
	 form.setAttribute("method", "get");
	 form.setAttribute("action", url);
  var articleNOInput = document.createElement("input");
  articleNOInput.setAttribute("type","hidden");
  articleNOInput.setAttribute("name","b_gr_id");
  articleNOInput.setAttribute("value", b_gr_id);
	 
  form.appendChild(articleNOInput);
  document.body.appendChild(form);
  form.submit();

}
function fn_review(url,b_gr_id){
	 var form = document.createElement("form");
	 form.setAttribute("method", "get");
	 form.setAttribute("action", url);
 var articleNOInput = document.createElement("input");
 articleNOInput.setAttribute("type","hidden");
 articleNOInput.setAttribute("name","b_gr_id");
 articleNOInput.setAttribute("value", b_gr_id);
	 
 form.appendChild(articleNOInput);
 document.body.appendChild(form);
 form.submit();

}


/* function fn_update(){
	${boardGr.u_id},${memberInfo.u_id },${sellerInfo.s_id },${adminInfo.a_id }
	var u_id = ${boardGr.u_id};
	var u_id2 = ${memberInfo.u_id};
	var s_id = ${boardGr.s_id};
	var s_id2 = ${sellerInfo.s_id};
	var a_id = ${adminInfo.a_id}
	if (u_id.equals(u_id2) || s_id.equals(s_id2) || a_id != null){
	fnc();		
		
	}
} */

</script>
<style>
.board-wrap {
	width: 1000px;
	margin-left: 50px;
}

.table-wrap table {
	width: 100%;
}

.board-wrap>tr {
	width: 100%;
}

.td2>input {
	width: 100%;
	padding: 0;
	border-radius: 4px;
}

.board-b-wrap {
	height: 40px;
	border-bottom: 3px solid #ffc0cf;
}

.board-b-wrap>input {
	float: right;
	display: inline-block;
	background-color: #ffc0cf;
	border-radius: 5px;
	border: 4px #cccccc;
	color: black;
	font-size: 8px;
	padding: 0;
	width: 35px;
	height: 20px;
	transition: all 0.5s;
	cursor: pointer;
	margin: 5px;
}

#in_content textarea {
	width: 800px;
	height: 400px;
	font-size: 20px;
}

#in_title input {
	width: 100%;
	height: 30px;
	width: 800px;
	border: none;
	resize: none;
	border: 1px solid;
}

#board_write {
	margin-left: 50px;
	width: 810px;
}

.bt button {
	float: right;
}

#text h4 {
	margin: 0;
}

#goods-info {
	margin-bottom: 30px;
}

#goods-info .imagegoods {
	float: left;
	height: 70px;
	width: 70px;
	height: 70px;
	margin-right: 10px;
}

#goodstext h3 {
	margin: 0px;
}

#goodstext p {
	margin: 0px;
}

.board-r-wrap>input {
	float: right;
	display: inline-block;
	background-color: #ffc0cf;
	border-radius: 5px;
	border: 4px #cccccc;
	color: black;
	font-size: 8px;
	padding: 0;
	width: 35px;
	height: 20px;
	transition: all 0.5s;
	cursor: pointer;
	margin: 5px;
}
/*  */
.check-context {
	z-index: 50;
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.7);
	z-index: 500;
	display: none;
}

.check-context .check-inner {
	width: 80%;
	height: 80%;
	background: #ffc0cf;
	top: 30px;
	left: 50%;
	transform: translateX(-50%);
	position: absolute;
	text-align: center;
	box-sizing: border-box;
	padding: 20px;
	font-size: 20px;
}

.check-context .check-inner>btn {
	z-index: 300px;
	width: 30px;
	height: 27px;
	border: 0;
	position: absolute;
	right: 35%;
	top: 10px;
	background: #ffc0cf;
	/* 백그라운드는 이너와 맞춰줄것 */
}

.check-context .check-inner {
	width: 40%;
	height: 40%;
	top: 150px;
	position: absolute;
}

.checked {
	color: #ffc0cb;
	font-size: 60px;
}

#grHead {
	margin: 10px;
}

#grHead #title {
	font-size: 20px;
	float: left;
}

#grHead #date {
	float: right;
	margin: 5px;
}

#grHead #id {
	margin: 5px;
	float: right
}

#g_image {
	margin: 10px;
	width: 300px;
	height: 300px;
}
</style>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body>


	<div class="check-context">

		<!-- Modal content -->
		<div class="check-inner">


			<div class="checkform">
				<h1>비밀번호 재확인</h1>
				<h3>회원의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요</h3>
				<hr>
				<form id="checkForm" method='post'
					action="${contextPath}/member/checkpw.do">
					<table id="checkpw">
						<tr>
							<th><h1>비밀번호</h1></th>
							<td><input type="password" name="_u_pw" id="_u_pw"
								style="height: 22px; margin-top: 10px; margin-left: 10px;" /></td>
						</tr>
					</table>
					<center>
						<button class="pwcheck" type="submit">전송하기</button>
						<button class="check-close" type="button">돌아가기</button>
					</center>
				</form>
			</div>
		</div>
	</div>
	<div class='board-wrap'>
		<div class="board-b-wrap">

			<h1>리뷰 상세</h1>
			<input type=button value="수정"
				onClick="fn_update('${contextPath}/boardGr/boardGrUpdateform.do',${boardGrInfo.b_gr_id })" />
			<input type=button value="삭제"
				onClick="fn_remove_board('${contextPath}/boardGr/boardGrDelete.do',${boardGrInfo.b_gr_id })" />

			<input type=button value="목록"
				onClick="fn_return('${contextPath}/boardGr/selectBoard1List.do')" />
			<input type=button value="답글"
				onClick="fn_review('${contextPath}/boardGr/boardGrReviewform.do', ${boardGrInfo.b_gr_id})" />
		</div>
		<div id="board_write">
			<div id="goods-info">
				<br> <img class="imagegoods"
					src="${contextPath}/resources/image/new1.png" />
				<div id="goodstext">
					<h3>${boardGrInfo.s_id}</h3>
					<h3>${boardGrInfo.g_name}</h3>
					<c:choose>
						<c:when test="${boardGrInfo.star == 5}">
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
						</c:when>
						<c:when test="${boardGrInfo.star == 4}">
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star"></span>
						</c:when>
						<c:when test="${boardGrInfo.star == 3}">
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
						</c:when>
						<c:when test="${boardGrInfo.star == 2}">
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
						</c:when>
						<c:otherwise>
							<span class="fa fa-star checked"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
							<span class="fa fa-star"></span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<br>

			<div id="grHead">
				<div id="title">${boardGrInfo.title}</div>
				<div id="date">${boardGrInfo.creDate}</div>
				<div id="id">작성자:${boardGrInfo.u_id}</div>
			</div>


			<br>
			<div id="content">
				<c:forEach var="imageList" items="${imageList}">
					<img id="g_image" width="300px" height="300px"
						src="${contextPath}/thumbnails.do?g_id=${boardGrInfo.g_id}&b_gr_id=${imageList.b_gr_id}&fileName=${imageList.fileName}">
				</c:forEach>
				<br> ${boardGrInfo.content}
			</div>
			<br>
		</div>

		<c:choose>
			<c:when test="${not empty ReviewList }">

				<c:forEach var="review" items="${ReviewList}">
					<div class="board-r-wrap">

						<h1>답글입니다</h1>
						<input type=button value="수정"
							onClick="fn_update('${contextPath}/boardGr/boardGrUpdateform.do',${review.b_gr_id })" />
						<input type=button value="삭제"
							onClick="fn_remove_board('${contextPath}/boardGr/boardGrDelete.do',${review.b_gr_id })" />

						<input type=button value="목록"
							onClick="fn_return('${contextPath}/boardGr/selectBoardGrList.do')" />
						<input type=button value="답글"
							onClick="fn_review('${contextPath}/boardGr/boardGrReviewform.do', ${boardGrInfo.b_gr_id})" />
					</div>

					<div class='table-wrap1'>
						<table>


							<tr>
								<th class="td1">제목</th>
								<td class="td2"><input type=text value="${review.title }"
									name="title" id="i_title" disabled /></td>
							</tr>
							<tr>
								<th class="td1">내용</th>
								<td class="td2"><textarea rows="20" cols="70"
										name="content" id="i_content" disabled> ${review.content }</textarea></td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>

</body>

</html>
