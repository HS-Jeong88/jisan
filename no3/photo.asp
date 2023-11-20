<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	

	Call SetDB(conn, rs)
	sns_id = Session("sns_id")

	'//로그인 회원정보 가져오기Dim id
		If IsEmpty(js_id) Then
			spec(2)
			id = sns_id
			Sql =	" Select mb_name, mb_hp From	jssnsmember " &_
				" Where	mb_id = '" & id & "' " 
			Call QueryArray(sql, spec, 2)
		Else
			spec(6)
			id = js_id
			Sql =	" Select mb_name, mb_resno1, vSex, mb_hp, mb_email, mb_resno1 From jsmember " &_
				" Where	mb_id = '" & id & "' " 
			Call QueryArray(sql, spec, 6)
		End If
	
	Call SetDBNot(conn,rs)
	
	If IsEmpty(sns_id) Then
		name		= spec(1)
		sex		= spec(3)
		hp			= spec(4)
		email	= spec(5)
		birth	= spec(6)

		If Len(birth) = 6 Then		
			If Left(birth, 2) <= Left(GetNow(),2) Then
				birth = "20"&birth
			Else
				birth = "19"&birth
			End If
		End If

		If Len(birth) <> 8 Then birth = ""
		If sex = "M" Then
			sex = "1"
		ElseIf sex = "F" Then
			sex = "2"
		End If

	Else
		name		= spec(1)
		hp			= spec(2)
	End If

	If NullChk(hp) Then hp = "--"
	
	arr_hp		= split(hp, "-")

	If IsEmpty(sns_id) Then
		If Len(birth) = 8 And Len(sex) ="1" And Len(arr_hp(2)) ="4" And NullChk(name) = False Then
			memcode=birth & "-" & sex & "-" & arr_hp(2) & "-" & name
		Else
			Call ScriptAlert("개인정보에 필수데이타가 없습니니다.\n정보수정에서 가입정보를 확인해주세요.")
			Call ScriptLocation(agentChkLink & "/member/mypage/member_pwc.asp")	
			Response.end	
		End If
	Else
		If Len(arr_hp(2)) ="4" And NullChk(name) = False Then
			memcode=arr_hp(2) & "-" & name
		Else
			Call ScriptAlert("개인정보에 필수데이타가 없습니니다.\n정보수정에서 가입정보를 확인해주세요.")
			Call ScriptLocation(agentChkLink & "/member/mypage/member_pwc.asp")	
			Response.end	
		End If
	End If

%>
<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head_reaction.asp"-->
</head>
<body data-target="gnb03" data-number="subGnb07" data-value="m_gnb03">
	<!-- header -->
	<header class="sub header rel ski_h">
		<!-- #include virtual="/w2/asset/inc/header_reaction_common.asp"-->
		<div class="pc_only">
			<!-- #include virtual="/w2/asset/inc/header_ski.asp"-->
		</div>
	</header>
	<!-- //header -->

	<div class="sub ticket photo">
		<!-- #include virtual="/w2/reservation/ticket/ticket_top.asp"-->
		<div class="arrow_tap_wrap">
			<a href="javascript:void(0);" class="tit rel">사진등록 및 수정</a>
			<ul>
				<li><a href="info.asp">시즌권 안내</a></li>
				<li><a href="buy.asp">시즌권 구매</a></li>
				<li><a href="refund.asp">시즌권 환불 & 각종 신청서</a></li>
			</ul>
		</div>
		<div class="tab_bg">
			<ul class="tab_wrap w4">
				<li><a href="info.asp"><span>시즌권 안내</span></a></li>
				<li><a href="buy.asp"><span>시즌권 구매</span></a></li>
				<li><a href="javascript: void(0)" class="on"><span>사진 등록 및 수정</span></a></li>
				<li><a href="refund.asp"><span>시즌권 환불 &amp;<i class="mt_block"></i> 각종 신청서</span></a></li>
			</ul>
		</div>
		<div class="inner pt100 pb190">
			<p class="sub_tit pb36">본인확인</p>
			<div>* 구매자정보 입력후 확인해주세요.</div>
			<table class="basic_table ">
			<form name="insertF" id="insertF" method="post">
				<caption>이용시간</caption>
				<colgroup>
					<col style="width:13.4%">
					<col style="width:auto">
					<col style="width:49.9%" class="w35">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"  class="br1">이름</th>
						<td colspan="2"><input type="text"  id="name" name="name"   class="basic_input" value="<%=name%>"  data-valid="notnull" data-alert="이름" ></td>
					</tr>
					<tr>
						<th scope="row"  class="br1">생년월일</th>
						<td class="br1 birth rel">
							<div class="rel birth_box"><input type="text" class="cal" id="birth" name="birth"  value="<%=birth%>" data-valid="notnull" data-alert="생년월일" readonly></div>
						</td>
						<td class="fs16 fw200">(주민등록상 생일)</td>
					</tr>
					<tr>
						<th scope="row" class="br1">성별</th>
						<td colspan="2">
							<select name="sex" id="sex"  class="select_wrap">
								<option value="1" <% If sex = "1" Then %> selected <% End If %>>남</option> 
								<option value="2" <% If sex = "2" Then %> selected <% End If %>>여</option> 
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" class="br1">연락처</th>
						<td class="br1 hp_warp">
							<%=fn_SelectHp("hp1",arr_hp(1))%> -  
							<input type="text" name="hp2" id="hp2" class="hp2" value="<%=arr_hp(1)%>" numberonly="true" maxlength="4" data-valid="notnull" data-alert="휴대전화번호"> - 
							<input type="text" name="hp3" id="hp3" class="hp2" value="<%=arr_hp(2)%>" numberonly="true" maxlength="4" data-valid="notnull" data-alert="휴대전화번호">
						</td>
						<td class="fs16">(구입시 입력한 휴대번호)</td>
					</tr>
					<tr>
						<th scope="row" class="br1">회원번호</th>
						<td colspan="2"><input type="text" id="memcode" name="memcode" class="basic_input" value="<%=memcode%>"  data-valid="notnull" data-alert="회원번호"></td>
					</tr>
				</tbody>
			</form>
			</table>
			<div class="txt_center mt40">
				<button type="button" class="brown_btn fs18 fw600 white" onclick="save();">확인</button>
			</div>
		</div>
	</div>	

<link href="/w2/asset/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/w2/asset/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/w2/asset/js/jquery_ui_cal.js?v=1"></script>
<script>
var form = document.getElementById("insertF");
function save() {	
//	alert("온라인 사진등록기간이 종료되었습니다.\n현장제출 바랍니다.");
//	return;
	if (web.formValidation(form)){		
		form.action = "photo_notice.asp";
		form.submit();
	}
}
function memcodeMake() {	
	if ($("#name").val() && $("#birth").val() && $("#sex option:selected" ).val() && $("#hp3").val().length >=4 )	{
		form.memcode.value = String($("#birth").val()) + "-" + $("#sex").val() + "-" +$("#hp3").val() + "-" + String($("#name").val());
	} else {		
		form.memcode.value = "";
	}
}

$(document).ready(function() {
	// 달력 설정
	$( ".cal" ).datepicker({
		  showOn: "button",
		  buttonImage: "/w2/asset/images/sub/reservation/cal_btn_white.png",
		  buttonImageOnly: true,
		  buttonText: "Select date",
		  dateFormat: "yymmdd"
	});	
	
	$("#name, #hp3").on("keyup", function() { memcodeMake(); });	
	$("#sex").change(function() { memcodeMake(); });	
	$("#birth").on("change", function() {	memcodeMake();});	
});

</script>
	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
</html>