<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String message = (String) request.getAttribute("message");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<c:if test='${ not empty message}'>
	<script>
window.onload=function()
{
  result();
}

function result(){
	alert(${message});
}


</script>
</c:if>
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

	 function fn_overlapped(){
	       var _id=$("#_s_id").val();
	       if(_id==''){
	          alert("ID를 입력하세요");
	          return;
	       }
	       $.ajax({
	          type:"post",
	          async:false,  
	          url:"${contextPath}/member/overlapped.do",
	          dataType:"text",
	          data: {id:_id},
	          success:function (data,textStatus){
	             if(data=='false'){
	                 alert("사용할 수 있는 ID입니다.");
	                 $('#btnOverlapped').prop("disabled", true);
	                 $('#_s_id').prop("disabled", true);
	                 $('#s_id').val(_id);
	             }else{
	                alert("사용할 수 없는 ID입니다.");
	             }
	          },
	          error:function(data,textStatus){
	             alert("에러가 발생했습니다.");ㅣ
	          },
	          complete:function(data,textStatus){
	             //alert("작업을완료 했습니다");
	          }
	       });  //end ajax  	
	}
	 
/* 	 function chkPW(){

			var pw = $("#pwd").val();
			var id = $("#s_id").val();
		    var checkNumber = pw.search(/[0-9]/g);
		    var checkEnglish = pw.search(/[a-z]/ig);
		 
		    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)){            
		        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
		        return false;
		    }else if(checkNumber <0 || checkEnglish <0){
		        alert("숫자와 영문자를 혼용하여야 합니다.");
		        return false;
		    }else if(/(\w)\1\1\1/.test(pw)){
		        alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
		        return false;
		    }else if(pw.search(id) > -1){
		        alert("비밀번호에 아이디가 포함되었습니다.");
		        return false;
		    }else {

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

#frmSel h1 {
	text-align: center;
	color: #939393;
	font-weight: bold;
}

#frmSel input#btnOverlapped {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmSel input#hp2 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmSel input#hpA1 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmSel select#email3 {
	width: 175px;
	border-radius: 4px;
	height: 26px;
}

#frmSel input#zipcode1 {
	background-color: rgba(255, 192, 207, 0.7);
	border: 1px solid rgba(255, 192, 207, 1);
	border-radius: 3px;
	font-size: 15px;
	font-weight: bold;
	color: black;
	width: 100%;
	height: 50px;
}

#frmSel select#email3 {
	width: 170px;
	border-radius: 4px;
	font-size: smaller;
}

#frmSel input#addmember {
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

#frmSel input#back {
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

#frmSel td.righttd {
	padding-left: 0;
	padding-right:
}

#frmSel td#zipcode22 {
	padding-left: 0;
}

#frmSel input#s_BLNum {
	width: 365px;
}

#frmSel input#s_HACCP {
	width: 365px;
}

#frmSel input#s_GRNum {
	width: 365px;
}

#frmSel a#agree3 {
	font-size: medium;
}

#frmSel a#agree2 {
	font-size: medium;
}

#frmSel input.cheche {
	height: 20px;
}

#frmSel td#filetext {
    font-size: small;
    color: #6666664d;
    padding-left: 0px;
}

/* 이용약관에 관한 모달 */
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

<body>
	<div class="agree-context">

		<!-- Modal content -->
		<div class="agree-inner">
			<h1 id="ag">너도 요리할 수 있어 약관동의</h1>
			<div id=ag1>
				가. 수집하는 개인정보의 항목첫째, 회사는 회원가 입, 원활한 고객상담, <br> 각종 서비스의 제공을 위해 최초
				회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.<br> <br> 회원가입
				- 이름, 생년월일, 성별, 아이디, 비밀번호, 별명, 연락처(메일주소, 휴대폰 번호 중 선택), 가입인증정보<br>
				<br> 만14세 미만 아동 회원가입 - 이름, 생년월일, 성별, 법정대리인 정보, 아이디, 비밀번호,<br>
				연락처 (메일주소, 휴대폰 번호 중 선택), 가입인증정보<br> <br> 단체아이디 회원가입 -
				단체아이디, 회사명, 대표자명, 대표 전화번호, 대표 이메일 주소, 단체주소, 관리자 아이디, 관리자 연락처, 관리자
				부서/직위<br> <br> - 선택항목 : 대표 홈페이지, 대표 팩스번호<br> 둘째, 서비스
				이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br> <br>
				- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록<br> 셋째, 네이버 아이디를
				이용한 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 <br> 해당 서비스의 이용자에 한해서만
				개인정보 추가 수집이 발생할 수 있으며, 이러한 경우 별도의 동의를 받습니다.<br> <br> 넷째,
				성인컨텐츠, 유료/게임 등 일부 서비스 이용시 관련 법률 준수를 위해 본인인증이 필요한 경우, <br> 아래와
				같은 정보들이 수집될 수 있습니다.<br> - 이름, 생년월일, 성별, 중복가입확인정보(DI), 암호화된 동일인
				식별정보(CI), 휴대폰 번호(선택), <br> 아이핀 번호(아이핀 이용시), 내/외국인 정보<br> <br>
				다섯째, 유료 서비스 이용 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다.<br> - 신용카드 결제시 :
				카드사명, 카드번호 등<br> - 휴대전화 결제시 : 이동전화번호, 통신사, 결제승인번호 등<br> -
				계좌이체시 : 은행명, 계좌번호 등 - 상품권 이용시 : 상품권 번호<br> <br> 나. 개인정보
				수집방법회사는 다음과 같은 방법으로 개인정보를 수집합니다.<br> - 홈페이지, 서면양식, 팩스, 전화, 상담
				게시판, 이메일, 이벤트 응모, 배송요청<br> - 협력회사로부터의 제공<br> - 생성정보 수집 툴을
				통한 수집<br> <br>
				<button class="agree-close">
					<img src="${contextPath }/resources/image/siteMap_close.jpg" />
				</button>
			</div>
		</div>
	</div>

	<div class="agree-context1">

		<!-- Modal content -->
		<div class="agree-inner1">
			<h1 id="ag">너도 요리할 수 있어 약관동의</h1>
			<div id=ag1>
				가. 수집하는 개인정보의 항목첫째, 회사는 회원가 입, 원활한 고객상담, <br> 각종 서비스의 제공을 위해 최초
				회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.<br> <br> 회원가입
				- 이름, 생년월일, 성별, 아이디, 비밀번호, 별명, 연락처(메일주소, 휴대폰 번호 중 선택), 가입인증정보<br>
				<br> 만14세 미만 아동 회원가입 - 이름, 생년월일, 성별, 법정대리인 정보, 아이디, 비밀번호,<br>
				연락처 (메일주소, 휴대폰 번호 중 선택), 가입인증정보<br> <br> 단체아이디 회원가입 -
				단체아이디, 회사명, 대표자명, 대표 전화번호, 대표 이메일 주소, 단체주소, 관리자 아이디, 관리자 연락처, 관리자
				부서/직위<br> <br> - 선택항목 : 대표 홈페이지, 대표 팩스번호<br> 둘째, 서비스
				이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br> <br>
				- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록<br> 셋째, 네이버 아이디를
				이용한 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 <br> 해당 서비스의 이용자에 한해서만
				개인정보 추가 수집이 발생할 수 있으며, 이러한 경우 별도의 동의를 받습니다.<br> <br> 넷째,
				성인컨텐츠, 유료/게임 등 일부 서비스 이용시 관련 법률 준수를 위해 본인인증이 필요한 경우, <br> 아래와
				같은 정보들이 수집될 수 있습니다.<br> - 이름, 생년월일, 성별, 중복가입확인정보(DI), 암호화된 동일인
				식별정보(CI), 휴대폰 번호(선택), <br> 아이핀 번호(아이핀 이용시), 내/외국인 정보<br> <br>
				다섯째, 유료 서비스 이용 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다.<br> - 신용카드 결제시 :
				카드사명, 카드번호 등<br> - 휴대전화 결제시 : 이동전화번호, 통신사, 결제승인번호 등<br> -
				계좌이체시 : 은행명, 계좌번호 등 - 상품권 이용시 : 상품권 번호<br> <br> 나. 개인정보
				수집방법회사는 다음과 같은 방법으로 개인정보를 수집합니다.<br> - 홈페이지, 서면양식, 팩스, 전화, 상담
				게시판, 이메일, 이벤트 응모, 배송요청<br> - 협력회사로부터의 제공<br> - 생성정보 수집 툴을
				통한 수집<br> <br>
				<button class="agree-close1">
					<img src="${contextPath }/resources/image/siteMap_close.jpg" />
				</button>
			</div>
		</div>
	</div>
	<section>
		<div id="container">
			<form id="frmSel" name="frmSel"
				action="${contextPath }/seller/addSeller.do" method="post"
				enctype="multipart/form-data">
				<table class="any">
					<h1>사업자 회원가입</h1>
					<tr class="box">
						<th>아이디*</th>
						<td><input type="text" name="_s_id" id="_s_id"
							placeholder="아이디" required="required" /> <input type="hidden"
							name="s_id" id="s_id" />
						<td colspan="2" class="righttd"><input type="button"
							id="btnOverlapped" value="중복확인" onClick="fn_overlapped()" /></td>
					</tr>
					<!-- 					<tr class="box">
						<th>비밀번호*</th>
						<td colspan="2"><input name="s_pw" id="pwd" type="password" placeholder="비밀번호" required="required" onchange="chkPW()" /></td>
					</tr>
					<tr class="box">
						<th>비밀번호 확인*</th>
						<td><input name="pwtest" id="pwtest" type="password" placeholder="비밀번호 확인" required="required" onchange="chkPW()" /></td>
					</tr> -->
					<tr class="box">
						<th>비밀번호*</th>
						<td colspan="2"><input name="s_pw" id="pwd" type="password"
							placeholder="비밀번호" required="required" /></td>
					</tr>
					<tr class="box">
						<th>비밀번호 확인*</th>
						<td><input name="pwtest" id="pwtest" type="password"
							placeholder="비밀번호 확인" required="required" /></td>
					</tr>
					<tr class="box">
						<th>이름*</th>
						<td colspan="2"><input name="s_name" id="name" type="text"
							required="required" /></td>
					</tr>
					<tr class="box">
						<th>휴대폰*</th>
						<td><input type="tel" name="s_hp1" id="hp1"
							required="required" /></td>
						<td colspan="2" class="righttd"><input type="button" id="hp2"
							value="인증 전송" onclick="sms_auth_popup();" /></td>
					</tr>
					<tr class="box">
						<th>번호확인*</th>
						<td><input type="text" name="hpA" id="hpA"
							required="required" /></td>
						<td colspan="2" class="righttd"><input type="button"
							id="hpA1" value="인증 확인" /></td>
					</tr>
					<tr class="box">
						<th>email*</th>
						<td><input type="text" name="s_email1" id="email"
							required="required" /></td>
						<td class="righttd"><select name="s_email2" id="email3"
							onChange="" title="직접입력">
								<option value="naver.com">@naver.com</option>
								<option value="yahoo.co.kr">@yahoo.co.kr</option>
								<option value="hotmail.com">@hotmail.com</option>
								<option value="paran.com">@paran.com</option>
								<option value="nate.com">@nate.com</option>
								<option value="gmail.com">@gmail.com</option>
						</select></td>
					</tr>
					<tr class="box">
						<th>판매자 기준</th>
						<td><input type="radio" class="cheche" name="s_cate"
							value="P">개인 <input type="radio" class="cheche"
							name="s_cate" value="B">법인</td>
					</tr>
					<tr class="box">
						<th>인증 내역</th>
						<td><input type="checkbox" class="cheche">HACCP<input
							type="checkbox" class="cheche">모범음식점</td>
					</tr>
					<tr class="box">
						<th rowspan="3">등록번호*</th>
						<td id="BLNum"><input type="text" id="s_BL_Num"
							name="s_BL_Num" placeholder="사업자등록번호"></td>
					</tr>
					<tr class="box">
						<td id="HACCP"><input type="text" id="s_HACCP_Num"
							name="s_HACCP_Num" placeholder="HACCP등록번호"></td>
					</tr>
					<tr class="box">
						<td id="GRNum"><input type="text" id="s_GR_Num"
							name="s_GR_Num" placeholder="모범음식점등록번호"></td>
					</tr>
					<tr class="box">
						<th rowspan="3">증빙 서류</th>
						<td id="BLNum"><input type="file" name="s_BL" id="s_BLNum"></td>
						<td id="filetext">사업자 등록증</td>
					</tr>
					<tr class="box">
						<td id="HACCP"><input type="file" name="s_HACCP" id="s_HACCP"></td>
						<td id="filetext">HACCP</td>
					</tr>
					<tr class="box">
						<td id="GRNum"><input type="file" name="s_GR" id="s_GRNum"></td>
						<td id="filetext">모범음식점</td>
					</tr>
					<tr class="box">
						<th rowspan="3">사업장 소재지*</th>
						<td id="zipcode33"><input type="text" name="s_Waddr1"
							id="zipcode" placeholder="우편번호"></td>
						<td id="zipcode22"><input type="button" value="우편번호 찾기"
							id="zipcode1" onclick="execDaumPostcode()"></td>
					</tr>
					<tr class="box">
						<td id="road"><input type="text" id="roadAddress"
							name="s_Waddr2" placeholder="도로명 주소"></td>
					</tr>
					<tr class="box">
						<td id="detailzip"><input type="text" name="s_Waddr3"
							placeholder="상세주소"></td>
					</tr>
					<tr class="box">
						<th>사업장 명*</th>
						<td><input type="text" name="s_Wname" placeholder="사업장 명"></td>
					</tr>
					<tr class="box">
						<th rowspan="2"><h4>필수동의*</h4></th>
                  <td colspan="4"><input type="checkbox" value="agree" id="label1" required><label for="label1">이용약관
                     동의 (필수)</label>
							<button id="agree3" type="button">약관보기</button></td>
					</tr>
					<tr class="box">
                  <td colspan="4"><input type="checkbox" value="agree" required id="label2"><label for="label2">개인정보
                     수집 및 이용동의 (필수)</label>
							<button id="agree2" type="button">약관보기</button></td>
					</tr>

				</table>
				<center>
					<input type="submit" value="회원가입" id="addmember"> <input
						type="button" value="뒤로가기" id="back">
				</center>
			</form>
		</div>
	</section>
</body>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${contextPath }/resources/js/sellerForm.js"></script>
</html>