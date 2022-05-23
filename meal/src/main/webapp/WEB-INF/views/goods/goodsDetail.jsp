
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>상품 상세 정보</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
		})

	});
</script>
<c:if test='${not empty message }'>
	<script>
		window.onload = function() {
			result();
		}

		function result() {
			alert('${message}');
		}
	</script>
</c:if>
<style>
#main {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.container {
	display: grid;
	grid-template-columns: 600px 500px;
	grid-column-gap: 50px;
}

ul.tabs {
	margin: auto;
	padding: 0px;
	list-style: none;
}

ul.tabs li {
	text-align: center;
	display: inline-block;
	color: black;
	background: #f1f1f1;
	padding: 10px 15px;
	cursor: pointer;
	width: 180px;
	height: 30px;
}

ul.tabs li.current {
	font-size: 16px;
	border: 5px solid;
	background-color: #B1D5FF;
	color: white;
}

.tab-content {
	display: none;
	border: 1px solid;
	padding: 12px;
}

.tab-content.current {
	display: inherit;
}

.detail {
	text-align: center;
	display: inline-block;
	width: 1260px;
	height: 1260px;
}

.detail1 {
	text-align: center;
	display: inline-block;
}

.button {
	background-color: #B1D5FF;
	border: none;
	color: white;
	padding: 15px 30px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

.review-table {
	width: 100%;
	margin: 0 auto; /* 가로로 중앙에 배치 */
	text-align: center;
	background-color: white;
	font-size: 24px;
	border-collapse: collapse;
}

#top-table {
	border-bottom: 1px solid black;
}

tr.border-bottom td {
	border-bottom: 1px solid black;
}

#list {
	text-align: center;
}

#write {
	text-align: right;
}

#tabletitle {
	text-align: left;
	font-size: 40px;
}

#main-wrap {
	color: black;
}

.checked {
	color: orange;
}

.stable-striped {
	width: 100%;
	margin: 0 auto; /* 가로로 중앙에 배치 */
	text-align: center;
	background-color: white;
	font-size: 18px;
	border-collapse: collapse;
	color: black;
}

.stable-striped tr:nth-child(even) {
	background-color: #FFF6FA;
}

.stable-striped tr, td {
	padding: 20px;
}

#top-table {
	color: black;
	text-align: center;
	border-collapse: collapse;
	background-color: #FFF0F0s;
}

#top-table tr, ths {
	padding: 20px;
}

#body-table {
	text-align: center;
}

tr.border-bottom td {
	border-bottom: 1px black;
}

#write a {
	float: right;
	text-align: center;
	background-color: #ffc0cb;
	font-size: 14px;
	border: 1px;
	color: white;
	padding: 10px;
	margin-bottom: 10px;
	'
}

#tabletitle {
	margin: 10px;
	color: #FD6EB0;
	font-size: 32px;
}

.pagination {
	margin: auto;
}

.pagination a {
	font-size: 22px;
	border: 1px solid #ddd;
}

.center {
	text-align: center;
}

.checked {
	color: #ffc0cb;
}
</style>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body onload="init();">
	<script language="JavaScript">
		var sell_price;
		var amount;

		function init() {
			sell_price = document.form.sell_price.value;
			amount = document.form.amount.value;
			document.form.sum.value = sell_price;
			change();
		}

		function add() {
			hm = document.form.amount;
			sum = document.form.sum;
			hm.value++;

			sum.value = parseInt(hm.value) * sell_price;
		}

		function del() {
			hm = document.form.amount;
			sum = document.form.sum;
			if (hm.value > 1) {
				hm.value--;
				sum.value = parseInt(hm.value) * sell_price;
			}
		}

		function change() {
			hm = document.form.amount;
			sum = document.form.sum;

			if (hm.value < 0) {
				hm.value = 0;
			}
			sum.value = parseInt(hm.value) * sell_price;
		}
	</script>
	<div id="main-wrap">
		<div class="container">
			<img src="${contextPath}/resources/image/new4.PNG" width="500px"
				height="500px" />
			<div style="display: block; vertical-align: top;">
				<br> <br> <br> <b style="font-size: 52px">포크찹스테이크</b>

				<h1>10000원</h1>
				<br> <img src="${contextPath}/resources/image/mini1.PNG"
					width="50px" height="50px" /> <img
					src="${contextPath}/resources/image/mini2.PNG" width="50px"
					height="50px" /> <img
					src="${contextPath}/resources/image/mini3.PNG" width="50px"
					height="50px" /> <img
					src="${contextPath}/resources/image/mini4.PNG" width="50px"
					height="50px" /> <br>
				<div id="text">
					<h4>간편하게 집에서 찹스테이크를 해먹을 수 있습니다</h4>
					<h4>
						<b>유통기한</b> : 수령일 포함 2일 이상 남은 제품을 보내드립니다
					</h4>
					<h4>판매단위 : 3~4인분</h4>
					<h4>알레르기 정보 : 우유,대두,돼지고기,토마토,쇠고기 함유</h4>
				</div>
				<div id="price">
					<form name="form" method="get">

						<b>수량 : &nbsp;<input type="button" value=" + "
							onclick="add();"> <input type=hidden name="sell_price"
							value="10000"> <input type="text" name="amount" value="1"
							size="1" onchange="change();"> <input type="button"
							value=" - " onclick="del();"><br> <br> 금액 : <input
							type="text" name="sum" size="8"
							style="width: 100px; height: 30px; font-size: 30px; border: none; border-right: 0px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;">원
						</b>
					</form>
				</div>
				<br> <a href="./products.jsp" class="button">찜하기</a> <a
					href="${contextPath}/order/orderform.do" class="button"> 구매하기</a> <a
					href="${contextPath }/main/cart.do" class="button">장바구니담기</a>

			</div>
		</div>
		<br>



		<div style="margin: 10px 0 0 0;">
			<div class="container1">
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">상품 상세</li>
					<li class="tab-link" data-tab="tab-2">리뷰</li>
					<li class="tab-link" data-tab="tab-3">상품문의</li>
				</ul>
			</div>

			<div id="tab-1" class="tab-content current">
				<h1>상품상세정보</h1>
				<div class="detail">
					<iframe width="100%" height="600px;"
						src="https://www.youtube.com/embed/nWHeZkrQix0?&loop=1">
					</iframe>
					<img src="${contextPath}/resources/image/detail1.png" width="100%" /><br>
					<img src="${contextPath}/resources/image/detail2.png" width="100%" /><br>
					<img src="${contextPath}/resources/image/detail3.png" width="100%" /><br>
					<img src="${contextPath}/resources/image/detail4.png" width="100%" /><br>

				</div>

			</div>
			<div id="tab-2" class="tab-content">
				<div class="detail">
					<div id="tabletitle">
						<h1>리뷰</h1>
					</div>
					<hr>
					<br> <br>

					<div class="table-container">
						<table class="stable-striped">
							<thead>
								<tr id="top-table">
									<th width="200px">별점</th>
									<th width="200px">작성자</th>
									<th width="500px">제목</th>
									<th width="200px">날짜</th>
								</tr>
							</thead>

							<c:choose>
								<c:when test="${empty boardGr}">
									<tr>
										<td colspan=5 class="fixed"><strong>작성된 글이 없습니다.</strong></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${boardGr}">
										<label for="border-bottom"></label>
										<tr class="border-bottom">
											<c:choose>
												<c:when test="${not empty item.u_id and empty item.secret }">
													<td><c:choose>
															<c:when test="${item.star == 5}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
															</c:when>
															<c:when test="${item.star == 4}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star"></span>
															</c:when>
															<c:when test="${item.star == 3}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star"></span>
																<span class="fa fa-star"></span>
															</c:when>
															<c:when test="${item.star == 2}">
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
														</c:choose></td>
													<td>${item.u_id}</td>
													<td><a
														href="${contextPath}/board_gr/b_grDetail.do?b_gr_id=${item.b_gr_id}">${item.title}</a></td>
													<td>${item.creDate}</td>
												</c:when>
												<c:when
													test="${not empty item.u_id and not empty item.secret }">
													<td><c:choose>
															<c:when test="${item.star == 5}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
															</c:when>
															<c:when test="${item.star == 4}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star"></span>
															</c:when>
															<c:when test="${item.star == 3}">
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star checked"></span>
																<span class="fa fa-star"></span>
																<span class="fa fa-star"></span>
															</c:when>
															<c:when test="${item.star == 2}">
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
														</c:choose></td>
													<td>****</td>
													<td>비밀글입니다</td>
													<td>${item.creDate}</td>
												</c:when>
											</c:choose>
										</tr>

									</c:forEach>
								</c:otherwise>
							</c:choose>

							<tr>
								<td colspan=8 class="fixed"><c:forEach var="page" begin="1"
										end="9" step="1">
										<c:if test="${section >0 && page==1 }">
											<a
												href="${contextPath}/board1/selectBoard1List.do?section=${section}-1&pageNum=${(section-1)*10+1 }">preview</a>
										</c:if>
										<a
											href="${contextPath}/board1/selectBoard1List.do?section=${section}&pageNum=${page}">${(section)*10 +page}
										</a>
										<c:if test="${page ==10 }">
											<a
												href="${contextPath}/board1/selectBoard1List.do?section=${section}+1&pageNum=${section*10}+1">next</a>
										</c:if>
									</c:forEach></td>
							</tr>

							</tbody>
						</table>



					</div>

					<hr>
					<br>
					<div id="write">
						<a href="${contextPath }/boardGr/boardGrWrite.do">글쓰기</a>
					</div>



				</div>
			</div>
			<div id="tab-3" class="tab-content">
				<div class="detail">
					<div id="write">
						<a href="/bbs/writeForm.bbs?pageNum=${pageNum}">글쓰기</a>
					</div>
					<div id="tabletitle">
						<h1>1대1문의</h1>

					</div>
					<table class="review-table">
						<thead>
							<tr id="top-table">
								<th width="10%">번호</th>
								<th width="40%">제목</th>
								<th width="20%">작성자</th>
								<th width="20%">작성일</th>
								<th width="10%">답변완료</th>
							</tr>

						</thead>
						<tbody>

							<tr class="border-bottom">
								<td>1</td>
								<td id="title"><a
									href="/bbs/content.bbs?articleNumber=${article.articleNumber}&pageNum=${pageNum}">택배
										얼마나 걸릴까요?</a></td>
								<td>한태상</td>
								<td>2022-04-12</td>
								<td>답변완료</td>
							</tr>
							<tr class="border-bottom">
								<td>2</td>
								<td id="title"><a
									href="/bbs/content.bbs?articleNumber=${article.articleNumber}&pageNum=${pageNum}">재입고
										문의 드립니다</a></td>
								<td>한태상</td>
								<td>2022-04-12</td>
								<td>답변완료</td>
							</tr>
							<tr class="border-bottom">
								<td>3</td>
								<td id="title">주문이 아직 오지 않았습니다</td>
								<td>한태상</td>
								<td>2022-04-12</td>
								<td>미답변</td>
							</tr>
						</tbody>
					</table>

				</div>

			</div>
		</div>
	</div>
</body>
</html>