<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/proc/mypage_member_info.asp"-->

<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head.asp"-->
</head>
<body data-number="subGnb03">
	<!-- header -->
	<header class="sub header rel mypage_h">
		<!-- #include virtual="/w2/asset/inc/header_top.asp"-->
		<!-- #include virtual="/w2/asset/inc/header_mypage.asp"-->
		<!-- #include virtual="/w2/asset/inc/header_quick.asp"-->
	</header>
	<a href="javascript:void(0)" class="btn_top">TOP</a>
	<!-- //header -->

	<div class="sub mypage">
		<div class="top bg_mypage">
			<div class="inset">
				<h2 class="tit">회원 정보 수정</h2>
			</div>
			<span class="bg"></span>
			<div class="location no_tab">
				<ul class="clearfix">
					<li class="first"><a href="/w2/"><img src="/w2/asset/images/common/home_icon.png" alt=""></a></li>
					<li class="arrow">
						<a href="/w2/member/mypage.asp">마이페이지</a>
					</li>
					<li class="arrow sub_menu">
						<a href="javascript:void(0)" class="mw143">회원정보수정/탈퇴</a>
						<ul>
							<li><a href="/w2/member/mypage/shuttle_list.asp">예약&amp;구매 내역</a></li>
							<li><a href="/w2/member/customer_list.asp" class="">1:1문의</a></li>
							<li class="on"><a href="/w2/member/mypage/member_pwc.asp" class="">회원정보수정/탈퇴</a></li>
							<li><a href="/w2/member/mypage/pw_change.asp" class="">비밀번호 변경</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<div class="inner pt100 pb143">
			<div class="fs30 brown pb40">회원 정보 수정</div>			
			<div class="txt_right fs16 red2">* 는 필수 입력 사항 입니다.</div>
			<div class="pb69 rel pt10">
				<table class="member_table basic_table txt_left fs16 gray2 fw300">			
				<Form name="frm" id="frm" method='post' >
				<input type="hidden" name="mail_accept_org" value="<%=mb_mail_accept%>">
				<input type="hidden" name="sms_accept_org" value="<%=sms%>">
				<input type="hidden" name="rtnUrl" value="<%=appMobileLink%>">
				<caption>회원 확인</caption>
				<colgroup>
					<col style="width:20%">
					<col style="width:15%">
					<col style="width:auto">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span>이름</th>
						<td colspan="2"><%=mb_name%></td>							
					</tr>
					<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span> 로그인ID</th>
						<td colspan="2"><%=mb_id%></td>
					</tr>
					<!--<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span> 비밀번호</th>
						<td colspan="2">
							<input type="password"  class="basic_input w220" name="pw1" id="pw1" >
							<p class="ib fs16 fw300 gray3 pl10">변경할 비밀번호를 입력해주세요.(8~15자의 영문, 숫자, 특수문자[’”-+/\;:공백제외]를 2종류 이상 조합)</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span> 비밀번호 확인</th>
						<td colspan="2">
							<input type="password"  class="basic_input w220" name="pw2" id="pw2" >	
							<p class="ib fs16 fw300 gray3 pl10">다시 한 번 입력해주세요.</p>
						</td>
					</tr-->
					<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span> 이메일</th>
						<td colspan="2">
							<input type="text"  class="basic_input w143" name="email_1" id="email_1" value="<%=email_1%>" data-valid="notnull"  data-alert="이메일주소">
							@
							<input type="text"  class="basic_input w143" name="email_2" id="email_2" value="<%=email_2%>" data-valid="notnull"  data-alert="이메일주소">
							<select name="lstMail2" id="chgEmail" class="email select_wrap">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="chollian.net">chollian.net</option>
								<option value="dreamwiz.com">dreamwiz.com</option>
								<option value="empal.com">empal.com</option>
								<option value="freechal.com">freechal.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="hanafos.com">hanafos.com</option>
								<option value="kebi.com">kebi.com</option>
								<option value="korea.com">korea.com</option>
								<option value="lycos.co.kr">lycos.co.kr</option>
								<option value="nate.com">nate.com</option>
								<option value="netian.com">netian.com</option>
								<option value="paran.com">paran.com</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
							</select>	
							<input type="hidden" name="email" id="email" data-valid="notnull" data-alert="email"/>
						</td>
					</tr>
					<tr>
						<th scope="row" class="fs18 black br1"><span class="red2">*</span> 휴대전화번호</th>
						<td colspan="2">
							<select  class="fs16 phone select_wrap" name="phone1" id="phone1">
								<option value="010"<%If array_hp(0) ="010" Then%> selected <% End If %>>010</option>
								<option value="011"<%If array_hp(0) ="011" Then%> selected <% End If %>>011</option>
								<option value="016"<%If array_hp(0) ="016" Then%> selected <% End If %>>016</option>
								<option value="017"<%If array_hp(0) ="017" Then%> selected <% End If %>>017</option>
								<option value="018"<%If array_hp(0) ="018" Then%> selected <% End If %>>018</option>
								<option value="019"<%If array_hp(0) ="019" Then%> selected <% End If %>>019</option>
							</select>
							-	
							<input type="text"  class="basic_input w100" name="phone2" id="phone2" maxlength="4" numberonly="true" data-valid="notnull" data-alert="휴대전화번호" Value="<%=array_hp(1)%>">
							-
							<input type="text"  class="basic_input w100" name="phone3" id="phone3" maxlength="4" numberonly="true" data-valid="notnull" data-alert="휴대전화번호" Value="<%=array_hp(2)%>" >	
						</td>
					</tr>			
					<tr>
						<th scope="row" rowspan="2" class="br1 black">광고성 수신 동의 여부</th>
						<th scope="row" class="black">문자 수신여부</th>
						<td>					
							<input type="checkbox" name="mb_sms_yn" value="yy" class="smschk">
							<label for="">전체수신</label>
							<span class="bracket">(</span>
							<input type="checkbox" name="mb_sms_golf" value="y" class="smschk" <% If mb_sms_golf="y" Then%> checked <%End If%>>
							<label for="">골프장</label>
							&nbsp;&nbsp;
							<input type="checkbox" name="mb_sms_resort" value="y" class="smschk"<% If mb_sms_resort="y" Then%> checked <%End If%>>
							<label for="" class="last">스키장</label>
							<span class="bracket">)</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="mb_sms_yn" value="nn" class="smschk">
							<label for="">수신 안함</label>

						</td>
					</tr>
					<tr>
						<th scope="row" class="black">이메일 수신여부</th>
						<td>
							<input type="checkbox" name="mb_email_yn" value="yy" class="emailchk">
							<label for="">전체수신</label>
							<span class="bracket">(</span>
							<input type="checkbox" name="mb_email_golf" value="y" class="emailchk" <% If mb_email_golf="y" Then%> checked <%End If%>>
							<label for="">골프장</label>
							&nbsp;&nbsp;
							<input type="checkbox" name="mb_email_resort" value="y" class="emailchk"<% If mb_email_resort="y" Then%> checked <%End If%>>
							<label for="" class="last">스키장</label>
							<span class="bracket">)</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="mb_email_yn" value="nn" class="emailchk">
							<label for="">수신 안함</label>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="txt_center pt20">
				<button type="button" class="brown_btn fs16 fw500 white sech_btn rel"  onClick="memSave()">확인</button>
			</div>
		

		<div class="notice_area bg_gray mt43 pt42 pb42 txt_center">
			<div class="fs22 fw500">회원탈퇴</div>
			<div class="fs16 fw200 pt10">회원탈퇴를 신청하시면 바로 탈퇴가 처리됩니다. 또한, 한번 삭제한 아이디는 다시 복구할 수 없습니다.</div>
			<button type="button" class="gray_btn fs16 fw500 white sech_btn rel mt25" onClick="withdrew()">회원탈퇴</button>
		</div>


		</div>
	</div>

	
	
	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
<script type="text/javascript" src="/w2/asset/js/member_idpw.js"></script>
<script>
$(document).ready(function(){
	$(document).on("click",".smschk,.emailchk", function(){
		if ($(this).is(':checked')) {			
			if($(this).val() =="yy") {	
				$(this).siblings(':checkbox').eq(0).prop('checked',true);			
				$(this).siblings(':checkbox').eq(1).prop('checked',true);			
				$(this).siblings(':checkbox').eq(2).prop('checked',false);	
					
			} else if($(this).val() =="nn") {	
				$(this).siblings(':checkbox').not(2).prop('checked',false);			
			} else {
				$(this).siblings(':checkbox').eq(2).prop('checked',false);			

			}
		}
	});


	$("select#chgEmail").change(function(){
		$("input#email_2").val($("select#chgEmail>option:selected").val());
	});
});
function withdrew() {
	var form = document.getElementById("frm");
	if(confirm("회원 탈퇴하시겠습니까?")) {
		$.ajax({
			url : "/proc/withdrew_proc.asp",
			data : {"id" : "<%=mb_id%>"},
			dataType : "text",
			success : function(result) {
				var rst = result.trim();
				if(rst =="success") {
					location.href="member_end.asp";
				} else {
					alert(rst);
				}
			}
		});

	}
}
function memSave(){
	var form = document.getElementById("frm");
	$("#phone").val($("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val());
	$("#email").val($("#email_1").val() + "@" + $("#email_2").val());


	if(!web.isEmail($("#email").val())) {
		alert('이메일주소를 확인해주세요.');
		return;
	}

	if (web.formValidation(form, true)) {	

		if($('.smschk:checked').length < 1){
			alert('문자 수신여부를 선택해주세요.');
			return;
		}

		if($('.emailchk:checked').length < 1){
			alert('이메일 수신여부를 선택해주세요.');
			return;
		}
		form.action = "/proc/member_info_proc.asp"
		form.submit();
	}
}
</script>
</html>