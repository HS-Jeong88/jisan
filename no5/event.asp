<!--#include virtual="/conf/config.asp"-->
<!-- #include virtual="/proc/liftEvent/visit_count.asp" -->
<%
		'//모바일기계이면 모바일페이지로 이동
		Call isMobieRedirect()
		eventUseCnt = 0
		liftUseCnt = 0
		gradeCnt = 0
		eventCnt = 0


		// If NullChk(js_id||sns_id) Then
        If NullChk(js_id) And NullChk(Session("sns_id")) Then
			Session("page") =	"/w2/event/lift/event.asp"
			chkLogin = "false"
		Else
			Call SetDB( Conn, rs)
			// sql = "Select mb_name, mb_hp from jsmember where mb_id='"&js_id&"' "
            sql = "Select mb_name, mb_hp from jsmember where (mb_id='" & js_id & "') or (mb_id='" & sns_id & "')"
			Call QueryTwo(sql, mb_name, mb_hp)
			If NullChk(mb_name) Then
				Session("page") =	"/w2/event/lift/event.asp"
				Call ScriptAlert("다시 로그인이 필요합니다.")
				Call ScriptLocation(appMobileLink & "/member/logout.asp")
				Response.end
			End If
			'//이벤트 응모수
			sql = " select count(*) from tEvent_2021_roulette_list  where (mb_id='" & js_id & "') or (mb_id='" & sns_id & "')"
			Call QueryOne(sql, eventCnt)
			eventCnt = CInt(eventCnt)
			sql = " select count(*) from tEvent_2021_roulette_list where (mb_id='"&js_id&"' and graderank is not null) or (mb_id='" & sns_id & "')""
			Call QueryOne(sql, gradeCnt)
			gradeCnt = CInt(gradeCnt)
			Call SetDBNot( Conn, rs)
			chkLogin = "true"		
			'//지산디비조회 응모가능수 체크
			Call SetDBSki(conn, rs)
			'//응모가능수 카운트하기(횟수인지 매수인지에크하기)
			'//리프트 사용횟수
			// sql = " exec xtw_WB_TK_SALES_S5 '"&js_id&"'  "
            If Not IsEmpty(js_id) Then
                idToUse = js_id
            ElseIf Not IsEmpty(sns_id) Then
                idToUse = sns_id
            End If

            If Not IsEmpty(idToUse) Then
            sql = "exec xtw_WB_TK_SALES_S5 '" & idToUse
            
			Call QueryThree(sql, member_id, nouse_qty, liftUseCnt)
			If NullChk(liftUseCnt) Then 
				liftUseCnt = 0
			Else
				liftUseCnt = CInt(liftUseCnt)
			End If
			If js_id = "khs532" Then
				liftUseCnt = 200
			End If
			If js_id = "dbdbwls88" Then
				'liftUseCnt = 50
			End If
			Call SetDBNot(conn, rs)
			'//지산디비조회 응모가능수 체크끝
			eventUseCnt = liftUseCnt - eventCnt
			If eventUseCnt < 0 Then eventUseCnt = 0
		End If
'		If js_id <> "khs532" Then
'			Call ScriptAlert("종료된 이벤트입니다.")
'			Call ScriptLocation("/")
'			Response.end
'		End If
%>
<!doctype html>
<html lang="kr">
<head>
    <!-- #include virtual="/w2/asset/inc/head.asp"-->
	<link rel="stylesheet" type="text/css" href="asset/css/anim.css"/>
	<link rel="stylesheet" type="text/css" href="asset/css/event.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css"/>
</head>
<body class="no_microbn">
	<div class="event_wrap rel">
		<header class="event_header">
            <div class="nav rel">
                <img src="asset/images/event_lift_logo.png" class="logo" alt="로고">
                <ul class="clearfix">
                <% If NullChk(js_id) Or NullChk(sns_id) Then %>
                    <li class="icon1-1"><a href="/w2/member/login.asp">로그인</a></li>
					<li class="icon1-2"><a href="/w2/member/new_join01.asp">회원가입</a></li>	
				<% Else %>					
					<li class="icon2-1"><a href="/w2/member/logout.asp">로그아웃</a></li>	
					<li class="icon2-2"><a href="/w2/member/mypage.asp">마이페이지</a></li>
				<% End If %>
                    <li class="icon3"><a href="/w2/ski/">홈페이지 바로가기</a></li>
                </ul>
            </div>
        </header>
        <div class="event rel">
            <div class="tit rel">
                <img src="asset/images/event_lift_tit.jpg" class="tit_bg bg" alt="">
                <div class="count txt_center white fw700"><%=eventUseCnt%>건</div>
            </div>
            <div class="cont01">
                <div class="rel">
                    <img src="asset/images/event_lift_cont01.jpg" class="bg" alt="">
                    <a href="javascript:void(0)" class="btn btn01">경품 박스 오픈</a>
                    <a href="javascript:void(0)" class="btn btn02">당첨 내역 확인하기</a>
                    <div class="arrow"></div>
                </div>
            </div>
            <!-- 당첨내역 확인하기 -->
            <div class="list hid">
                <div class="list_header rel">
                    <img src="asset/images/event_lift_cont01_list_header.jpg" alt="">
                    <p class="count01 txt_center"><%=eventCnt%>건</p>
                    <p class="count02 txt_center"><%=gradeCnt%>건</p>
                    <p class="count03 txt_center"><%=eventUseCnt%>건</p>
                </div>
                <div class="list_wrap" id="gradeList">
                </div>
            </div>
            <!-- //당첨내역 확인하기 -->
            <div class="cont02 rel">
                <img src="asset/images/event_lift_cont02.jpg" class="bg" alt="">
                <a href="javascript:void(0)" class="btn">경품 지급 방법 및 이벤트 유의사항</a>
            </div>
            <div class="cont03 rel">
                <img src="asset/images/event_lift_cont03.jpg" class="bg" alt="">
                <a href="/w2/reservation/lift/lift01.asp" class="btn">리프트권 구매</a>
            </div>
        </div>
	</div>
    <!-- 팝업 -->
    <div class="pop_wrap"> 
        <!-- 모션  -->
        <div class="popup motion rel">
            <img src="asset/images/event_lift_pop_bg.png" class="bg" alt="">
            <p class="img animated bounceIn"><img src="asset/images/event_lift_giftbox.png" class="bg" alt=""></p>
        </div>
        <!-- //모션 -->
        <!-- 미당첨 -->
        <div class="popup fail rel hid" id="loseDiv">
            <img src="asset/images/event_lift_fail.png" class="" alt="">
            <a href="javascript:void(0)" class="btn close">팝업 닫기</a>
            <a href="javascript:void(0)" class="btn ok">확인</a>
        </div>
        <!-- //미당첨 -->
        <!-- 당첨-아이폰 -->
        <div class="popup get rel hid"  id="winDiv">
            <img id="rst5" src="asset/images/event_lift_fail.png" class="" alt="">
            <a href="javascript:void(0)" class="btn close">팝업 닫기</a>
            <a href="javascript:void(0)" class="btn ok">확인</a>
            <p class="date txt_center fs20" id="rst1">당첨일자: </p>
        </div>
    </div>
    <!-- //팝업 -->
    <!-- 유의사항 -->
    <div class="pop_notice_wrap">
        <p class="txt_center"><img src="asset/images/event_lift_notice_head.jpg" alt=""></p>
        <div class="pop_notice bg_w pb74 rel">
            <a href="javascript:void(0)" class="close_btn"><img src="asset/images/event_lift_close.jpg"></a>
            <h3 class="fs24 pt70 pb20">1. 경품 지급 방법</h3>
            <ul>
                <li class="dash">아이폰13 프로 맥스 / 다이슨 V12 청소기 / 아이패드 미니 / 다이슨 슈퍼소닉 드라이어 / 애플워치7 / 스타벅스 기프티콘 경품 당첨자는 이벤트 종료일로부터 2주일 이내 (2022년 3월 14일)에 당첨자에게 개별 연락 후 경품을 지급해 드립니다.</li>
                <li class="dash">리프트 50%할인권은 홈페이지 리프트 예약 시 사용할 수 있습니다.</li>
                <li class="red3 star">모바일 전송 형태의 경품은 경품 발송일로부터 30일 이내에만 재전송이 가능하며, 경품 교환 및 이용에 대한 유효기간 경과 이후에는 재전송 및 사용이 불가하오니 이 점 착오 없으시기 바랍니다.</li>
            </ul>
            <h3 class="fs24 pt50 pb20">2. 이벤트 참여 유의사항</h3>
            <ul>
                <li class="dash">이벤트 기간 : 2021.12.17(금) ~ 2022.02.27(일)</li>
                <li class="dash">아이폰13 프로 맥스 / 다이슨 V12 청소기 / 아이패드 미니 / 다이슨 슈퍼소닉 드라이어 / 애플워치7 경품에 당첨되면 제세공과금(22%)은 본인 부담입니다.</li>
                <li class="dash">당첨 회원님께서 개인정보의 주소 및 연락처 정보를 정확하게 입력하시지 않은 경우 경품 배송에 문제가 발생할 수 있으며, 이에 대해서 지산리조트에서 책임을 지지 않으므로 항상 개인정보를 최신으로 업데이트 바랍니다.</li>
                <li class="dash">리프트권 미사용시 응모 불가능합니다.</li>
                <li class="dash">이벤트 경품은 당사의 사정에 따라 일부 변경될 수 있습니다.</li>
                <li class="dash">사용된 리프트권 매수만큼 재구매 및 이벤트 참여 가능합니다.</li>
            </ul>
        </div>
    </div>
    <!-- //유의사항 -->
    <div class="fixed_menu">
        <a href="/w2/reservation/lift/lift01.asp"><img src="asset/images/event_lift_fixed_btn.png" alt></a>
    </div>
	<script>
		var chkLogin = "<%=chkLogin%>";
		var appMobileUrl = "<%=appMobileUrl%>";
		var is_rotating = false;
		var is_rotated = false;   
	</script>
	<script type="text/javascript" src="event.js?v=<%=getnowtime()%>"></script>
    <script>
        $(function() {
			/*
			$(".event .cont01 .btn02").click(function() {
                $(".event .list").toggleClass("hid");
                $(".event .cont01 .arrow").toggleClass("on");
            })
            $(".event .cont01 .btn01").click(function() {
                $(".pop_wrap").addClass("on");
                setTimeout(function(){
                    $(".popup.motion").addClass("hid");
                    $(".popup.fail").removeClass("hid");
                }, 2000);   
            })
			$(".popup .btn.close").click(function() {
                $(".pop_wrap").removeClass("on")
            })
            $(".popup .btn.ok").click(function() {
                $(".pop_wrap").removeClass("on")
            })
			*/
            $(".event .cont02 .btn").click(function() {
                $(".pop_notice_wrap").addClass("on");
            })
            $(".pop_notice_wrap .pop_notice .close_btn").click(function() {
                $(".pop_notice_wrap").removeClass("on");
            })
        })
    </script>
</body>
</html>