<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:if test='${not empty message  }'>
	<script>
		window.onload = function() {
			result();
		}

		function result() {
			alert(message);
		}
	</script>
</c:if>
<!DOCTYPE html >
<html>
<head>

<meta charset="utf-8">
<title>너도 요리할 수 있어!</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var ftrlRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (ftrlRoadAddr !== '') {
							ftrlRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('roadAddress').value = ftrlRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
						} else {
							document.getElementById('guide').innerHTML = '';
						}

					}
				}).open();
	}

	function fn_overlapped() {
		var _id = $("#_u_id").val();
		if (_id == '') {
			alert("ID를 입력하세요");
			return;
		}
		$.ajax({
			type : "post",
			async : false,
			url : "${contextPath}/member/overlapped.do",
			dataType : "text",
			data : {
				id : _id
			},
			success : function(data, textStatus) {
				if (data == 'false') {
					alert("사용할 수 있는 ID입니다.");
					$('#btnOverlapped').prop("disabled", true);
					$('#_u_id').prop("disabled", true);
					$('#addmember').prop("disabled", false);
					$('#u_id').val(_id);
				} else {
					alert("사용할 수 없는 ID입니다.");
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다.");
				ㅣ
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax  	
	}
/* 
	function chkPW() {

		var pw = $("#pwd").val();
		var id = $("#u_id").val();
		var checkNumber = pw.search(/[0-9]/g);
		var checkEnglish = pw.search(/[a-z]/ig);

		if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)) {
			alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
			return false;
		} else if (checkNumber < 0 || checkEnglish < 0) {
			alert("숫자와 영문자를 혼용하여야 합니다.");
			return false;
		} else if (/(\w)\1\1\1/.test(pw)) {
			alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
			return false;
		} else if (pw.search(id) > -1) {
			alert("비밀번호에 아이디가 포함되었습니다.");
			return false;
		} else {

			console.log("통과");

		}

	} */
</script>
<style>
#container {
	display: flex;
	clear: both;
	max-width: 1280px;
	height: 3000px;
	align-items: flex-start;
	width: 100%;
	height: 100%;
	flex-direction: row-reverse;
	justify-content: space-around;
	font-size: x-large;
}

.any {
	border-collapse: collapse;
	width: 800px;
	font-size: inherit;
}

.any h1 {
	text-align: center;
}

.any input {
	border-collapse: collapse;
	font-size: smaller;
	border-radius: 4px;
	font-size: smaller;
}

tr.box {
	border-bottom: 1px solid rgba(255, 192, 207, 1);
}

.box td {
	padding-left: 5%;
	height: 50px;
}

.box th {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-left: none;
	text-align: left;
}

.box11 th {
	background-color: #d7d7d7;
	border: 1px solid #939393;
	border-left: none;
	border-right: none;
	text-align: left;
}

.box13 td {
	text-align: center;
	border: none;
	height: 50px;
}

.any td#zipcode {
	border-bottom: none;
	padding-top: 1%;
	padding-left: 5%;
}

.any td#road {
	border: none;
	padding-left: 5%;
	padding-bottom: 1%;
}

.any td#detailzip {
	padding-left: 5%;
	padding-bottom: 1%;
}

#frmMem h1 {
	text-align: center;
	color: #939393;
	font-weight: bold;
}

#frmMem input#btnOverlapped {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmMem input#hp2 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmMem input#hpA1 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmMem select#email3 {
	width: 175px;
	border-radius: 4px;
	height: 26px;
}

#frmMem input#zipcode1 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmMem select#email3 {
	width: 170px;
	border-radius: 4px;
	font-size: smaller;
}

#frmMem input#addmember {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	height: 60px;
	width: 250px;
	font-size: 20px;
	font-weight: bold;
	color: #666666;
	display: block;
	margin-top: 15px;
	margin-bottom: 15px;
	font-size: x-large;
}

#frmMem input#back {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	height: 60px;
	width: 250px;
	font-size: 20px;
	font-weight: bold;
	color: #666666;
	display: block;
	margin-bottom: 15px;
	font-size: x-large;
}

#frmMem td.righttd {
	padding-left: 0;
}

#frmMem td#zipcode22 {
	padding-left: 0;
}

#frmMem a#agree3 {
	font-size: medium;
}

#frmMem a#agree2 {
	font-size: medium;
}

#frmMem input#u_sex {
	margin-left: 60px;
}

#frmMem input#roadAddress {
	width: 400px;
}

#frmMem input.detail {
	width: 400px;
}

/*약관동의1  */
.agree-context {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.7);
	z-index: 500;
	display: none;
}

.agree-context .agree-inner {
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

.agree-context .agree-inner .agree-close {
	width: 30px;
	height: 27px;
	border: 0;
	position: absolute;
	right: 35%;
	top: 10px;
	background: #ffc0cf;
	/* 백그라운드는 이너와 맞춰줄것 */
}

.agree-context .agree-inner .agree-close img {
	width: 100%;
	height: 100%;
	position: absolute;
}

.agree-context1 {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.7);
	z-index: 500;
	display: none;
}

.agree-context1 .agree-inner1 {
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

.agree-context1 .agree-inner1 .agree-close1 {
	width: 30px;
	height: 27px;
	border: 0;
	position: absolute;
	right: 35%;
	top: 10px;
	background: #ffc0cf;
	/* 백그라운드는 이너와 맞춰줄것 */
}

.agree-context1 .agree-inner1 .agree-close1 img {
	width: 100%;
	height: 100%;
	position: absolute;
}
</style>
</head>
	
	<section>
		<div id="container">
			<form id="frm" name="frmM"
				action="${contextPath}/admin/addadmin.do" method="post">
				<table class="any">
					<h1 style="text-align: center">일반고객 회원가입</h1>
					<tr class="box">
						<th>아이디*</th>
						<td><input type="text" name="_u_id" id="_u_id"
							placeholder="아이디" required="required" /> <input type="hidden"
							name="u_id" id="u_id" />
						<td colspan="2" class="righttd"><input type="button"
							id="btnOverlapped" value="중복확인" onClick="fn_overlapped()" /></td>
					</tr>
		<tr class="box">
						<th>비밀번호*</th>
						<td colspan="3"><input name="u_pw" id="pwd" type="password"
							placeholder="비밀번호" required="required"  /></td>
					</tr>
					</tr>
					<tr class="box">
						<th>이름*</th>
						<td colspan="3"><input name="u_name" id="name" type="text"
							required="required" /></td>
					</tr>
					<tr class="box">
						<th>생년월일*</th>
						<td colspan="3"><input name="u_birth" id="YMD" type="date"
							value="submit" required="required" /></td>
					</tr>
					<tr class="box">
						<th>휴대폰*</th>
						<td><input type="tel" name="u_hp1" id="hp1"
							required="required" /></td>
						<td colspan="2" class="righttd"><input type="button" id="hp2"
							value="인증 전송" /></td>
					</tr>
					<tr class="box">
						<th>email*</th>
						<td><input type="text" name="u_email1" id="email"
							required="required" /></td>
						<td class="righttd"><select name="u_email2" id="email3"
							onChange="" title="직접입력">
								<option value="naver.com">선택하세요</option>
								<option value="naver.com">@naver.com</option>
								<option value="yahoo.co.kr">@yahoo.co.kr</option>
								<option value="hotmail.com">@hotmail.com</option>
								<option value="paran.com">@paran.com</option>
								<option value="nate.com">@nate.com</option>
								<option value="gmail.com">@gmail.com</option>
						</select></td>
					</tr>
					<!-- 	이부분이 유효성검사가능
		<tr class="box13">
				<td colspan="4"><input type="submit" class="addmember" id="addmember" value="회원 가입"></td> colspan=3
			</tr> -->
				</table>
				<center>
					<input type="submit" value="회원가입" id="addmember" disabled="true">
					<input type="button" value="뒤로가기" id="back">
				</center>
			</form>
		</div>
	</section>
</body>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${contextPath }/resources/js/memberForm.js">
</script>
</html>