<!-- #include virtual="/conf/Config.asp" -->
<!-- #include virtual="/proc/mypage_event_list.asp" -->
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

    <div class="sub mypage event_list">
        <div class="top bg_mypage">
			<!-- <div class="inset">
				<h2 class="tit">이벤트 내역 조회</h2>
			</div> -->
			<span class="bg"></span>
			<div class="location">
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
						<a href="javascript:void(0)" class="mw143">이벤트 내역 조회</a>
						<ul>
							<li><a href="/w2/member/mypage/golf01.asp">회원제 예약 조회</a></li>
							<li><a href="/w2/member/mypage/golf02.asp">퍼블릭 예약 조회</a></li>
							<li><a href="/w2/member/mypage/golf_score.asp">스코어 조회</a></li>
							<li><a href="/w2/member/mypage/shuttle_list.asp">셔틀버스 예약</a></li>
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
					<p class="new_tit_bar">이벤트 내역 조회</p>
					<p class="new_tit_sub">지산 리조트는 누구나 안전하고 쾌적하게 생의 활력을 충전할 수 있는<br />서비스 구현을 위해 노력하고 있습니다</p>
				</div>
			</div>
		</div>
        <div class="tab_bg">
            <ul class="tab_wrap w2">
                <li><a href="/w2/member/mypage/lift_list.asp">리프트/장비 렌탈 예약 조회</a></li>
                <li><a href="/w2/member/mypage/event_list.asp" class="on">이벤트 내역 조회</a></li>
            </ul>
        </div>
        <div class="inner pt100 pb143">
            <div class="pt10 rel">
                <table class="mypage_table txt_center">
                    <colgroup>
                        <col style="width: 33.3%;">
                        <col style="width: 33.3%;">
                        <col style="width: 33.3%;">
                    </colgroup>
                    <tr>
                        <th class="bg_brown white no_after br1">누적 응모 수</th>
                        <th class="bg_brown white no_after br1">당첨 수</th>
                        <th class="bg_brown white no_after">응모 가능 수</th>
                    </tr>
                    <tr>
                        <td class="br1"><%=eventCnt%>건</td>
                        <td class="br1"><%=gradeCnt%>건</td>
                        <td><%=eventUseCnt%>건</td>
                    </tr>
                </table>
								<!-- <ul class="pt25">
									<li class="dot hyphen gray6 fs18">리프트권 미 사용 후 결제 취소 시에는 상품 당첨이 취소됩니다.</li>
									<li class="dot hyphen gray6 fs18">리프트권은 구매 후 30일이 경과하면 사용하실 수 없으며 또한 이벤트 응모도 불가능하므로, 해당 기간 내에 이용해 주시기 바랍니다.</li>
								</ul> -->
								<!-- <div class="fs30 brown pt60 pb20">이벤트 내역 조회</div>
											<table class="mypage_table lift">
												<caption>결제 상태 구분</caption>    
												<colgroup>
													<col style="width: 15%;">
													<col style="width: auto;">
												</colgroup>
												<tr>
													<th class="br1">결제 상태 구분</th>
													<td>
														<label>
															<input type="radio" name="reserv_type" value="all" checked>
															전체
														</label>
														<label>
															<input type="radio" name="reserv_type" value="y">
															당첨
														</label>
														<label>
															<input type="radio" name="reserv_type" value="n">
															미 당첨
														</label>
														<label>
															<input type="radio" name="reserv_type" value="cancel">
															당첨 취소 건
														</label>
													</td>
												</tr>
											</table>
											<table class="mypage_table txt_center">
												<caption>이벤트 내역 조회</caption>
												<colgroup>
													<col style="width:12.5%">
													<col style="width:12.5%">
													<col style="width:12.5%">
													<col style="width:12.5%">
													<col style="width:12.5%">					
													<col style="width:12.5%">
													<col style="width:12.5%">
													<col style="width:12.5%">
												</colgroup>
												<thead>
													<tr>
														<th>응모 날짜</th>
														<th>응모 건수</th>
														<th>당첨 여부</th>
														<th>당첨 상품</th>
														<th>상품 사용 내역</th>
														<th>주문번호</th>
														<th>리프트 권종</th>
														<th>결제 금액</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td colspan="8">이벤트 당첨 내역이 없습니다.</td>
													</tr>
												</tbody>
											</table>
										</div>
										-->
        			</div>
        	</div>
        </div>
    </div>
	


