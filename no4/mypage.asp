<!--#include virtual="/conf/config.asp"-->
<!-- #include virtual="/proc/mypage.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_function.asp" -->
<%
	Call SetDB(conn, rs)
	Call SetDBNot(conn, rs)
%>

<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head.asp"-->
</head>
<body>
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
			<!-- <div class="inset">
				<h2 class="tit">마이페이지</h2>
			</div> -->
			<span class="bg"></span>
			<div class="location">
				<ul class="clearfix">
					<li class="first"><a href="/w2/"><img src="/w2/asset/images/common/home_icon.png" alt=""></a></li>
					<li class="arrow">
						<a href="/w2/member/mypage.asp">마이페이지</a>
					</li>
					<li class="arrow sub_menu">
						<a href="javascript:void(0)" class="mw143">메인</a>
						<ul>
							<li><a href="/w2/member/mypage/golf01.asp">예약&amp;구매 내역</a></li>
							<li><a href="/w2/member/customer_list.asp" class="">1:1문의</a></li>
							<li><a href="/w2/member/mypage/member_pwc.asp" class="">회원정보수정/탈퇴</a></li>
							<li><a href="/w2/member/mypage/pw_change.asp" class="">비밀번호 변경</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="new_top">
				<div class="new_tit_wrap">
					<p class="new_tit_bar">마이페이지</p>
					<p class="new_tit_sub">지산 리조트는 기쁨과 즐거움이 항시 있는 리조트를 위해 노력하고 있습니다</p>
				</div>
			</div>
		</div>

		<div class="inner mt230 pb143">
			<div class="fs30 brown pb40">예약 /구매 내역 조회</div>

			<div class="fs22 ">골프장</div>
			<div class="total_wrap txt_center pt10 pb88 total_wrap2">
				<ul class="clearfix">
					<!-- <li>
						<p>회원제 예약조회</p>
						<div><a href="<%=myGolfRevLink%>" class="fw600 fs60"><%=clubRevCnt%></a> <span class="fs28">건</span></div>
					</li>
					<li>
						<p>퍼블릭 예약조회</p>
						<div><a href="../reservation/golfResv/public_reserv_list.asp" class="fw600 fs60"><%=publicRevCnt%></a> <span class="fs28">건</span></div>
					</li> -->
					<li>
						<p>회원제 예약조회</p>
						<div><a href="<%=myGolfRevLink%>" class="rel fs16 white brown_btn mt40">바로가기</a></div>
					</li>
					<li>
						<p>퍼블릭 예약조회</p>
						<div><a href="../reservation/golfResv/public_reserv_list.asp" class="rel fs16 white brown_btn mt40">바로가기</a></div>
					</li>
					<li>
						<p>스코어조회</p>
						<div><a href="<%=myGolfScoLink%>" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>		
					
				</ul>
			</div>
			
			<div class="fs22 ">스키장</div>
			<div class="total_wrap txt_center pt10 pb88 my_detail ski_list">
				<ul class="clearfix">
					<li>
						<p>리프트/장비<br>렌탈 예약</p>
						<!-- <div><a href="./mypage/lift_list.asp" class="fw600 fs60"><%=liftCnt%></a> <span class="fs28">건</span></div> -->
						<div><a href="./mypage/lift_list.asp" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>
					<li>
						<p>스키&보드<br>강습 예약</p>
						<div><a href="./mypage/lesson01_list.asp" class="fw600 fs60"><%=lessonCnt%></a> <span class="fs28">건</span></div>
					</li>
					<!-- <li>
						<p>개인 락카함<br>구매</p>
						<div><a href="/w2/reservation/gear/complete.asp" class="fw600 fs60"><%=gearCnt%></a> <span class="fs28">건</span></div>
			
					</li>
					<li>
						<p>부츠 락카함<br>구매</p>
						<div><a href="./mypage/locker_list.asp" class="fw600 fs60"><%=bootCnt%></a> <span class="fs28">건</span></div>
					</li> -->
					<li>
						<p>시즌권 이용<br>조회</p>
						<div><a href="./mypage/ticket_chart.asp" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>	
					<li>
						<p>사설 강습<br>조회</p>
						<div><a href="./mypage/fallline_list.asp" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>	
				</ul>
			</div>
			<!-- sns 로그인 시 -->
			<div class="total_wrap txt_center pt10 pb88 my_detail ski_list sns_ski_list">
				<ul class="clearfix">
					<li>
						<p>리프트/장비<br>렌탈 예약</p>						
						<div><a href="./mypage/lift_list.asp" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>					
					<li>
						<p>회원정보 수정</p>
						<div><a href="./mypage/member_pwc.asp" class="rel fs16 white brown_btn mt40">자세히 보기</a></div>
					</li>	
				</ul>
			</div>
			<!-- //sns 로그인 시 -->
			
			<div class="fs30 brown pb40"><!-- 구매 내역 --></div>

			<div class="fs22 ">스키장 시즌권 구매 내역</div>
			<div class="pt10 pb69 rel">
				<a href="/w2/member/mypage/org_list.asp" class="more white fs15 fw200">개별검색 +</a>
				<table class="mypage_table txt_center">
				<caption>스키장 시즌권 구매 내역</caption>
				<colgroup>
					<col style="width:auto">
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:15%">
				</colgroup>

					<thead>
						<tr>
							<th>회원번호</th>
							<th>구분</th>
							<th>권종</th>
							<th>금액</th>
							<th>결제</th>
							<th>주문일자</th>
						</tr>
					</thead>
					<tbody>
				<%	If isArray(arrTicket) Then
							For i = 0 To UBound( arrTicket, 2)	
								seq					=		conDBToString( arrTicket(0, i), "")
								memtype			=		conDBToString( arrTicket(1, i), "")
								yearcha				=		conDBToString( arrTicket(2, i), "")
								name					=		conDBToString( arrTicket(3, i), "")
								birth					=		conDBToString( arrTicket(4, i), "")
								sex					=		conDBToString( arrTicket(5, i), "")	
								hp						=		conDBToString( arrTicket(6, i), "")	
								tel						=		conDBToString( arrTicket(7, i), "")	
								email					=		conDBToString( arrTicket(8, i), "")	
								imagefile			=		conDBToString( arrTicket(9, i), "")	
								fileok					=		conDBToString( arrTicket(10, i), "")	
								poll1					=		conDBToString( arrTicket(11, i), "")	
								poll2					=		conDBToString( arrTicket(12, i), "")	
								login_id				=		conDBToString( arrTicket(13, i), "")	
								buytype				=		conDBToString( arrTicket(14, i), "")	
								s_memage			=		conDBToString( arrTicket(15, i), "")	
								s_usetime			=		conDBToString( arrTicket(16, i), "")	
								s_price				=		conDBToString( arrTicket(17, i), "")	
								s_sumprice			=		conDBToString( arrTicket(18, i), "")	
								s_group_memcode	=		conDBToString( arrTicket(19, i), "")	
								s_group_name		=		conDBToString( arrTicket(20, i), "")	
								s_group_level			=		conDBToString( arrTicket(21, i), "")	
								s_group_position		=		conDBToString( arrTicket(22, i), "")	
								s_group_couple		=		conDBToString( arrTicket(23, i), "")	
								s_account_method	=		conDBToString( arrTicket(24, i), "")	
								s_account_check	=		conDBToString( arrTicket(25, i), "")	
								s_account_order		=		conDBToString( arrTicket(26, i), "")	
								s_account_dt			=		conDBToString( arrTicket(27, i), "")	
								reg_ymd					=		conDBToString( arrTicket(28, i), "")	
								memcode				=		conDBToString( arrTicket(30, i), "")	
				%>
						<tr>
							<td><%=memcode%></td>
							<td><%=fn_buytypeName(buytype)%>
							
								<% 
									tmpMemtype = memtype
									If memtype = "6" And buytype <> "personal" Then
										tmpMemtype = "1"
									End If
									If memtype = "6" And s_usetime <> "1" Then 
										tmpMemtype = "1"
									End If
								%>
								<%=fn_memtypeName(tmpMemtype)%>
								<% If s_usetime="1" or s_usetime="2" Then %><%If tmpMemtype = "1" And yearcha > 1 Then Response.write "(" & yearcha & "년차)" End If %><% End If %>	
							</td>
							<td><%=fn_useTimeName(s_usetime)%></td>
							<td>
								<% If Left(buytype,4) = "plus" Then %>
									<%=FormatNumber(s_sumprice,0)%> 원
								<% Else %>
									<%=FormatNumber(s_price,0)%> 원 <% If s_group_position = "Y" Then %> <br/>(전체 : <%=FormatNumber(s_sumprice,0)%> 원)</td> <% End If %>
								<% End If %>
							</td>
							<td><%=fn_accountName(s_account_method)%> (<%=fn_accountChkName(s_account_check)%>)</td>
							<td><%=putdate(reg_ymd,"YYYY.MM.DD")%></td>
						</tr>
				<%		Next
						Else	%>
						<tr>
							<td colspan="6">당사 홈페이지 구매 내역이 없습니다.</td>							
						</tr>
				<%	End If %>

					
					</tbody>
				</table>
			</div>
			

		<!-- 	<div class="fs22 ">부츠 락카함 구매 내역</div>
			<div class="pt10 pb120 rel">
				<a href="/w2/member/mypage/locker_list.asp" class="more white fs15 fw200">더보기 +</a>
				<table class="mypage_table txt_center">
				<caption>부츠 락카함 구매 내역</caption>
				<colgroup>
					<col style="width:12%">
					<col style="width:12%">
					<col style="width:15%">
					
					<col style="width:auto">
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
					<thead>
						<tr>
							<th>구매일</th>
							<th>락카타입</th>
							<th>락카번호</th>
							<th>주문번호</th>
							<th>가격</th>
							<th>결제방법</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
				<%	If isArray(arrBoot) Then
							For i = 0 To UBound( arrBoot, 2)								
								account_method = "무통장"
								account_check = "미입금"
								If arrBoot(5, i) ="1" Then account_method = "카드"
								If arrBoot(6, i) ="0000" Then account_check = "결제완료"
				%>
								<tr>
									<td><%=putdate(arrBoot(0, i),"yyyy.mm.dd")%></td>
									<td><%=arrBoot(1, i)%>단</td>
									<td><%=arrBoot(2, i)%>&nbsp;(<%=arrBoot(7, i)%>)</td>
									<td><%=arrBoot(3, i)%></td>
									<td><%=arrBoot(4, i)%></td>
									<td><%=account_method%></td>
									<td><%=account_check%></td>
									
								</tr>
				<%		Next
						Else	%>
								<tr>
									<td colspan="7">내역이 없습니다.</td>
								</tr>
				<%	End If %>
					</tbody>
				</table>
			</div> -->

			<div class="fs30 brown pb40">1:1 문의</div>
			<div class="fs22 ">고객의 소리</div>
			<div class="pt10 pb69 rel">
				<a href="/w2/member/customer_list.asp" class="more white fs15 fw200">더보기 +</a>
				<table class="mypage_table txt_center">
				<caption>고객의 소리</caption>
				<colgroup>
					<col style="width:15%">
	
					<col style="width:auto">
					<col style="width:15%">
					<col style="width:15%">
				</colgroup>

					<thead>
						<tr>
							<th>구분</th>
							<th>제목</th>
							<th>등록일</th>
							<th>처리상태</th>
					
						</tr>
					</thead>
					<tbody>
				<%	If isArray(arrQnA) Then
							For i = 0 To UBound( arrQnA, 2)

								'// 출력
								If arrQnA(4, i) = "001" Then
									stat_cs = "qna_reg"
									stat_nm = "접수완료"
									moveUrl = "customer_view.asp"
								Else
									stat_cs = "qna_ans"
									stat_nm = "답변완료"
									moveUrl = "customer_view.asp"
								End If
				%>
									
							<tr>
								<td><%=FncBoardGubun(arrQnA(1, i))%></td>
								<td><a href="javascript:void(0);" onclick="web.pageMove('<%=moveUrl%>','seq=<%=arrQnA(0, i)%>')"><%=arrQnA(2, i)%></a></td>
								<td><%=putDate(arrQnA(6, i),"yyyy-mm-dd")%></td>
								<td><span class="<%=stat_cs%>"><%=stat_nm%></span></td>
							</tr>
				<%		Next
						Else	%>
							<tr>
								<td scope="row" colspan="5">내역이 없습니다.</td>
							</tr>
				<%	End If %>
						
					</tbody>
				</table>
			</div>

		
		</div>
	</div>
	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
</html>