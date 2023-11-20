<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자
	agree1				=	request("agree1")					
	agree2				=	request("agree2")				
	name					=	Trim(request("name"))			
	birth					=	Trim(request("birth")	)		
	sex						=	Trim(request("sex"))			
	hp1						=	Trim(request("hp1"))			
	hp2						=	Trim(request("hp2"))				
	hp3						=	Trim(request("hp3"))			
	email					=	Trim(request("email"))	

	memcode				=	Trim(request("memcode"))		

	if InStr(memcode, name) < 1 Then
		Call ScriptAlert("정보를 다시 입력해주세요.")
		Call ScriptLocation("photo.asp")
		Response.end
	End If

	'//값체크
	If NullChk(memcode) Then
		Call ScriptAlert("정상적인 접근이 아닙니다.")
		Call ScriptLocation("photo.asp")
		Response.end
	End If

	Call SetDB(conn, rs)

	sql = " Select seq, imageFile, fileok, s_account_check, memtype from tb_ticket_buy where memcode='" & memcode & "' "
	Call QueryFive(sql, seq, imagefile, fileok, s_account_check, memtype)

	
	
	

	Call SetDBNot(conn, rs)

	If NullChk(seq) Then
		Call ScriptAlert("구매내역이 조회되지 않습니다.")
		Call ScriptLocation("photo.asp")
		Response.end
	End If

	If memtype = "0" Then
		Call ScriptAlert("회원 구입자는 사진이 불필요합니다.")
		Call ScriptLocation("photo.asp")
		Response.end
	End If

	'//마감
	'Call ScriptAlert("온라인판매가 마감되어 사진수정이 불가합니다.")
	'Call ScriptLocation("photo.asp")
	'Response.End

	'//미입금상태이면 
	'If s_account_check <> "0000" Then
	'	Call ScriptAlert("입금처리후 수정가능합니다.")
	'	Call ScriptLocation("photo.asp")
	'	Response.end
	'End If

	If NullChk(imageFile) Then 
		imageFile = "/w2/asset/images/sub/reservation/photo_sample.jpg"
	Else
		imageFile = "/downloads/ticket/upload/original/" & imageFile
	End If
		

	If NullChk(fileok) Then fileok = "N"


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

	<div class="sub ticket buy01 photo_notice">
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
			<p class="sub_tit pb36">사진첨부 시 주의사항</p>
			<div class="cont03">
			<form name="insertF" id="insertF" method="post">
			<input type="hidden" name="memcode" value="<%=memcode%>">
				<div class="clearfix">
					<div class="profile tbpc_f_left">
						<div class="box" style="padding-top:0px">
							<img src="<%=imageFile%>" alt="" class="imgDummy">
						
						</div>
						<div class="file">
							<input type="hidden" class="box015" id="imagefile" name="imagefile" title="파일첨부"  data-valid="notnull" data-alert="파일첨부">
							<% If fileok = "Y" Then %>
							<span class="file_add fs16 fw600" onclick="javascript:alert('사진이 확정되어 수정이 불가합니다.');">찾아보기</span>	
							<% Else %>
							<span class="file_add fs16 fw600" onclick="fileupwindow('')">찾아보기</span>	
							<% End If %>
						</div>
					</div>
					<ul class="notice tbpc_f_left bdt_brown bdb_gray fw300 fs17 gray2 lh17_ver2">
						<li class="dot">이목구비가 뚜렷한 반명함판 사진(5*7cm,컬러)</li>
						<li class="dot">파일용량은 100KB이상 2MB이하의 JPG확장자 파일</li>
						<li class="dot">어깨 선에서 위 얼굴이 전체적으로 보이는 정면사진(늘림, 줄임 사진 불가)</li>
						<li class="dot">고글,선글라스, 모자, 마스크 등을 착용하신 사진은 본인 확인이 어렵습니다.</li>
						<li class="dot star brown mb24">다른 사람의 사진이거나 본인 확인을 할 수 없는 경우 시즌권 발급이 지연되거나 발급 받으실 수 없습니다.</li>
						<li class="dot">휴대전화가 변경되지 않은 22/23시즌권 구입자는 사진등록이 필요하지 않습니다. (전년구입자)</li>
						<li class="dot">첨부하신 이미지는 시즌권에 들어갈 이미지 입니다.</li>
						<li class="dot mb24">규정이외의 사진을 업로드시에는 발급이 지연될 수 있습니다.</li>
						<li class="dot brown">사진등록/수정은 1차/2차/3차 판매 후 5일 이내까지 수정 가능하며, 기간 초과시 수정이 불가합니다.</li>
						<li class="dot empty brown">- 1차 : 10월 04일 오전 10시 ~ 10월 16일</li>
						<li class="dot empty brown">- 2차 : 10월 17일 ~ 10월 30일</li>
						<li class="dot empty brown">- 3차 : 10월 31일 ~ 개장 전까지</li>
					</ul>
				</div>
			</form>
			</div>
			<div class="txt_center mt40">
				<button type="button" class="brown_btn fs18 fw600 white" onclick="save();">완료</button>
			</div>
		</div>
	</div>	

	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body> 
<script>
	function fileupwindow(no) {
		var memcode = "<%=memcode%>";
		window.open("http://www1.jisanresort.co.kr/w2/reservation/ticket/pop/file_upload1.html?no=" + no+"&memcode="+escape(memcode), "file_up_window","width=650, height=600, left=50, top50, scrollbars=0, toolbar=0, menubar=0");
	}
	function imgUploadRtn(f,i,n){
		console.log(f);
		console.log(i);
		console.log(n);
		var result = Math.floor(Math.random() * 100) + 1;
		$(".imgDummy"+n).attr("src",i+"?r="+result);
		$("#imagefile"+n).val(f);
	}
	var form = document.getElementById("insertF");
	function save() {		
	<% If fileok = "Y" Then  %>		
		location.href="photo.asp";
	<% Else %>
		if (form.imagefile.value ==""){		
			alert("[찾아보기]로 업로드하실 사진을 선택해주세요.");
		} else {
			$.ajax({
				url : "photo_end.asp",
				dataType : "text",
				method: "POST",
				data : $("#insertF").serialize(),
				success : function(result) {
					if(result=="success"){
						alert("회원님의 사진이 수정되었습니다.")
					}else{
						alert(result);
					}
				}
			});		
		}
	<% End If %>
	}
</script>
</html>