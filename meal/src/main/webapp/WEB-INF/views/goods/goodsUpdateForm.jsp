<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록페이지</title>
</head>
<<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
  var cnt=0;
  function fn_addFile(){
	  if(cnt == 0){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
	  }
  	
  	cnt++;
  }
  
  
  function fn_add_new_goods(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }
		 
	} 
$(document).ready(function() {
    $('#test').on('keyup', function() {
        $('#test_cnt').html("("+$(this).val().length+" / 2000)");
 
        if($(this).val().length > 2000) {
            $(this).val($(this).val().substring(0, 2000));
            $('#test_cnt').html("(2000 / 2000)");
        }
    });
})

//추후 변경할 예정
function fn_overlapped(){
    var _g_name=$("#_g_name").val();
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/goods/goodsoverlapped.do",
       dataType:"text",
       data: {g_name:_g_name},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 상품명입니다.");
       	    $('#btnOverlapped').prop("disabled", true);
       	    $('#g_name').val(_g_name); 
       	 
          }else{
        	  alert("사용할 수 없는 상품명입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
</script>

<style>


.goodsform textarea {
    height: 6.25em;
    border: 1px solid;
    resize: none;
  }
 .goodsform th{
 text-align: left;
 }


#goodsform-container .goodsform {
margin: auto;
}

#goodsform-container h1{
text-align: center;
background-color: #ffc0cb;
margin: 0px;
}
#goodsform-container {
border: solid 1px;
margin: 10px;
}
</style>
<body>
<div id="goodsform-container">
<h1> 상품 수정하기</h1>
<form id="frmUpdateGoods" name="frmUpdateGoods" action="${contextPath}/goods/goodsUpdate.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="s_id" value= "${sellerInfo.s_id}"/>
	<table class="goodsform">
		<tr class="box">
			<th>상품사진*</th>
			<td><input type="file" name="main"></td>
		</tr>
		<tr class="box">
			<th>상품명*</th>
			<td>
			<input type="text" name="g_name" id="_g_name" value="${goodsInfo.g_name}"  required="required" />
			</td>
			<td><input type="button" value="중복확인" onclick="fn_overlapped()" id="btnOverlapped"></td>
		</tr>
			<tr class="box">
			<th>상품가격*</th>
			<td><input type="text" name="g_price" id="g_price" value="${goodsInfo.g_price }" required="required" placeholder="00000원" />
			</td>
		</tr>
			<tr class="box">
			<th>수량*</th>
			<td><input type="text" name="g_amount" id="g_amount" value="${goods.g_amount }" placeholder="재고 수량" required="required" />
				</td>
		</tr>
		<tr class="box">
			<th>카테고리 설정*</th>
			<td>
			<div id = "form-div">
					<input type="radio" class="g_cate2" id="formRadio1" name="g_cate2" value="찌개/탕/찜" checked>
					 <label for="formRadio1">찌개/탕/찜</label> 
					 <input type="radio" class="g_cate2" id="formRadio2" name="g_cate2" value="식사/안주" checked>
					 <label for="formRadio2">식사/안주</label> 
					 <input type="radio" class="g_cate2" id="formRadio3" name="g_cate2" value="죽" checked> 
					 <label for="formRadio3">죽</label>
				</div>
					<div id = "form-div">
					<input type="radio" class="g_cate2" id="formRadio4" name="g_cate2" value="간편식" checked>
					 <label for="formRadio4">간편식</label> 
					 <input type="radio" class="g_cate2" id="formRadio5" name="g_cate2" value="고기"checked>
					 <label for="formRadio5">고기</label> 
					 <input type="radio" class="g_cate2" id="formRadio6" name="g_cate2" value="기타" checked> 
					 <label for="formRadio6">기타</label>
				</div>
				</td>
		</tr>
		<tr class="box">
			<th>난이도*</th>
			<td><div id = "form-div">
					<input type="radio" id="g_nan" name="g_nan" value="상" checked>
					 <label for="g_nan">상</label> 
					 <input type="radio" id="g_nan" name="g_nan" value="중" checked>
					 <label for="g_nan">중</label> 
					  <input type="radio" id="g_nan" name="g_nan" value="하" checked>
					 <label for="g_nan">하</label> 
				</div>
				</td>
		</tr>
		<tr class="box">
			<th>모범음식점 여부*</th>
			<td><div id = "form-div">
					<input type="radio" id="g_cate3" name="g_cate3" value="HACCP" checked>
					 <label for="g_cate3">HACCP</label> 
					 <input type="radio" id="g_cate3" name="g_cate3" value="모범음식점" checked>
					 <label for="g_cate3">모범음식점</label>
					 <input type="radio" id="g_cate3" name="g_cate3" value="HACCP/모범음식점" checked>
					 <label for="g_cate3">HACCP/모범음식점</label> 
					 <input type="radio" id="g_cate3" name="g_cate3" value="X" checked>
					 <label for="g_cate3">X</label> 
				</div>
				</td>
		</tr>
		<tr class="box">
			<th>조리 시간*</th>
			<td><input type="text" name="g_time" id="g_time" value="${goods.g_time}" placeholder="조리시간(분)"
				required="required" /></td>
		</tr>
		<tr class="box">
			<th>보관방법*</th>
			<td><div id = "form-div"> 
			<input type="radio" id="g_bang" name="g_bang" value="냉동" checked>
					 <label for="g_bang">냉동</label> 
					 <input type="radio" id="g_bang" name="g_bang" value="냉장" checked> 
					 <label for="g_bang">냉장</label>
					  <input type="radio" id="g_bang" name="g_bang" value="실온" checked> 
					 <label for="g_bang">실온</label>
					 </div>
					 </td>
		</tr>
		<tr class="box">
			<th>인분수*</th>
			<td><div id = "form-div"> 
			<input type="radio" id="g_inbun" name="g_inbun" value="1~2인분" checked>
					 <label for="g_inbun">1~2인분</label> 
					 <input type="radio" id="g_inbun" name="g_inbun" value="2~3인분" checked> 
					 <label for="g_inbun">2~3인분</label>
					  <input type="radio" id="g_inbun" name="g_inbun" value="3~4인분" checked> 
					 <label for="g_inbun">3~4인분</label>
					 </div></td>
		</tr>
		<tr class="box">
			<th>유통기한*</th>
			<td colspan="3"><input type="text" id="g_eatDate" name = "g_eatDate" value="${goods.g_eatDate }" placeholder="유통기한" required></td>
		</tr>
		<tr class="box">
			<th>알러지 유발 성분*</th>
			<td colspan="3"><textarea id="allergy" name = "g_allergy" value="${goods.g_allergy }" cols="30" rows="10"></textarea></td>
		</tr>
		<tr class="box">
			<th>상세이미지*</th>
			<td><input type="file" name="detail" /></td>
		</tr>
		<tr class="box">
			<th>상세설명*</th>
			<td><textarea id="test" name="g_detail1" cols="30" rows="10" value="${goods.g_detaile1 }"></textarea>
				<div id="test_cnt">(0 / 2000)</div></td>
		</tr>


	</table>

	<input type="submit" id="addgoods"  value="상품등록" >

	</form>
	</div>
</html>