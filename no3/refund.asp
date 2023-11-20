<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->

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

	<div class="sub ticket refund">
		<!-- "/w2/reservation/ticket/ticket_top.asp" 기존라인바-->
		<!--임시라인바-->
		<div class="top bg_reserv">
			<h2 class="tit ticket_top_tit">시즌권 구매</h2>
			<div class="ticket_ban_wrap">
				<!-- <p class="ticket_ban"><img src="/w2/asset/images/sub/reservation/ticket_ban_0<%=bSimg%>.png" alt=""></p> -->
				<div class="ticket_ban">
					<p class="ban_tit"><%=chaBnrText1%></p>
					<p class="ban_cont"><%=chaBnrText2%><!-- <br /><span class="fs18">※ 현장구매만 가능</span> --></p>
				</div>
			</div>
			<span class="bg"></span>
			<div class="location">
				<ul class="clearfix">
					<li class="first"><a href="/w2/"><img src="/w2/asset/images/common/home_icon.png" alt=""></a></li>
					<li class="arrow">
						<a href="javascript:void(0)">스키</a>
					</li>
					<li class="arrow">
						<a href="javascript:void(0)">예약/구매</a>
					</li>
					<li class="arrow sub_menu">
						<a href="javascript:void(0)" class="mw174">시즌권 구매</a>
						<ul>
							<li><a href="/w2/reservation/golf/member_reserv01.asp">회원제 골프장 예약</a></li>
							<li><a href="/w2/reservation/golf/public_reserv01.asp">퍼블릭 골프장 예약</a></li>
							<!-- <li><a href="/w2/reservation/shuttle/reservation.asp" >셔틀버스 예약</a></li>
							<li><a href="/w2/reservation/lift/lift.asp">리프트권 예약</a></li>
							<li><a href="/w2/reservation/lesson/ski_board01.asp">강습 예약</a></li> -->
							<li><a href="/w2/reservation/condo/condo.asp">콘도 예약</a></li>
							<li class="on"><a href="/w2/reservation/ticket/info.asp">시즌권 구매</a></li> <!-- /w2/reservation/ticket/refund.asp 종료후 링크바꾸기-->
							<!-- <li><a href="/w2/reservation/locker/agree.asp">부츠 보관함 구매</a></li> -->
							<li><a href="/w2/member/mypage.asp">구매&amp;예약확인</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="new_top">
				<div class="new_tit_wrap">
					<p class="new_tit_bar">시즌권 구매</p>
					<p class="new_tit_sub">지산 스키장은 시즌권을 통해 혜택과 함께 지산 스키장을 경험할 수 있습니다</p>
				</div>
			</div>
		</div>
		<!--임시라인바-->
	
		<div class="arrow_tap_wrap">
			<a href="javascript:void(0);" class="tit rel">시즌권 환불 & 각종 신청서</a>
			<ul>
				<li><a href="info.asp">시즌권 안내</a></li><!-- info.asp -->
				<li><a href="buy.asp">시즌권 구매</a></li><!-- buy.asp -->
				<li><a href="photo.asp">사진등록 및 수정</a></li><!-- photo.asp -->
			</ul>
		</div>
		<div class="tab_bg">
			<ul class="tab_wrap w4">
				<li><a href="info.asp"><span>시즌권 안내</span></a></li><!--info.asp" -->
				<li><a href="buy.asp"><span>시즌권 구매</span></a></li><!-- buy.asp -->
				<li><a href="photo.asp"><span>사진 등록 및 수정</span></a></li><!-- photo.asp -->
				<li><a href="javascript: void(0)" class="on"><span>시즌권 환불 &amp;<i class="mt_block"></i> 각종 신청서</span></a></li>
			</ul>
		</div>
		
		
		<div class="inner pt100 pb190">
			<p class="sub_stit pb36 ">신청서 다운로드</p>
			<table class="basic_table">
				<caption>이용시간</caption>
				<colgroup>
					<col style="width:auto">
					<col style="width:23%" class="w38">
				</colgroup>
				<tbody>
					<tr>
						<td>시즌권 환불 신청서</td>
						<td><a href="/w2/asset/file/2324_시즌권_환불_신청서.xlsx" class="brown_btn fs16 fw500 white">환불신청서</a></td>
					</tr>
					<tr>
						<td>시즌권 양도양수 신청서</td>
						<td><a href="/w2/asset/file/2324_시즌권_양도양수_신청서.xlsx" class="brown_btn fs16 fw500 white">양도양수 신청서</a></td>
					</tr>
					<tr>
						<td>위임장</td>
						<td><a href="/w2/asset/file/2324_시즌권_양도양수_위임장.xlsx" class="brown_btn fs16 fw500 white">위임장</a></td>
					</tr>
					<tr>
						<td>개인정보 이용동의서</td>
						<td><a href="/w2/asset/file/2324_개인정보_이용동의서.xlsx" class="brown_btn fs16 fw500 white">개인정보 이용동의서</a></td>
					</tr>
					<tr>
						<td>시즌락카 환불 신청서</td>
						<td><a href="/w2/asset/file/2324_시즌락카_환불_신청서.xlsx" class="brown_btn fs16 fw500 white">환불신청서</a></td>
					</tr>
					<tr>
						<td>23/24 연기신청서</td>
						<td><a href="/w2/asset/file/2324_연기신청서.xlsx" class="brown_btn fs16 fw500 white">23/24 연기신청서</a></td>
					</tr>
					<tr>
						<td>23/24 시즌권 약관</td>
						<td><a href="/w2/asset/file/2324_시즌권_약관.xls" class="brown_btn fs16 fw500 white">23/24 시즌권 약관</a></td>
					</tr>
					<tr>
						<td>23/24 락카 양도양수 신청서</td>
						<td><a href="/w2/asset/file/2324_락카_양도양수_신청서.xlsx" class="brown_btn fs16 fw500 white">양도양수 신청서</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>	

	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
</html>