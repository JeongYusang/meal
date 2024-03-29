<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>메인페이지</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(function() {
		var n = 0;
		var pos = 0;
		setInterval(function() {
			n = n + 1;
			pos = -1 * 1280 * n;
			$(".slider-ul").animate({
				"left" : pos
			}, 300, function() {
				if (n == 2) {
					n = 0;
					pos = 0;
					$(".slider-ul").css({
						"left" : pos
					});
				}
			});
		}, 3000);
	});
</script>
<style>
</style>
<style>
.maingoodslist {
	width: 1280px;
	display: block;
	position: relative;
}

.maingList {
	width: 100%;
	display: inline-flex;
	justify-content: space-around;
}

.mangList .ul li a {
	display: inline-block;
}

.maingList .ul li, .maingoodslist .ol li {
	display: inline-block;
	text-align: center;
}

#main-wrap .img {
	display: inline-block;
	margin: 0 10px 0 10px;
}

#main-wrap .b {
	margin-left: 150px;
	text-align: center;
}

#main-wrap {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	width: 1280px;
}

.slider {
	position: relative;
	width: 100%;
	height: 277px;;
	overflow: hidden;
	display: inline-block;
	margin-left: 20px;
}

.slider-ul {
	position: absolute;
	left: 0;
	top: 0;
	overflow: hidden;
	display: inline-block;
	padding-inline-start: 0px;
}

.slider-ul li {
	height: 277px;
	float: left;
	display: inline-block;
}

.slider-ul li img {
	height: 277px;
	width: 1256px;
}
</style>

</head>
<body>
	<div id="main-wrap">
		<div>
			<div class="slider">
				<ul class="slider-ul">
					<li class="active"><a href="#"> <img
							src="${contextPath}/resources/image/banner1.PNG" alt="이미지">
					</a></li>
					<li class=""><a href="#"> <img
							src="${contextPath}/resources/image/banner2.PNG" alt="이미지">
					</a></li>


				</ul>
			</div>



			<div class="maingoodslist">
				<b class="b" style="font-size: 32px">신상품</b>
				<div class="maingList">

					<!-- 다운로드 메소드를 통해서 한것 -->
					<c:forEach var="item" items="${goodsMap.NewG}" begin="0" end ="3">
						<ul class="ul">
					
							<li><a href="${contextPath }/goods/goodsDetail.do?g_id=${item.g_id}"><img
									src="${contextPath}/download1.do?g_id=${item.g_id}&cate=main"
									width="250px" height="250px">
									<br>${item.g_name }
									<br>	${item.g_price}원</a></li>
						</ul>
					</c:forEach>

				</div>
				<b class="b" style="font-size: 32px">일반상품</b>
				<div class="maingList">
					<!--썸네일 메소드를 이용한것  -->
					<c:forEach var="item" items="${goodsMap.NomalG}" begin="0" end ="3">
						<ul class="ul">
						
							<li><a href="${contextPath }/goods/goodsDetail.do?g_id=${item.g_id}""><img
									src="${contextPath}/download1.do?g_id=${item.g_id}&cate=main"
									width="250px" height="250px">
									<br>${item.g_name }
									<br>	${item.g_price}원</a></li>
						</ul>
					</c:forEach>
				</div>
				<b class="b" style="font-size: 32px">인기상품</b>
				<div class="maingList">
					<c:forEach var="item" items="${goodsMap.bestG}" begin="0" end ="3">
						<ul class="ul">
							<li><a href="${contextPath }/goods/goodsDetail.do?g_id=${item.g_id}""><img
									src="${contextPath}/download1.do?g_id=${item.g_id}&cate=main"
									width="250px" height="250px">
									<br>${item.g_name }
									<br>	${item.g_price}원</a></li>
						</ul>

					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>



