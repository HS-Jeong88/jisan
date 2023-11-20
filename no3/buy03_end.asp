<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자

	Dim A_READ(10)

	memcode									=	Trim(request("memcode"))		
	s_account_order					=	Trim(request("s_account_order"))		

	If NullChk(memcode) And NullChk(s_account_order) Then
		Call ScriptAlert("정상적인 접근이 아닙니다.")
		Call ScriptLocation("buy.asp")
		Response.end
	End If
	
	Call SetDB(conn, rs)


	If NullChk(s_account_order) = False Then
		sql = "Select count(*) cnt From tb_ticket_buy Where s_account_order = '" & s_account_order & " '"
		Call QueryOne(sql, cnt)

		If cnt = 1 Then
			sqlWhere =  " Where s_account_order = '" & s_account_order & " '"
		ElseIf cnt > 1 Then
			sqlWhere =  " Where s_account_order = '" & s_account_order & " ' and s_group_position = 'Y' "
		Else
			sqlWhere =  " Where 1 = 2 "
		End If
		
		sql = "Select memcode From tb_ticket_buy " & sqlWhere
		Call QueryOne(sql, memcode)
	End If

	If NullChk(memcode)  Then
		Call ScriptAlert("정상적인 접근이 아닙니다..")
		Call ScriptLocation("buy.asp")
		Response.end
	End If

	sql = "Select name, s_account_order, memtype, buytype, s_memage, s_usetime, s_account_method, s_account_check, s_sumprice From tb_ticket_buy Where memcode = '" & memcode & " '"
	Call QueryArray( Sql, A_READ, 9)

	name							=	 conDBToString( A_READ(1), "")
	s_account_order		=	 conDBToString( A_READ(2), "")
	memtype						=	 conDBToString( A_READ(3), "")
	buytype						=	 conDBToString( A_READ(4), "")
	s_memage					=	 conDBToString( A_READ(5), "")
	s_usetime					=	 conDBToString( A_READ(6), "")
	s_account_method	=	 conDBToString( A_READ(7), "")
	s_account_check		=	 conDBToString( A_READ(8), "")
	s_sumprice				=	 conDBToString( A_READ(9), "")

	Call SetDBNot(conn, rs)
	
	If NullChk(name) Then 
		Call ScriptAlert("정상적인 접근이 아닙니다.")
		Call ScriptLocation("buy.asp")
		Response.end
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

	<div class="sub ticket buy03">
		<!-- #include virtual="/w2/reservation/ticket/ticket_top.asp"-->
		<div class="arrow_tap_wrap">
			<a href="javascript:void(0);" class="tit rel">시즌권 구매</a>
			<ul>
				<li><a href="info.asp">시즌권 안내</a></li>
				<li><a href="photo.asp">사진등록 및 수정</a></li>
				<li><a href="refund.asp">시즌권 환불 & 각종 신청서</a></li>
			</ul>
		</div>
		<div class="tab_bg">
			<ul class="tab_wrap w4">
				<li><a href="info.asp"><span>시즌권 안내</span></a></li>
				<li><a href="javascript: void(0)" class="on"><span>시즌권 구매</span></a></li>
				<li><a href="photo.asp"><span>사진 등록 및 수정</span></a></li>
				<li><a href="refund.asp"><span>시즌권 환불 &amp;<i class="mt_block"></i> 각종 신청서</span></a></li>
			</ul>
		</div>
		<div class="inner pt100 pb190">
			<div class="txt_center pb55">
				<ul class="step_wrap fs16">
					<li class="step01">구매하기</li>
					<li class="step02">결제선택</li>
					<li class="on step03">신청완료</li>
				</ul>
			</div>
			<% If s_account_method = "3" Then %>	
			<div class="cont01 bdt_gray txt_center">
				<p class="fs28 fw500 black2 pt50">이용해주셔서 감사합니다.</p>
				<p class="fs18 fw300 stit pt13">
					<strong>[<%=name%>]</strong>님의 지산리조트 20<%=seasonYear%> 시즌 <i class="m_block"></i><strong>리프트패스- <%=fn_useTimeName(s_usetime)%></strong>시즌권 신청이 완료되었습니다.<br>
					주문번호는 <strong>(<%=s_account_order%>)</strong> 입니다. <i class="m_block"></i><strong>[<%=FormatNumber(s_sumprice,0)%>]원을 아래 계좌로 입금해주세요.</strong>
				</p>
				<table class="basic_table mb24 mt65">
					<caption>요금 및 결제 정보</caption>
					<colgroup>
						<col style="width:33.333%">
						<col style="width:33.333%">
						<col style="width:33.333%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col" class="bg_gray br1">예금주</th>
							<th scope="col" class="bg_gray br1">은행명</th>
							<th scope="col" class="bg_gray">계좌번호</th>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td class="br1">지산리조트(주)</td>
							<td class="br1">농협</td>
							<td>233060-51-030280</td>
						</tr>
					</tbody>
				</table>
		

				<ul class="fs16 fw300 lh16 txt_left gray">
					<li class="dot brown">무통장입금은 1차 구매자는 10월 15일, 2차 구매자는 10월 29일, 3차 구매자는 11월 19일까지 입금한 분에 한하여 가능합니다. (*지동연은 별도 마감일까지)<br>(입금일 경과 시 차수별 마감일 익일에 자동 삭제되며 해당요금을 적용 받으실 수 없습니다.</li>
					<li class="dot">당사 지정계좌로 구매자 명의 외 타인 명의로 입금시 반드시 입금 후 입금 확인을 하여 주시기 바랍니다.</li>
					<li class="dot">- 입금시 예시 : 홍길동 20010101 (성명+생년월일(앞자리)) </li>
					<li class="dot"> 입금문의 : 지산리조트 시즌권 부서 (031) 644-1374~6</li>
				</ul>
			</div>
			<% Else %>	
			<div class="cont01 bdt_gray txt_center">
				<p class="fs28 fw500 black2 pt50">이용해주셔서 감사합니다.</p>
				<p class="fs18 fw300 stit pt13">
					<strong>[<%=name%>]</strong>님의 지산리조트 20<%=seasonYear%> 시즌 <i class="m_block"></i><strong>리프트패스- <%=fn_useTimeName(s_usetime)%></strong>시즌권 구입및 결제가 완료되었습니다.<br>
					주문번호는 <strong>(<%=s_account_order%>)</strong> 입니다.
				</p>
			</div>
			<% End If %>
			<div class="txt_center mt40">
				<button type="button" class="brown_btn fs18 fw600 white" onclick="location.href='buy.asp'; ">확인</button>
			</div>
		</div>
	</div>	

	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body> 
</html>