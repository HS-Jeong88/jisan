<!-- #include virtual="/conf/Config.asp" -->
<!--#include virtual="/conf/resvLift/prdt_setting.asp"-->
<%
	Call SetDBSki(conn, rs)
	
	Dim id
		If NullChk(js_id) Then
			id = Session("sns_id")
		Else
			id = js_id
		End If
	sql = " exec xtw_WB_TK_SALES_S4  '"&id&"' "
	Call QueryOne(sql, buyYn)

	If buyYn <> "ERROR" Then
		arrLift =	QueryRows( sql)
	End If

	Call SetDBNot(conn, rs)
%>
<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head.asp"-->
</head>
<body data-number="subGnb01">
	<!-- header -->
	<header class="sub header rel mypage_h">
		<!-- #include virtual="/w2/asset/inc/header_top.asp"-->
		<!-- #include virtual="/w2/asset/inc/header_mypage.asp"-->
		<!-- #include virtual="/w2/asset/inc/header_quick.asp"-->
	</header>
	<a href="javascript:void(0)" class="btn_top">TOP</a>
	<!-- //header -->

	<div class="sub mypage lift_list">
		<div class="top bg_mypage">
			<!-- <div class="inset">
				<h2 class="tit">리프트/장비 렌탈 예약 조회</h2>
			</div> -->
			<span class="bg"></span>
			<div class="location "><!-- no_tab -->
				<ul class="clearfix">
					<li class="first"><a href="/w2/"><img src="/w2/asset/images/common/home_icon.png" alt=""></a></li>
					<li class="arrow">
						<a href="javascript:void(0)">마이페이지</a>
					</li>
					<li class="arrow sub_menu">
						<a href="javascript:void(0)" class="mw143">예약&amp;구매 내역</a>
						<ul>
							<li class="on"><a href="/w2/member/mypage/shuttle_list.asp">예약&amp;구매 내역</a></li>
							<li><a href="/w2/member/customer_list.asp" class="">1:1문의</a></li>
							<li><a href="/w2/member/mypage/member_pwc.asp" class="">회원정보수정/탈퇴</a></li>
							<li><a href="/w2/member/mypage/pw_change.asp" class="">비밀번호 변경</a></li>
						</ul>
					</li>
					<li class="arrow sub_menu">
						<a href="javascript:void(0)" class="mw143">리프트/장비 렌탈 예약 조회</a>
						<ul>
							<li><a href="/w2/member/mypage/golf01.asp">회원제 예약 조회</a></li>
							<li><a href="/w2/member/mypage/golf02.asp">퍼블릭 예약 조회</a></li>
							<li><a href="/w2/member/mypage/golf_score.asp">스코어 조회</a></li>
							<!-- <li><a href="/w2/member/mypage/shuttle_list.asp">셔틀버스 예약</a></li> -->
							<li><a href="/w2/member/mypage/org_list.asp">시즌권</a></li>
							<li class="on"><a href="/w2/member/mypage/lift_list.asp">리프트/장비 렌탈 예약 조회</a></li>
							<li><a href="/w2/member/mypage/lesson01_list.asp">강습 예약</a></li>
							<li><a href="/w2/member/mypage/locker_list.asp">부츠 보관함</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="new_top">
				<div class="new_tit_wrap">
					<p class="new_tit_bar">리프트/장비 렌탈 예약 조회</p>
					<p class="new_tit_sub">지산 리조트는 누구나 안전하고 쾌적하게 생의 활력을 충전할 수 있는<br />서비스 구현을 위해 노력하고 있습니다</p>
				</div>
			</div>
		</div>
        <div class="tab_bg">
            <ul class="tab_wrap w2">
                <li><a href="/w2/member/mypage/lift_list.asp" class="on">리프트/장비 렌탈 예약 조회</a></li>
                <li><a href="/w2/member/mypage/event_list.asp">이벤트 내역 조회</a></li>
            </ul>
        </div>
		<div class="inner pt100 pb143">
			<div class="fs30 brown pb40">리프트/장비 렌탈 예약 조회</div>
			<!--<div class="fs22 ">리프트 예약 조회하기</div>
			
				<div class="fs22 ">리프트 예약 확인</div>-->	
				<div class="pt10 rel">
                    <!-- <table class="mypage_table lift">
                        <caption>결제 상태 구분</caption>    
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: auto;">
                        </colgroup>
                        <tr>
                            <th>결제 상태 구분</th>
                            <td>
                                <label>
                                    <input type="radio" name="reserv_type" value="all" checked>
                                    전체
                                </label>
                                <label>
                                    <input type="radio" name="reserv_type" value="y">
                                    결제 완료
                                </label>
                                <label>
                                    <input type="radio" name="reserv_type" value="n">
                                    결제 취소
                                </label>
                            </td>
                        </tr>
                    </table> -->
					<table class="mypage_table txt_center">
					<caption>리프트 예약 확인</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:15%">					
						<col style="width:15%">
					</colgroup>

						<thead>
							<tr>
								<th>발권상태</th>
								<th>구매날짜</th>
								<th>주문번호</th>
								<th>구매내용</th>
								<th>주중/주말</th>
								<th>구매금액</th>
								<th>상태</th>
								
							</tr>
						</thead>
						<tbody>
		<%	if isArray(arrLift) Then
					For liftnum = 0 To UBound( arrLift, 2)	
						sales_dt			= arrLift(0, liftnum)
						order_no		= arrLift(1, liftnum)
						ticket_nm		= arrLift(2, liftnum)
						ticket_tot_amt	= arrLift(3, liftnum)
						ticket_chk		= arrLift(4, liftnum)
						order_status	= arrLift(5, liftnum)
						lgd_tid			= arrLift(6, liftnum)
						refund_dt		= arrLift(7, liftnum)
						use_yn			= arrLift(8, liftnum)
						ticket_status	= arrLift(9, liftnum)
						use_dt			= arrLift(10, liftnum)
						slip_no			= arrLift(11, liftnum)
						pos_id			= arrLift(12, liftnum)
						date_kind			= arrLift(13, liftnum)

						If NullChk(use_dt) Then 
							use_dt = ticket_status
							use_cls = ""
						Else
							use_dt = putdate(use_dt,"yyyy-mm-dd")
							use_cls = "complete"
						End If

						If order_status <> "정상" Then
							use_cls = "complete"	
						End If
							
					
						
	
		%>
						<tr class="<%=use_cls%>">
							<td><%=use_dt%></td>
							<td><%=putdate(sales_dt,"yyyy-mm-dd")%></td>
							<td><a href="javascript:void(0);" onclick="web.pageMove('lift_view.asp','order_no=<%=order_no%>')"><%=order_no%></a></td>
							<td><%=ticket_nm%></td>
							<td><%=date_kind%></td>
							<td><%=FormatNumber(ticket_tot_amt,0)%></td>
							<td><%=order_status%></td>
						
							
						</tr>
			<%		Next
					Else	%>
							<tr>
								<td colspan="7">구매한 리프트가 없습니다.</td>							
							</tr>
			<%	End If %>
						</tbody>
					</table>
				</div>

				<div class="bg_gray gray2 fs16 lh16_ver3 notice_wrap clearfix mt43">
					<p class="fw500 notice_tit ico_arr">공지</p>
					<ul class="fw300 notice_cont">
						<li class="dot hyphen">구매하신 권종 외 다른 권종으로 변경이 불가합니다.</li>
						<li class="dot hyphen">본 상품은 리프트권 단품으로 장비 렌탈 및 의류, 기타 렌탈이 포함되지 않습니다.</li>
						<!-- <li class="dot hyphen">구매하신 리프트권은 익일부터 사용 가능하며, 심야권은 익일 23:30분부터 발권이 가능합니다.</li> -->
					</ul>
				</div>
		</div>
	</div>
<script>
	function deleteLift(){
	}

	$(function(){
		$(document).on("click", ".cancel", function() {				
			var s_account_order = $(this).attr("alt");
			if (!s_account_order) {
				alert("삭제할 데이타를 선택해주세요.");
				return;
			}

			var accountName = "구매건이 취소됩니다. 취소하시겠습니까?";
			var data = {"s_account_order" : s_account_order};
			if (confirm(accountName)) {
				$.ajax({
					url : "/proc/lift_cancle.asp",
					dataType : "text",
					method: "POST",
					data : data,
					success : function(result) {
						if(result=="success"){
							location.reload();
						}else{
							alert(result);
						}
					},
					error : function(status) {
						web.alert("에러가 발생하였습니다.");	
					}
				});		
			}
		});
	});  

</script>

	
	
	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
</html>