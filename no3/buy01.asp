<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
'	If  js_id<>"khs532" Then
'		Call ScriptAlert("온라인 판매기간이 아닙니다.")
'		Call ScriptLocation("/w2/reservation/ticket/info.asp")
'		Response.End
'	End If	


		
	Dim spec(6)


	If period = "false" And g_period = "false" Then
		Call ScriptAlert("온라인 판매기간이 아닙니다.\n(23년 10월4일 10시부터 ~ 11월 19일까지 )")
		Call ScriptLocation("/w2/reservation/ticket/info.asp")
		Response.end
	End If

	Call SetDB(conn, rs)

	'//로그인 회원정보 가져오기
	Sql =	" Select	mb_name, mb_resno1, vSex, mb_hp,  mb_email, mb_resno1 From	jsmember  " &_
				" Where	mb_id = '" & js_id & "' " 
	Call QueryArray(sql, spec, 6)

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


	If NullChk(hp) Then hp = "--"
	
	arr_hp		= split(hp, "-")

	If Len(birth) = 8 And Len(sex) ="1" And Len(arr_hp(2)) ="4" And NullChk(name) = False Then
		memcode=birth & "-" & sex & "-" & arr_hp(2) & "-" & name
	Else
		Call ScriptAlert("개인정보에 필수데이타가 없습니니다.\n정보수정에서 가입정보를 확인해주세요.")
		Call ScriptLocation(agentChkLink & "/member/mypage/member_pwc.asp")	
		Response.end	
	End If


	sql = " select memcode, buytype, s_account_method, s_account_check from tb_ticket_buy Where seasonYear='" & seasonYear & "' and memcode = '" & memcode & "' "	
	Call QueryFour(sql, preMemcode, preBuytype, preS_account_method, preS_account_check)


	'//회원코드로 멤머타입, 년차 가져오기((1):memtype, (2):yearcha)
	a_ticketMem = fn_memtypeChk(memcode)	
	memtype = a_ticketMem(1)	'//회원타입	 0 회원, 1 일반, 2, 정동호회원, 3준동, 4 100인이상(사용안함), 8 모글
	yearcha = a_ticketMem(2)	'//년차
	memage  = a_ticketMem(3)	'//1:대인, 2:청소년, 3,소인

	'If memcode="20010721-1-6810-박창민" Then memage = "1"

	'//기간체크(동호회원 일반회원은 기간이 틀림)
'	If memtype="2" Or memtype="3" Then
'		If g_period = "false" Then
'			Call ScriptAlert("동호회시즌권 판매가 종료되었습니다.")
'			Call ScriptLocation("../info/info.asp")
'			Response.end
'		End If
'	End If

	members = "1"

	

	
	'//구매가능 권종및 비용가져오기
	'a_ticUsetime = fn_memTimeOption(memtype, yearcha, members, memage, "personal", "", "", memcode)	


	'sql = "insert into tb_ticket_firstlog(jisan_id, memcode, memtype, yearcha, memage, fn_option, reg_ip) " &_
	'			"	values('"& js_id &"','"& memcode &"','"& memtype &"','"& yearcha &"','"& memage &"','"& conStringtoDB(a_ticUsetime) &"','"& selfip() &"') "
	'Conn.Execute( sql )


	Call SetDBNot(conn,rs)
%>
<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head_reaction.asp"-->
	<style>
	.btn_half{border: 1px solid #d6d6d6;background: #e6e6e6;line-height: 28px;color: #000000;text-align: center;cursor: pointer;padding: 7px;display:none;}
	.couple_wrap{display:none;}
	.loading{width: 100%;height: 100%;background-color: #000;opacity: 0.2;position: absolute;left: 0;top: 0;z-index:999;display:none;}
	.loading img{position:fixed;left:50%;top:50%;;}
	</style>
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

	<div class="sub ticket buy01">
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
		<form name="insertF" id="insertF" method="post">
			<input type="hidden" name="buytype" id="buytype" value="personal">
			<input type="hidden" name="userCnt" id="userCnt" value="1">
			<input type="hidden" name="s_group_level" id="s_group_level">
			<input type="hidden" name="halfPrice" id="halfPrice">
			<input type="hidden" name="groupChk" id="groupChk">
			<div class="txt_center">
				<ul class="step_wrap fs16">
					<li class="on step01">구매하기</li>
					<li class="step02">결제하기</li>
					<li class="step03">결제완료</li>
				</ul>
			</div>
			<div class="cont01 clearfix">
				<div class="box_wrap  first">
					<p class="sub_tit mb24 pt90">시즌권종선택</p>
					<div class="box box01">
						<ul class="ticket clearfix" id="ticketPlus">
							<li alt='personal'class="f_child"><img src="/w2/asset/images/sub/reservation/ticket02_02_radio.png" alt="" /><span class="check"></span><span class="txt">개인권</span></li>
							<li alt='family' class="l_child"><img src="/w2/asset/images/sub/reservation/ticket02_02_radio.png" alt="" /><span class="check"></span><span class="txt">가족권</span></li>
						</ul>
						<ul class="fs17 fw300 black lh17">
							<li class="dot star">23/24 Season 시즌권 신규 구매자 연차 미적용</li>
							<li class="dot star">기존 연차구매자에 한해 연차적용 가능</li>
							<li class="dot star" id="familyMsgli" style="display:none">가족권 구매자는 필히 가족관계 증명서 지참</li>
							
						</ul>
					</div>
				</div>
			</div>
			
			<p class="sub_tit pb36 pt90">사용자정보</p>
			<div class="cont02">
				<div class="top_wrap clearfix bdt_brown">
					<div class="f_left"><img src="/w2/asset/images/sub/reservation/ticket02_02_ico02.png" alt=""></div>
					<div class="f_right dt">
						<p class="tc fs18 black lh18">	시즌권을 이용하실 당사자의 정보를 입력해주세요.<br> 본인이용 시 본인정보를, 타인의 시즌권을 대리구입시에는 시즌권을 이용하실 타인의 정보를 입력해 주세요.</p>
					</div>
				</div>	
				<div class="bottom_wrap clearfix bdb_gray bdt_gray">
					<p class="fs16 fw500 gray4 f_left">※ 공지</p>
					<ul class="fs16 fw300 gray4 lh16 f_right">
						<li class="dot">입력하신 정보들의 일부를 조합하여 개인식별정보로 사용합니다. <br>
						입력오류 또는 허위입력시 본인식별이 불가능하여 회원권혜택 미적용 또는 연차 미적용 등의 불편함이 있을 수 있사오니, 입력에 유의바랍니다.</li>
						<li class="dot mt10">이미 입력하신 정보를 변경하기를 원하시는 분은 변경전 정보와 변경후 정보를 시즌권담당자에게 알려주시기 바랍니다.<br>
						(전화031-644-1374~6, 이메일6441374@jisanresort.co.kr, 홈페이지에서의 직접 변경방법은 차후 제공 예정)</li>
					</ul>
				</div>	
			</div>
			<div class="infoWrap" id="1">
				<p class="sub_stit pb36 pt60">사용자1</p>
				<div class="cont03">
					<div class="clearfix">
						<div class="profile tbpc_f_left">
							<div class="box" style="padding-top:0px">
								<img src="/w2/asset/images/sub/reservation/photo_sample.jpg" alt="업로드이미지" class="imgDummy1">
							</div>
							<div class="file">
								<input type="hidden" class="box015" id="imagefile1" name="imagefile1" title="파일첨부">
								<span class="file_add fs16 fw600" onclick="fileupwindow(1);">찾아보기</span>						
							</div>
						</div>
						<table class="basic_table tbpc_f_left">
							<input type="hidden" name="memtype1" id="memtype1" value="<%=memtype%>">
							<input type="hidden" name="yearcha1" id="yearcha1" value="<%=yearcha%>">
							<input type="hidden" name="memage1" id="memage1" value="<%=memage%>">
							<colgroup>
								<col style="width:27%">
								<col style="width:auto">
							</colgroup>
							<caption>개인권 사용자정보</caption>
								<tbody>
								<tr>
									<th scope="row">사용자명</th>
									<td scope="row">
										<input type="text" name="name1" id="name1" value="<%=name%>" data-valid="notnull" data-alert="이름" data-memcode="true">
									</td>
								</tr>
								<tr>
									<th scope="row">생년월일/성별</th>
									<td scope="row" class="birth">	
										<input type="text" id="birth1" name="birth1" class="birth birth1" value="<%=birth%>" data-valid="notnull" data-alert="생년월일" readonly  data-memcode='true'>
										<p class="gender">
											<input type="radio" name="sex1" id="sex1" value="1" <% If sex = "1" Then %> checked  <% End If %> data-memcode='true'><label for="sex1">남</label>
											<input type="radio" name="sex1" id="sex1" value="2" <% If sex = "2" Then %> checked  <% End If %> data-memcode='true'><label for="sex2">여</label>
											<span class="couple_wrap">&nbsp;&nbsp;<input type="checkbox" name="group_couple1" id="group_couple1" class='group_couple' value="Y"/>커플</span>
										</p>
									</td>
								</tr>
								<tr>
									<th scope="row">휴대전화 번호</th>
									<td scope="row">
										<%=fn_SelectHp("hp11",arr_hp(0))%> - 
										<input type="text" name="hp21" id="hp21" class="hp2" value="<%=arr_hp(1)%>" numberonly="true" maxlength="4" data-valid="notnull" data-alert="휴대전화번호"> - 
										<input type="text" name="hp31" id="hp31" class="hp2" value="<%=arr_hp(2)%>" numberonly="true" maxlength="4" data-valid="notnull" data-alert="휴대전화번호" data-memcode='true'>
									</td>
								</tr>
								
								<tr>
									<th scope="row">이메일</th>
									<td scope="row" class="emali">
									<input type="text" title="이메일" name="email1" id="email1" data-valid="notnull" data-alert="이메일" class="member_num" value="<%=email%>" data-valid="email" data-alert="이메일">						
								</td>
								</tr>
								<tr>
									<th scope="row">회원번호</th>
									<td scope="row">
										<input type="text" name="memcode1" id="memcode1" class="member_num" value="<%=memcode%>" data-valid="notnull" data-alert="회원번호" readonly>								
									</td>
								</tr>
								<tr>
									<th scope="row">권종</th>
									<td scope="row" class="ticket">
										<select id="selgubun1" name="selgubun1" class="select_wrap">
											<%=a_ticUsetime%>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="addUser"></div>
			<div class="txt_center mt20">
				<p class="add_del inner pd10">
					<a href="javascript:void(0)" class="add add_user" style="font-weight:bold">[인원추가]</a>
					<a href="javascript:void(0)" class="del del_user" style="font-weight:bold"  >[인원삭제]</a>
				</p>
			</div>
					
			<style>
				.info_wrap{overflow:hidden;}
				.agree_info{width:30%; height:150px; border:1px solid #333; float:left; border-right:none; margin-bottom:20px; text-align:center;}
				.agree_info p{padding:10px;}
				.agree_info p:first-child{border-bottom:1px solid #333;}	
				.agree_info:last-child{border-right:1px solid #333;}
			</style>
			<p class="sub_tit pb36 pt90">약관동의</p>
			<div class="cont04">
				<div class="agree_wrap">
					<p class="fs20 fw300"><strong><input type="checkbox" id="agreeall" name="agreeall" value="Y" onclick="agreeAll()"><label for="agreeall">전체동의</label></strong></p>
				</div>
				<div class="agree_wrap mt53">
					<div class="tit rel">
						<p class="fs20 fw300">[필수] 23/24 시즌권 이용에 대한 약관</p>
						<a href="javascript:void(0)" class="more_btn fs16 fw300 white">전문보기</a>
					</div>
					<div class="more fs14">
						<strong> 23/24시즌 리프트 시즌권 약관</strong><br><br>
						
						<h3>제1조(목적)</h3><br>
						<p class="fs14">이 약관은 지산리조트㈜(이하 '사업자'로 합니다)가 판매하는 2023/2024시즌 리프트 시즌권을 구입하여 이용하는자(이하 '이용자'라 합니다)의 권리 와 의무 및 이용절차 등 기타 필요 사항의 규정을 정함을 목적으로 합니다.</p><br><br>
						

						<h3>제2조 (정의)</h3><br>
						<p><span class="marginbt10">가.</span> 시즌권은 회원권이 아니며 스키 및 스노우보드 애호가를 위하여 대폭 할인된 가격으로 제공되는 리프트에 국한된 특별 할인상품입니다.<br><span class="color_bl">나. 본 시즌권으로 눈썰매장 이용은 불가 합니다.</span><br>다. 시즌권은 기명식 이용권입니다.</p><br><br>
						
						
						<h3>제3조 (사용기간 및 적용)</h3><br>
						<ol>
							<li class="color_bl"><span class="marginbt70">가.</span> 시즌권의 사용기간은 하기(①,②)와 같이 구분되며 서비스 기간은 이용자에게 무상으로 제공되는 기간입니다 </li>
							<li class="color_bl"><span class="marginbt10">① 기본사용기간 -</span> 전일권 : 개장일로부터 60일</li>
							<li class="color_bl"><span class="marginbt10">② 서비스기간 -</span> 전일권 : 60일 이후 ~ 폐장일</li>
						</ol>
						<!-- <p><span class="marginbt40">나. </span> 이용자의 시즌 기간 중 이용횟수에는 제한이 없으나 천재지변, 기상여건(강풍 등으로 인한 안전문제 발생), 리프트 정비,보강제설, 국내외 스키 관련 대회로 인한 슬로프 제한 등 사업자의 사정상 불가피한 사유로 일부 또는 모든 리프트의 운행 제한 및 변경 될 수 있으며, 리프트 검표 시 적극 협조 바랍니다.</p> -->
						<p>나. 권종이용가능 시간</p><br>
						<table width="100%" cellpadding="10" cellspacing="10" summary="권종이용가능시간" class="more_table">
							<caption>권종이용가능시간</caption>
							<colgroup>
								<col width="16.6%">
								<col width="auto%">
							</colgroup>
							<thead>
								<tr>
									<th scope="row">구분</th>
									<th scope="col">전일권</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row"">적용</th>
									<td>시즌중</td>
								</tr>
								<tr>
									<th scope="row" rowspan="2">이용시간</th>
									<td>전체시간대</td>
								</tr>
								<tr>
									 <td colspan="5">단, 기후여건에 따라 심야 운영시기는 변동될 수 있으며  정설시간 제외<br>심야운영시기 : 12월20일 전후 ~ 2월중순경 예정 운영 (기후 여건에따라 변경 가능)<br />주중(일~목) 23:00 ~ 24:00시 정설타임 없이 운영합니다.</td>
								 </tr>
							</tbody>
						</table>
                        <p>※ 회원 시즌권 리프트 탑승 라인 별도 운영(일반 시즌권 입장 불가)	</p><br>
                        <p>다. 2023/2024시즌의 시즌권 유효기간 중, 이용횟수는 제한이 없으나 천재지변, 기상 여건(강풍, 우박 등으로 인한 안전문제 발생),
                            사회재난, 정부의 지침 (전염병, 감염병 등 관련 명령, 집합 금지, 이용제한, 시설 폐쇄 등), 리프트 정비, 보강 제설,
                            이상기온으로 인한 임시휴업, 국내외 스키 관련 대회 등 불가피한 사유로 일부 또는 모든 리프트의 운행이 제한될 수 있습니다. 
                            <!-- 이러한 경우, 그 불가피성을 인정하여  "이용자”는 사업자에 이의를 제기할 수 없습니다. --></p><br>
                            <p>
								<span >라. </span>
								정부 에너지 절감 시책 등으로 이용객을 고려하여 슬로프와 리프트를 탄력적으로 운영하고 있습니다.
								이에 따라 특정 기간 또는 특정 시간에 일부 슬로프의 이용이 제한될 수 있습니다.
								<!-- “이용자”는 해당 사유로 인한 이의를 사업자에 제기할 수 없습니다. <br/>
                                ※ 특히 2월부터는 상시 슬로프와 리프트 운영을 이용 제한 될수 있습니다.-->
							</p>
							<br/><br/>


						<h3>제4조 (이용자의 자격,의무 및 시즌권 관리,발급)</h3><br>
						<ol>
							<li><span class="marginbt10">가.</span> 이용자는 시즌권을 소지하였을 경우에만 이용자의 권리를 행사할 자격이 주어지며 리프트 탑승시 항시 시즌권을 지참하고 있어야 합니다. ( 좌측 상단쪽으로 배치하여 게이트 통과시 인식될수 있도록 협조하여야 합니다. )</li>
							<li><span class="marginbt30">나.</span> 이시즌권은 기명식 이용권으로 당사에 등록된 본인외 제3자의 이용은 불가하며 적발 즉시 압수되고 시즌권 효력이 상실 됩니다.</li>
							<li><span class="marginbt10">다.</span> 시시즌권 이용자는 본인 사진과 일치 여부 확인을 위해 헬멧 또는 고글, 마스크 등의 탈착을 검표요원이 요구할수 있으며, 본인 확인 절차에 불응 시 스키장 이용불가 합니다.</li>
							<li><span class="marginbt10">라.</span> 시즌권 분실, 도난, 파손시 이용자의 부주의로 시즌권을 소지하지 않을경우 스키장 입장이 불가합니다. 당일 스키장 이용을 위해 재발급 할 경우 재발급 수수료가 발생합니다.</li>
							<li><span class="marginbt10">마.</span> 시즌권 미소지시 리프트권은 별도로 구매하여 이용하여야 하며 필히 지참하여야 합니다.</li>
							<li><span class="marginbt30">바.</span> 상품 이용요금을 납부하신 후 이미지파일(jpg)을 규격에 맞추어 1주일 이내에 등재시켜야 합니다.
                                <ol>
									<li><span class="marginbt10">-</span> 이미지 규격 : 어깨이상이며,썬글라스,고글,모자 등을 탈의하여 본인식별이 가능한 이미지. (세로 5cm X 7cm, 200 dpi 이상, 300KB ~ 1MB이하 사진 )</li>
									<li><span class="marginbt10">-</span> 최근 3개월 이내 촬영한 증명 사진을 등록해야 시즌권 발급이 됩니다. ( 눌림사진 및 스티커, 어플, 측면사진 불가 )</li>
									<li><span class="marginbt10"">-</span> 규정 미달 사진 제출 시에는 시즌권 제작 불가 합니다.</li>
								</ol>
							</li>
							<li><span class="marginbt30">사.</span> 유효 기간은 2023년 스키장 개장일로 부터 2024년 폐장일 까지의 기간을 기준으로 하고 기간 경과시 만료처리 됩니다.</li>
							<!-- <li><span class="marginbt10">사.</span> 시즌권 미소지시 리프트권은 별도로 구매하여 이용하여야 하며  필히 지참하여야 합니다.</li>
							<li><span class="marginbt30">아.</span> 시즌권을 발급 받기 위해서는 반드시 사업자 소정의 가입 신청서에 의한 실명 가입에 한하며, 상품 이용요금을 납부한 후 사업자의 시즌권 담당부서를 통한 정상적인 발급 절차에 의해서만 가능합니다 .</li>
							<li><span class="marginbt90">자.</span> 상품 이용요금을 납부하신 후 이미지파일(jpg)을 규격에 맞추어 1주일 이내에 등재시켜야 합니다.
								<ol>
									<li><span class="marginbt10">-</span> 이미지 규격 : 어깨이상이며,썬글라스,고글,모자 등을 탈의하여 본인식별이 가능한 이미지. (세로 5cm X 7cm, 200 dpi 이상, 300KB ~ 1MB이하 사진 )</li>
									<li><span class="marginbt10">-</span> 최근 3개월 이내 촬영한 증명 사진을 등록해야 시즌권 발급이 됩니다. ( 눌림사진 및 스티커, 어플, 측면사진 불가 )</li>
									<li><span class="marginbt10"">-</span> 규정 미달 사진 제출 시 에는 시즌권 제작을 거부 할 수 있습니다.</li>
								</ol>
							</li>
							<li><span class="marginbt10">차.</span> 유효 기간은 2020년 스키장 개장일로 부터 2021년 폐장일 까지의 기간을 기준으로 하고 기간 경과시 만료처리 됩니다.</li>
							<li><span class="marginbt10">카.</span> 소인권(2008/01/01 이후 출생자) , 청소년권(2002/01/01 이후 출생자) ,가족권은 수령시 학생증,주민등록등본 등 확인 서류를 지참 하셔야 합니다.</li>
							<li><span class="marginbt10">타.</span> 본 시즌권은 기명식 유가증권이므로 등록된 본인만 사용이 가능하며 본인의 부주의로 시즌권을 소지하지 않을시 시즌권의 무료 재발급 및 무료 리프트권 또는 할인 요청을 하실 수 없습니다.</li> -->
						</ol><br><br>


						<h3>제5조 (시즌권 부정사용 및 분실신고)</h3><br>
						<ol>
							<li><span class="marginbt10">가.</span> 본 약관을 위반하여 시즌권을 부정한 방법으로 사용하다 적발된 경우 모든 민형사상 책임은 귀책사유가 있는 이용자(구매자) 또는 부정 사용한 자에게 귀속됩니다.</li>
							<li><span class="marginbt30">나.</span> 시즌권을 분실 하거나 도난된 경우 이용자는 반드시 당사 시즌권 담당처에 지체없이 분실 신고를 하여야 하며, 분실 신고 이전에 부정 사용으로 인하여 회수된 시즌권은 회수, 말소(폐기) 처리 됩니다.</li>
							<li><span class="marginbt10">다.</span> 기타 부정하게 사용되다 적발된 시즌권은 회수 및 폐기 처리될 뿐만 아니라 벌과금이 부과 됩니다.  </li>
							<li><span class="marginbt100"> 라.</span> 관련법률
								<ol>
									<li><span class="marginbt10">1)</span> &nbsp;도난및 분실된 시즌권을 이용한 경우 형법 제 329조와 형법 제 360조에 의거 절도죄 및 점유이탈물 횡령죄가 적용되어 사법처리를 받게 됩니다.</li>
									<li><span class="marginbt30">2)</span> &nbsp;발급받은 시즌권의 위,변조 행위를 제공하거나, 위,변조된 시즌권을 부정사용하는 행위는 형법 제 217조에 의거 유가증권 위조등에 저촉되며, 적발된 경우 관할 경찰서로 인계되어, 민.형사상의 사법처리를 받게 됩니다.</li>
									<li><span class="marginbt30">3)</span> &nbsp;고의 또는 과실로 인한 위법 행위나 법률상 원인없이 타인의 재산(시즌권)등으로 이익을 얻고 이로 인하여 타인에게 손해를 가한자는 민법 제741조, 민법 제750조에 의거 손해 배상 책임을 집니다.</li>
								</ol>
							</li>
						</ol><br><br>



						 <h3>제6조 (시즌권 부정사용시 처벌 규정)</h3><br>
						<ol>
							<li><span class="marginbt30">가.</span> 시즌권 구입자가 제 3자에게 당해 시즌권을 약관상 정상적인 양도양수 절차를 거치지 아니하고 임의로 제 3자에게 대여하거나 양도하여 그 제 3자로 하여금 사용하게 하는 행위시
								<ol>
									<li>&nbsp;&nbsp;&nbsp;1)시즌권 폐기</li>
									<li>&nbsp;&nbsp;&nbsp;2)이용자(부정사용자) - 이용한 해당 시즌권종의 정상요금 벌과금 부과</li>
								</ol>
							</li>
							<li>나. 제 3자가 분실, 절취, 횡령, 강취, 사취 등을 통해 습득한 시즌권을 이용한 행위
								<ol>
									<li>&nbsp;&nbsp;&nbsp;1)시즌권 폐기</li>
									<li><span class="marginbt30">&nbsp;&nbsp;&nbsp;2)</span>시즌권 구입자(기명인) - 분실, 도난 신고후 제 3자의 이용행위에  대해서는 책임이 없으나, 신고전에 제 3자가 이용하다가 적발 되었다면 미신고 행위에 대한 책임으로 시즌권 폐기에 대해 이의를 제기할 수 없습니다.</li>
									<li>&nbsp;&nbsp;&nbsp;3)이용자(부정사용자) - 이용한 해당 시즌권종의 정상요금 벌과금 부과, 시즌권 구입자와 합의</li>
								</ol>
							</li>
							<li><span class="marginbt10">다.</span> 시즌권의 재발급 받은후 기존 시즌권 사용시 부정사용으로 적발되면 신/구 시즌권 모두 회수,말소 처리 됩니다.</li>
							<li>라. 시즌권 위, 변조 적발시 관할 경찰서에 고소</li>
							<li>마. 위 처벌 규정에 대해 손해 배상을 인정 하지 못할 경우 관할 경찰서로 인계</li>
						</ol><br><br>


						 <h3>제7조 (시즌권 재발급)</h3><br>
						<ol>
							<li><span class="marginbt10">가.</span> 시즌권의 재발급은 훼손되어 본인 여부를 확인 할 수 없거나 분실 시에만 가능하며 재발급 허용은 2회로 한정하고 그 이외의 경우에는 재발급이 불가합니다.</li>
							<li><span class="marginbt30">나.</span> 시즌권의 분실 또는 도난 시 이용자는 즉시 사업자에게 유선/현장 신고를 하여야하며 시즌권담당부서에서 서면 (소정양식)을 작성후 재발급 처리하게되며 수수료는 이용자 본인이 부담하여야 합니다.</li>
							<li><span class="marginbt30 color_bl">다.</span> <span class="color_bl">훼손 또는 분실에 의한 재발급수수료는 20,000원이며 분실된 시즌권은 사용 정지되며, 추후 분실된 시즌권을 찾을 경우에도 해당 시즌권의 사용은 불가하며 재발급 수수료의 환불도 불가합니다.</span><br>
                                ※ 단,분실에 의한 재발급의 경우 분실 신고 24시간이 경과한 후에 재발급됩니다. (운영 시간외 재발급 불가)</li>
							<li><span class="marginbt10">라.</span> 추추후 분실된 시즌권을 찾을시에는 시즌권 담당부서에 반납하여 주시고, 회수된 시즌권에 대해서는 폐기합니다.</li>
						</ol><br><br>


						<h3 style="padding:0 3px;"><strong>제8조 (시즌권의 양도양수)</strong></h3><br>
						<div>
						<ol style="padding:5px;">
							<li><span class="marginbt30">가.</span> 시즌권의 양도양수는 최초 구입자 기준 1회에 한하며 수수료 납입 및 발급된 시즌권을 반납하여야 합니다.
								<ol>
									<li><span class="marginbt10">-</span> 양도양수 신청서를 작성하고  양도양수자는 신분증 사본을 제출해야 합니다.※ 시즌권 양도양수는 대리 신청 불가 합니다. ※</li>
								</ol>
							</li>
							<li class="color_bl"><span class="marginbt30">나.</span> 양도양수 수수료는 4만원이며, 양도양수 기간은 하기일내에만 가능합니다.<br>(전일권 : 개장일로부터 60일 이내)
								<ol>
									<li>&nbsp;&nbsp;&nbsp;- 위 내용과 같이 기본 사용기간 이후에는 시즌권 양도양수는 일체 불가합니다.</li>
								</ol>
							</li>
							<li class="color_bl"><span class="marginbt10">다.</span> 양도양수자의 경우 차기 시즌권 구매시 연속 구매(년차)의 혜택을 받을수 없습니다. </li>
							<li class="color_bl"><span class="marginbt10">라.</span> 시즌권 상품 중 경품, 무료교환권, 판촌행사용(동호회,특가상품등)이나 이월 된 시즌권은 양도양수 불가 합니다.
									<ol>
										<li>단 해외 이민, 임신, 유학, 군 입대, 신체장애(3주이상)등 사유로 인한 이용이 불가능 할 경우에 예외로 양도/양수 가능하며, 시즌권 자는 반드시 양도와 관련된 증빙 서류를 당사에 제출 해야 하며, 서류 미 제출시 불가 합니다.</li>
										<li>※ 위(나항) 기간 하기 일 내에만 가능합니다.※</li>
									</ol>		
							</li>
							<li>마. 시즌권의 분실시에는 양도 불가합니다. ( 재발 급 후 양도양수 신청 가능) </li>
							<li><span class="marginbt10">바.</span> 사업자(지산리조트)를 통해서만 양도양수가 가능하며, 개인간 임의로 행해지는 양도양수로인해 야기되는 불이익에 대해서 사업자는 일체 책임을 지지 않습니다.</li>
							<li>사. 온라인 특가 시즌권은 특별할인 상품으로 3주이상의 부상 및 이주, 이민, 입대 등 정당한 사유를 제외하고 양도불가 합니다.</li>
							<!-- <li>아. 할인상품 구매후 양도할 경우 정상요금 또는 개인상품과의 차액을 지불해야 가능합니다.</li> -->
						</ol>
						</div><br><br>


						<h3 style="padding:0 3px;"><strong>제9조 (시즌권의 환불)</strong></h3><br>
						<div>
						<ol style="padding:5px;">
							<li>가. 시즌권의 환불은 가능하며 개장전후의 환불기준은 차이가 있습니다.</li>
							<li>나. 시즌권 환불시에는 시즌권 이용자격이 상실되며, 반드시 발급받은 시즌권을 반납해야 합니다. (불법 사용 적발 시 벌과금이 부과 됩니다.)</li>
							<li class="color_bl">다. 환불 기준은 다음과 같습니다.
								<ol>
									<li>&nbsp;&nbsp;&nbsp; 1)개장전 환불 : 위약금(시즌권 구매가격의 10%) 공제후 환불</li>
									<li><span class="marginbt10" style="margin-left:13px;">&nbsp;&nbsp;&nbsp;2)</span>개장후 환불 :(전일권 : 개장일~60일이내)에만 가능합니다.<br>
											<span class="marginbt10" style="margin-left:15px;">환불금</span> = 구매가 - 위약금(시즌권 구매가격의 10% ) - 사용금액(시즌 일할 계산액 * 개장후 영업일수)<br>
											<!-- <span class="marginbt10" style="margin-left:15px;">※</span> 환불 기간중 개장후로부터 10일이내 환불의 경우 사용금액은 영업일수의 리프트 6시간권 정상요금 적용<br> -->
											<span class="marginbt10" style="margin-left:15px;">※</span> 일할계산 = (전일권 : 해당종권 정상금액 / 60일)<br>
											<span style="margin-left:15px;">※</span> 개장후 영업일수 = 시즌 개장일 ~ 청구일
									</li>
									<li><span>3)</span>개장후 미수령자 환불 : 위약금(시즌권 구매가격의 10%)공제후 환불</li>
								</ol>
							</li>
							<li class="color_bl"><span class="marginbt10">라.</span> 시즌권 구입후 수령하지 않은 시즌권 및 연기 신청 시즌권은 다음해 판매되는 시즌권 판매가 와의 차액을 지불 후 사용이 가능합니다.<br>※ 시즌권 연장 기간은 다음 해까지이며 이후 환불,이월 되지 않습니다.</li>
							<li>마. 2인 이상의 공동구매 기획 상품의 경우 개별 환불되지 않습니다. 단, 구성원의 차액 지불시 가능합니다.<br>※ 환불 입금 기간 : 신청 접수 날 부터 7~14일 소요 됩니다. ※</li>
						</ol>
						</div><br><br>


						<h3>제10조 (변경승인)</h3><br>
						<p>사업자는 서비스 및 약관의 변경이 있을시 그 내용을 사업자의 홈페이지 게재나 e-mail 발송 등을 통해 적용 예정일 10일 전까지 이용자에게 공지하며, 이용자의 특별한 이의가 없을시에는 승인한 것으로 간주합니다.
						</p><br><br>


						<h3>제11조 (면책)</h3><br>
						<p>재지변 또는 기타 불가항력적인 사유로 이용자에게 손해가 발생한 때에는 사업자는 이에 대한 책임을 지지 아니합니다.
							( 리프트 고장 및 정전, 정부정책, 전염병, 감염병 등 관련명령, 집합금지, 이용제한, 시설 폐쇄 등)
						</p><br><br>


						<h3>제12조 (가입 거부)</h3><br>
						<p>시즌권 구매 신청 후라도 신청자의 결격사유(과거 시즌권 또는, 리프트권 및 회원권의 불법매매, 양도, 대여, 회사의 명예 손상 및 업무방해 등)의 경우 시즌권의 발급은 거부 될 수 있습니다.</p><br><br>
						<h3>제13조 (기타)</h3><br>
						<ol>
							<li><span class="marginbt10">가.</span> 이 약관에 명시되지 아니한 사항 또는 이 약관의 해석상 다툼이 있는 사항에 대해서는 사업자와 이용자가 합의하여 결정하되 합의가 이루어지지 아니한 경우 관계법령 및 공정한 일반관행에 따른다</li>
							<li>나. 이 약관과 관련된 소송의 관할법원은 사업자의 관할 지역 법원으로 정한다.</li>
							<li><span class="marginbt10">다.</span> 본 시즌권 구입시 당사에 제출된 개인 정보에 대하여 당사가 필요시 홍보자료(e-mail,sms등)로  사용할 수 있는것에 동의 한것으로 간주합니다.</li>
							<li>라. 시즌권 구입시 주민등록번호 도용, 문서(등본,재직증명서 등) 위조 시 민·형사상의 처벌을 받을 수 있습니다.</li>
							<li>마. 본 약관은 판매개시일로부터 그 효력이 발생되며, 시즌권 발급과 미발급의 기준과는 관계가 없습니다.</li>
						</ol>
					</div>
					<ul class="agree fs16">
						<li class="f_child"><input type="radio" name="agree04" id="agree04-1" value="Y"><label for="agree01-1">동의</label></li>
						<li class="l_child"><input type="radio" name="agree04" id="agree04-2" value="N"><label for="agree01-2">동의하지 않음</label></li>
					</ul>
				</div>
				<div class="agree_wrap mt53">
					<div class="tit rel">
						<p class="fs20 fw300">[필수]필수사항에 대한 동의</p>
						<a href="javascript:void(0)" class="more_btn fs16 fw300 white">전문보기</a>
					</div>
					<div class="more fs14">
						<strong>23/24 시즌 리프트 시즌권 개인정보 수집이용 동의서(온라인)</strong><br><br>
						<div class="info_wrap">
							<div class="agree_info">
								<p>수집항목</p>
								<p>사용자명, 생년월일, 성별, 휴대전화번호, 이메일(대표자), 사진, 통장사본(환불시)</p>
							</div>
							<div class="agree_info">
								<p>수집 및 이용목적</p>
								<p>리프트시즌권상품 이용에 따른 본인식별, 부정이용 방지, 시즌권 발급, 환불/양도양수, 차기시즌 연차적용</p>
							</div>
							<div class="agree_info">
								<p>보유기간</p>
								<p>시즌종료일로부터 5년</p>
							</div>
						</div>
						<div>
							* 동의거부권리 :  이용자는 필수수집사항에 대해 동의를 거부할 수 있습니다. 다만, 필수입력사항에 대한 동의를 거부하시면 시즌권 상품 구입이 거절될 수 있습니다.<br/>
							* 2인이상 단체 구성원의 개인정보 수집이용에 대한 동의(2인이상 구입시에만 해당)<br/>
							* 임의의 단체의 구성원이 본인의 시즌권 구매를 위하여 단체의 대표자에게 본인의 개인정보를 제공하는 것을 이를 당사에서는 해당구성원 본인이 당사의 시즌권 개인정보수집이용동의에 동의하시는 것으로 봅니다. 따라서, 본인의 개인정보수집이용 동의에 동의하지 않으시는 구성원께서는 단체의 대표자에게 본인의 개인정보를 제공하지 마시기 바랍니다.
						</div>
					</div>
					<ul class="agree fs16">
						<li class="f_child"><input type="radio" name="agree01" id="agree01-1" value="Y"><label for="agree01-1">동의</label></li>
						<li class="l_child"><input type="radio" name="agree01" id="agree01-2" value="N"><label for="agree01-2">동의하지 않음</label></li>
					</ul>
				</div>
				<div class="agree_wrap mt53">
					<div class="tit rel">
						<p class="fs20 fw300">[선택]선택 항목에 대한 동의</p>
						<a href="javascript:void(0)" class="more_btn fs16 fw300 white">전문보기</a>
					</div>
					<div class="more fs14">
						<strong>23/24 시즌 리프트 시즌권 개인정보 수집이용 동의서(온라인)</strong><br><br>
						<div class="info_wrap">
							<div class="agree_info">
								<p>수집항목</p>
								<p>이메일(구성원), 전화번호, 회원님의선호종목, 지난시즌방문횟수</p>
							</div>
							<div class="agree_info">
								<p>수집 및 이용목적</p>
								<p>고지사항 전달, 통계 분석용</p>
							</div>
							<div class="agree_info">
								<p>보유기간</p>
								<p>시즌종료일로부터 5년</p>
							</div>
						</div>
						<div>
							* 동의거부권리 :  이용자는 선택 수집항목에 대해 동의를 거부할 수 있습니다. 거부하셔도 불이익없습니다
						</div>
					</div>
					<ul class="agree fs16">
						<li class="f_child"><input type="radio" name="agree02" id="agree02-1" value="Y"><label for="agree02-1">동의</label></li>
						<li class="l_child"><input type="radio" name="agree02" id="agree02-2" value="N"><label for="agree02-2">동의하지 않음</label></li>
					</ul>
				</div>
				<div class="agree_wrap mt53">
					<div class="tit rel">
						<p class="fs20 fw300">[선택]민감정보 수집에 대한 동의</p>
						<a href="javascript:void(0)" class="more_btn fs16 fw300 white">전문보기</a>
					</div>
					<div class="more fs14">
						<strong>23/24 시즌 리프트 시즌권 개인정보 수집이용 동의서(온라인)</strong><br><br>
						<div class="info_wrap">
							<div class="agree_info">
								<p>수집항목</p>
								<p>손혈관정보</p>
							</div>
							<div class="agree_info">
								<p>수집 및 이용목적</p>
								<p>리프트시즌권 본인방문 확인용</p>
							</div>
							<div class="agree_info">
								<p>보유기간</p>
								<p>시즌종료일로부터 1개월</p>
							</div>
						</div>
						<div>
							* 동의거부권리 :  이용자는 민감정보 수집에 대한 동의를 거부하실 권리가 있습니다. 다만, 거부하시면, 본인이 방문하였음을 당사에 대면확인을 받으신 후 이용할 수 있습니다.
						</div>
					</div>
					<ul class="agree fs16">
						<li class="f_child"><input type="radio" name="agree03" id="agree03-1" value="Y"><label for="agree03-1">동의</label></li>
						<li class="l_child"><input type="radio" name="agree03" id="agree03-2" value="N"><label for="agree03-2">동의하지 않음</label></li>
					</ul>
				</div>
				
			</div>

			<div class="txt_center mt40">
				<button type="button" class="brown_btn fs18 fw600 white" onclick="save();" >다음</button>
			</div>
		</form>
		</div>
	</div>
	<div class="loading"><img src="/w2/asset/images/sub/reservation/ajax-loader.gif" alt="" /></div>
	<IFRAME name="saveFrm" marginWidth="0" marginHeight="0" src="" frameBorder="0" width="100%" scrolling="0" height="500" style="display:<%if selfip<>"121.126.92.182" Then %>none<%End if%>"></IFRAME>

	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
<link href="/w2/asset/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/w2/asset/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/w2/asset/js/jquery_ui_cal.js?v=1"></script>
<script type="text/javascript">
var form = document.getElementById("insertF");
function save() {
	var $buytype = $("#buytype").val()
	var $nowCnt = $("#userCnt").val()
	var manCnt = 0;
	var womanCnt = 0;
	var groupCoupleCnt = 0;
	var childCnt = 0;
	var $halfPrice = $("#halfPrice")

	if (web.formValidation(form)){				
		if($buytype=="group"){
			if($("input[name=groupType]:checked").val()=="4" && $nowCnt<4){
				alert("단체 4인이상의 정보를 입력해야 합니다.")
				return false;
			}
			if($("input[name=groupType]:checked").val()=="8" && $nowCnt<8){
				alert("단체 8인이상의 정보를 입력해야 합니다.")
				return false;
			}
			for(var i=1;i<=$nowCnt;i++){
				var $sexVal = $("input[name=sex"+i+"]:checked").val()
				var $group_couple = $("input[name=group_couple"+i+"]:checked").val()
				if($sexVal == "1" && $group_couple=="Y"){
					manCnt = manCnt + 1
				}else if($sexVal == "2" && $group_couple=="Y"){
					womanCnt = womanCnt + 1
				}
				if($group_couple=="Y"){
					groupCoupleCnt = groupCoupleCnt + 1;
				}
			}
			if((groupCoupleCnt>0 && groupCoupleCnt<2) || groupCoupleCnt%2!=0){
				alert("커플선택을 다시한번 확인해주세요.\n현재 커플 사용자수 : "+groupCoupleCnt)
				return false;
			}
			if((groupCoupleCnt/2) != manCnt || (groupCoupleCnt/2) != womanCnt){
				alert("커플선택과 남여 성비가 맞지 않습니다.\n다시한번 확인해주세요.")
				return false;
			}
			if(!$("#groupChk").val()){
				alert("단체명 중복검사를 해주세요.")
				return false;
			}

		}
		if($buytype=="family"){
			for(var i=1;i<=$nowCnt;i++){
				if($("#memage"+i).val()=="3"){
					childCnt = childCnt + 1
				}
			}
			if(childCnt>0 && $halfPrice.val()==""){
				alert("반값적용 가능한 사용자가 있습니다.\n반값적용 버튼을 입력해주세요.")
				return false;
			}
		}

		if(!form.agree01[0].checked) {
			alert("[필수입력사항]에 대한 수집이용동의를 해주셔야 신청합니다.")
			form.agree01[0].focus();
			return;
		}
		if(!form.agree02[0].checked && !form.agree02[1].checked ) {
			alert("[선택]선택항목에 대한동의를 선택해주세요.")
			form.agree02[0].focus();
			return;
		}
		if(!form.agree03[0].checked && !form.agree03[1].checked ) {
			alert("[선택]민감정보  수집이용동의를 선택해주세요.")
			form.agree03[0].focus();
			return;
		}
		if(!form.agree04[0].checked) {
			alert("시즌권 이용에 대한 약관에 동의해주셔야 신청합니다.")
			form.agree04[0].focus();
			return;
		}

		$(".loading").height($(document).height()).fadeIn(300)
		form.target = "saveFrm";
		form.action = "buy01_save.asp";
		form.submit();
	}
}
function ifrmAlert(){
	$(".loading").fadeOut(300)	
}
//아이프레임에서 값체크후 이상없을경우 호출되어 다음페이지로 넘김
function saveNextMove() {
	form.target = "_self";
	form.action = "buy02.asp";
	form.submit();
}
// 단체명 중복 체크
function chkGroupName(){
	var $groupName = $("#s_group_name");
	var $groupChk = $("#groupChk")
	
	if(!$.trim($groupName.val())){
		alert("단체명을 입력해주세요.")
		$groupName.focus();
		return false;
	}
	
	$.ajax({
		url : "buy01_ajax_price.asp",
		dataType : "text",
		method: "POST",
		data : {"groupName":escape($groupName.val()),"memcode":escape($("#memcode1").val())},
		success : function(result) {
			if(result=="Y"){
				alert("사용가능한 단체명입니다.")
				$groupChk.val("1");
				return false;
			}else if(result=="N"){
				alert("사용중인 단체명입니다.")
				$groupName.select();
				return false;
			}else{
				if(confirm("기존에 입력한 정보가 존재합니다.\n불러오기 하시겠습니까?(권종은 다시 선택해주세요.)")){
					$(".loading").height($(document).height()).fadeIn(300)
					$(".addUser").html("").append(result)
					var totCnt = $(".addUser").find(".infoWrap").length+1
					$("#userCnt").val(totCnt)
					var group_level = $(".addUser").find(".infoWrap").attr("data-level")=="4"?0:1
					$("input[name=groupType]").eq(group_level).attr("checked",true).click()
					for(var i=2;i<=totCnt;i++){
						set_memcode(i)
					}
					var groupJangCouple = $("#groupJang").attr("data-group-couple")					
					var groupJangImg = $("#groupJang").attr("data-img")
					var rnd = Math.floor(Math.random() * 100) + 1;
					$(".imgDummy1").attr("src",groupJangImg+"?r="+rnd)
					if(groupJangCouple){
						$("#group_couple1").click();
					}

				}
				$groupChk.val("1");
				return false;
			}
		},
		error : function(status) {
			web.alert("에러가 발생하였습니다.");	
		}
	}).done(function(){
		var loadingClose = setTimeout(function(){
			$(".loading").fadeOut(300)	
		},3000)
	});
}
function fileupwindow(no) {
	var $memcode = $("#memcode"+no)	
	if(!$.trim($memcode.val())){
		alert("사용자 정보를 먼저 입력해주세요.")
		return false;
	}

	var $chkname = $("#name"+no).val();


	if(!confirm("시즌권사용자("+$chkname +"님)의 사진으로 등록됩니다.\n아닌경우 실사용자 정보 변경후 사진등록해주세요")) {
		return;

	}
	if($("#memtype"+no).val() == "0") {
		alert("회원구입자는 사진이 불필요합니다.")
		return false;
	}
	window.open("http://www1.jisanresort.co.kr/w2/reservation/ticket/pop/file_upload1.html?no=" + no+"&memcode="+escape($memcode.val()), "file_up_window","width=640,height=660");
}
function imgUploadRtn(f,i,n){
	var result = Math.floor(Math.random() * 100) + 1;
	$(".imgDummy"+n).attr("src",i+"?r="+result)
	$("#imagefile"+n).val(f)
}

function set_memcode(no){

	var $thisNo = no
	var $name = $("#name"+$thisNo)
	//var $birthy = $("#birthy"+$thisNo)
	//var $birthm = $("#birthm"+$thisNo)
	//var $birthd = $("#birthd"+$thisNo)
	var $birth = $("#birth"+$thisNo)
	var $sex = $("input[name=sex"+$thisNo+"]:checked")
	var $hp3 = $("#hp3"+$thisNo)
	var $memcode = $("#memcode"+$thisNo)
	var $buytype = $("#buytype")
	var $groupCnt = $("input[name=groupType]:checked").val()
	var $group_couple = $("input[name=group_couple"+$thisNo+"]:checked")
	var $halfPrice = $("#halfPrice")

	if ($name.val() && $birth.val() && $sex.val() && $hp3.val().length >=4 )	{
		memcode = $birth.val() + "-" + $sex.val() + "-" +$hp3.val() + "-" + $name.val()
		$memcode.val(memcode)
		
		//아래 소스파악 힘듬 
		if($buytype.val()=="group" && $groupCnt){
			$groupCnt = $groupCnt
			$group_couple = $group_couple.val()=="Y"?"Y":""
		}else{
			$groupCnt = ""
			$group_couple = ""
		}
		get_ticket_type($thisNo,$groupCnt,"N",$group_couple)
	} else {		
		$memcode.val()
	}

	if($halfPrice.val()==$thisNo && $buytype.val()=="family"){
		$halfPrice.val("")		
		get_ticket_type($thisNo,"","N","")
		$("#btn_half"+$thisNo).html("반값적용").removeClass("active");
	}

}

function get_ticket_type(n,m,hp,gc){//n : userNo, m : members, hp : halfPrice, gc : group_couple
	var n = n==""?"1":n
	var $memcode = $("#memcode"+n)
	var $buytype = $("#buytype").val()
	var $members = m==""?"1":m;
	var hp = hp=="Y"?hp:"N";
	var gc = gc=="Y"?gc:"N";

	$.ajax({
		url : "buy01_ajax_price.asp",
		dataType : "text",
		method: "POST",
		data : {"memcode":escape($memcode.val()),"buytype":$buytype,"members":$members,"halfPrice":hp,"group_couple":gc},
		success : function(result) {
			var resultArr = result.split("!!!")
			var resultArr2 = resultArr[1].split(",")
			$("#selgubun"+n).html(resultArr[0])
			$("#memtype"+n).val(resultArr2[0])
			$("#yearcha"+n).val(resultArr2[1])
			$("#memage"+n).val(resultArr2[2])
			if($buytype=="group"){
				var $data_usetime = $("#selgubun"+n).attr("data-usetime")
				$("#selgubun"+n+">option").eq($data_usetime-1).attr("selected",true);

				var groupJangUsetime = $("#groupJang").attr("data-usetime")
				$("#selgubun1>option").eq(groupJangUsetime-1).attr("selected",true);

			}
			if($buytype=="family" && resultArr2[2]=="3"){
				$("#btn_half"+n).show();
			}else{
				$("#btn_half"+n).hide();
			}
		},
		error : function(status) {
			web.alert("에러가 발생하였습니다.");	
		}
	});
}

function limit_max_cnt(){
	var $buytype = $("#buytype").val()
	var $nowCnt = $("#userCnt").val()
	var maxCnt = 0
	switch($buytype){
		case "couple":
			maxCnt = 2;
			break;
		case "family":
			maxCnt = 5;
			break;
		case "group":
			if($("input[name=groupType]:checked").val()=="4"){
				maxCnt = 7;
				break;				
			}else if($("input[name=groupType]:checked").val()=="8"){
				maxCnt = 50;
				break;
			}else{				
				return "ex";
			}
		default:
		break;
	}
	if($nowCnt<maxCnt){
		return true
	}else{
		return false;
	}
}
$(function(){
	var seasonFlag = false;
	//$("a[href=#]").click(function(e){
		//e.preventDefault();
	//})
	$("ul#ticketPlus li").click(function(){
		if(seasonFlag){
			var confMsg = "시즌권종을 변경하면\n기존에 입력했던 데이타가 초기화 됩니다.\n변경하시겠습니까?";
			$("#familyMsgli").hide();
			if($(this).attr("alt")=="family"){
				confMsg = "시즌권종을 변경하면\n기존에 입력했던 데이타가 초기화 됩니다.\n(가족권은 소인1인에 한해 년차적용없이 반값할인해드립니다.)\n변경하시겠습니까?";
				$("#familyMsgli").show();
			}

			//if(confirm(confMsg)){
				var $memcode = $("#memcode1")
				var buytype = $(this).attr("alt");
				var loopCnt = 0
				$("#selgubun1").html("<option value=''>Loading....</option>")
				$("#buytype").val(buytype);
				$(".buy02_group,.add_user,.del_user,.couple_wrap").hide()
				$(".addUser").html("");
				$(this).addClass("on").siblings().removeClass("on");	
				$(this).siblings().find("img").attr("src","/w2/asset/images/sub/reservation/ticket02_02_radio.png")
				$(this).find("img").attr("src","/w2/asset/images/sub/reservation/ticket02_02_radio_on.png")



				get_ticket_type("1","","N","")
				$("#userCnt").val("1")	
				$("input[name=groupType]").attr("checked",false)
				$("#s_group_name").val("")
				if(buytype=="couple"){
					loopCnt = 1
				}

				if(buytype=="family"){
					$(".add_user").show()
					$(".del_user").show()
					loopCnt = 2
				}

				if(buytype == "group") {
					$(".buy02_group,.couple_wrap").show();
					$(".add_user").show()
					$(".del_user").show()
				}
				if(loopCnt>0){
					for (var i=0;i<loopCnt ;i++ ){
						$(".add_user").click();
					}
				}
			//}
		}
		seasonFlag = true
	}).eq(0).click();

	$("ul#ticketPlus2 li").click(function(){
		console.log("aa");
		var hash = $(this).attr("alt");
		location.href="buy02_1.asp#"+hash;
	});


	

	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	$(document).on("keyup click change", "input[data-memcode='true'],select[data-memcode='true']", function() {		
		var $thisNo = $(this).closest(".infoWrap").attr("id")
		set_memcode($thisNo);
	});

	$( ".birth" ).datepicker({buttonText: "Select date",dateFormat: "yymmdd"});	


	// 4인, 8인 라디오버튼
	$("input[name=groupType]").click(function(){
		var $thisVal = $(this).val();
		var $nowCnt = $("#userCnt").val()
		if($thisVal=="4" && $nowCnt>"7"){
			if(confirm("사용자정보 작성이력이 있습니다.\n변경시 추가 사용자의 데이타가 초기화됩니다.\n계속 진행하시겠습니까?")){
	//			$(".addUser").html("")
				$(".addUser").find(".infoWrap").each(function(){
					 var $thisNo = $(this).attr("id");
					 if($thisNo>7){
						$(this).remove();
					 }
				})
				$("#userCnt").val("1")
			}else{
				$("input[name=groupType]").eq(1).click()
			}
		}
		for(var i=1; i<=$nowCnt;i++){
			if($("#memcode"+i).val()){
				get_ticket_type(i,$thisVal,"N","")
			}
		}
		$("#s_group_level").val($thisVal)
	})
	$(".add_user").click(function(){
		var $buytype = $("#buytype").val()
		var group_couple_html = ""
		var btn_half = ""
		var lmc = limit_max_cnt();
		if(!lmc){
			alert("사용자 추가 범위를 초과할수 없습니다.")
			return false;
		}else if(lmc=="ex"){
			alert("단체구분 정보를 입력해주세요.");
			$("input[name=groupType]").eq(0).focus();
			return false;
		}else{
			var $nowCnt = $("#userCnt").val()
			var $userCnt = parseInt($nowCnt)+1
			$("#userCnt").val($userCnt)
		}
		if($buytype=="group"){
			group_couple_html = "&nbsp;&nbsp;<input type='checkbox' name='group_couple"+$userCnt+"' id='group_couple"+$userCnt+"' class='group_couple' value='Y'/>커플"
		}
		if($buytype=="family"){
			btn_half = "&nbsp;&nbsp;<span class='btn_half' id='btn_half"+$userCnt+"'>반값적용</span>"
		}
		
		var innerHtml = "<div class='infoWrap' id='"+$userCnt+"'>";
		innerHtml += "				<p class='sub_stit pb36 pt60'>사용자"+$userCnt+"</p>";
		innerHtml += "				<div class='cont03'>";
		innerHtml += "					<div class='clearfix'>";
		innerHtml += "						<div class='profile tbpc_f_left'>";
		innerHtml += "							<div class='box' style='padding-top:0px'>";
		innerHtml += "								<img src='/w2/asset/images/sub/reservation/photo_sample.jpg' alt='업로드이미지' class='imgDummy"+$userCnt+"'>";
		innerHtml += "							</div>";
		innerHtml += "							<div class='file'>";
		innerHtml += "								<input type='hidden' class='box015' id='imagefile"+$userCnt+"' name='imagefile"+$userCnt+"' title='파일첨부'>";
		innerHtml += "								<span class='file_add fs16 fw600' onclick='fileupwindow("+$userCnt+");'>찾아보기</span>	";					
		innerHtml += "							</div>";
		innerHtml += "						</div>";
		innerHtml += "						<table class='basic_table tbpc_f_left'>";
		innerHtml += "							<input type='hidden' name='memtype"+$userCnt+"' id='memtype"+$userCnt+"'>";
		innerHtml += "							<input type='hidden' name='yearcha"+$userCnt+"' id='yearcha"+$userCnt+"'>";
		innerHtml += "							<input type='hidden' name='memage"+$userCnt+"' id='memage"+$userCnt+"'>";
		innerHtml += "							<colgroup>";
		innerHtml += "								<col style='width:27%'>";
		innerHtml += "								<col style='width:auto'>";
		innerHtml += "							</colgroup>";
		innerHtml += "							<caption>개인권 사용자정보</caption>";
		innerHtml += "								<tbody>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>사용자명</th>";
		innerHtml += "									<td scope='row'>";
		innerHtml += "										<input type='text' name='name"+$userCnt+"' id='name"+$userCnt+"'  data-valid='notnull' data-alert='이름' data-memcode='true'>";
		innerHtml += "									</td>";
		innerHtml += "								</tr>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>생년월일/성별</th>";
		innerHtml += "									<td scope='row' class='birth'>	";
		innerHtml += "										<input type='text' id='birth"+$userCnt+"' name='birth"+$userCnt+"' class='birth birth"+$userCnt+"'  data-valid='notnull' data-alert='생년월일' readonly  data-memcode='true'>";
		innerHtml += "										<p class='gender'>";
		innerHtml += "											<input type='radio' name='sex"+$userCnt+"' value='1'  data-memcode='true'><label for='sex1'>남</label>";
		innerHtml += "											<input type='radio' name='sex"+$userCnt+"' value='2'  data-memcode='true'><label for='sex2'>여</label>";
		innerHtml += "											"+group_couple_html+"";
		innerHtml += "										</p>";
		innerHtml += "									</td>";
		innerHtml += "								</tr>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>휴대전화 번호</th>";
		innerHtml += "									<td scope='row'>";
		innerHtml += "										<select id='hp1"+$userCnt+"' name='hp1"+$userCnt+"' class='hp1'> ";
		innerHtml += "											<Option Value='010'>010</Option><Option Value='011'>011</Option><Option Value='016'>016</Option>";
		innerHtml += "											<Option Value='017'>017</Option><Option Value='018'>018</Option><Option Value='019'>019</Option>";
		innerHtml += "										</Select> - ";
		innerHtml += "										<input type='text' name='hp2"+$userCnt+"' id='hp2"+$userCnt+"' class='hp2' value='' numberonly='true' maxlength='4' data-valid='notnull' data-alert='휴대전화번호'> -"; 
		innerHtml += "										<input type='text' name='hp3"+$userCnt+"' id='hp3"+$userCnt+"' class='hp2' value='' numberonly='true' maxlength='4' data-valid='notnull' data-alert='휴대전화번호' data-memcode='true'>";
		innerHtml += "									</td>";
		innerHtml += "								</tr>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>이메일</th>";
		innerHtml += "									<td scope='row' class='emali'>";
		innerHtml += "									<input type='text' title='이메일' name='email"+$userCnt+"' id='email"+$userCnt+"' data-valid='notnull' data-alert='이메일' class='member_num' value='' data-valid='email' data-alert='이메일'>	";				
		innerHtml += "								</td>";
		innerHtml += "								</tr>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>회원번호</th>";
		innerHtml += "									<td scope='row'>";
		innerHtml += "										<input type='text' name='memcode"+$userCnt+"' id='memcode"+$userCnt+"' class='member_num' value='' data-valid='notnull' data-alert='회원번호' readonly>";						
		innerHtml += "									</td>";
		innerHtml += "								</tr>";
		innerHtml += "								<tr>";
		innerHtml += "									<th scope='row'>권종</th>";
		innerHtml += "									<td scope='row' class='ticket'>";
		innerHtml += "										<select id='selgubun"+$userCnt+"' name='selgubun"+$userCnt+"' class='select_wrap'>";
		innerHtml += "										</select>"+btn_half+"";
		innerHtml += "									</td>";
		innerHtml += "								</tr>";
		innerHtml += "							</tbody>";
		innerHtml += "						</table>";
		innerHtml += "					</div>";
		innerHtml += "				</div>";
		innerHtml += "			</div>";
		$(".addUser").append(innerHtml)
		$( ".birth" ).datepicker({buttonText: "Select date",dateFormat: "yymmdd"});	

	})

	//그룹커플 클릭시 요금적용호출
	$("body").on("click",".group_couple",function(){
		var $thisNo = $(this).closest(".infoWrap").attr("id")
		set_memcode($thisNo);
	})

	//가족소인 반값적용 클릭시 요금적용호출
	$("body").on("click",".btn_half",function(){
		var $thisNo = $(this).closest(".infoWrap").attr("id");
		var $thisActive = $(this).hasClass("active");
		var $halfPrice = $("#halfPrice")
		
		if($thisActive){
			$(this).html("반값적용").removeClass("active");
			halfPrice = ""
			halfPriceYn = "N"
		}else{
			if(!$halfPrice.val()){
				$(this).html("적용취소").addClass("active");
				halfPrice = $thisNo
				halfPriceYn = "Y"
				//$("#name,#birth")
			}else{
				alert("반값적용된 사용자가 있습니다.(소인1인에 한함)")
				return false;
			}
		}
		$halfPrice.val(halfPrice)		
		get_ticket_type($thisNo,"",halfPriceYn,"")
	})
	// 마지막 사용자 삭제
	$("body").on("click",".del_user",function(){
		//var $thisNo = $(this).closest(".infoWrap").attr("id");
		var $nowCnt = $("#userCnt").val()
	
		var $userCnt = parseInt($nowCnt)-1
		$("#userCnt").val($userCnt)
		$("#"+$nowCnt).remove()
		//$(this).closest(".infoWrap").remove()
		
	})
//	$(".userCount").eq($("#userCnt").val()-2).text("-")

	//클릭해주기
	<% if memtype = "8" Then %>
	if(location.hash.replace("#s","") == "1") {
		alert("개인권 구매가능합니다.")
		location.href = "/reservation/ticket/buy/buy01.asp";
		return;
	}

	<% End If %>
	$("ul#ticketPlus li:eq("+location.hash.replace("#s","")+")").trigger('click');

});  

function agreeAll(){
	if($("#agreeall").prop("checked")) { 
		$('input:radio[name^="agree"]:radio[value="Y"]').prop('checked', true);
	} else {
		$('input:radio[name^="agree"]:radio[value="Y"]').prop('checked', false);
		$('input:radio[name^="agree"]:radio[value="N"]').prop('checked', false);

	}
}
</script>
</body> 
</html>
<%
	If NullChk(preMemcode) = False Then
		If preS_account_check = "0000" Then
			Call ScriptAlert("이미 [" & fn_buytypeName(preBuytype) & "] 결재완료한 구매 내역이 있습니다.\n추가구매시 기본정보 지우고 구매자 정보로 입력후 구매가능합니다.")
		Else
			Call ScriptAlert("이미 [" & fn_buytypeName(preBuytype) & "] 입금이 처리되지 않은 신청 내역이 있습니다.\n추가구매시 기본정보 지우고 구매자 정보로 입력후 구매가능합니다.")
		End If
	End If
%>