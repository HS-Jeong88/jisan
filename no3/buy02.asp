<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<!-- #include virtual="/conf/lgxpay/lgdacom/md5.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자
	'//프로세스정리 : pc는 xpay mobile은 smartxpay타야됨
	'//모바일은 페이지이동방식(submit방식)buy_03_returnurlm.asp에서 action값으로 최종완료페이지 buy02_card_payres.asp submit
	'//pc는 iframe방식임 결과 리턴받아서 buy02_card_payres.asp 완료페이지로 넘김

	'On Error resume Next

	memcode				=	Trim(request("memcode1"))		

	If NullChk(memcode) Then
		Call ScriptAlert("정상적인 접근이 아닙니다(03).")
		Call ScriptLocation("/w2/reservation/ticket/buy.asp")
		Response.end
	End If
	

	Call SetDB(conn, rs)

	Dim a_Read(20)
	sql = " select memcode, memtype, yearcha, name, birth, sex, hp, tel, email, imagefile, buytype, s_memage, s_usetime, s_price, s_sumprice, s_group_name, seq, s_group_level " &_
				" from tb_ticket_pending where memcode='" & memcode & "' "
	Call QueryArray( Sql, a_Read, 18)

	memcode			=		conDBToString( A_READ(1), "")
	memtype			=		conDBToString( A_READ(2), "")
	yearcha			=		conDBToString( A_READ(3), "")
	name				=		conDBToString( A_READ(4), "")
	birth				=		conDBToString( A_READ(5), "")
	sex					=		conDBToString( A_READ(6), "")
	hp					=		conDBToString( A_READ(7), "")
	tel					=		conDBToString( A_READ(8), "")
	email				=		conDBToString( A_READ(9), "")
	imagefile		=		conDBToString( A_READ(10), "")
	buytype			=		conDBToString( A_READ(11), "")
	s_memage		=		conDBToString( A_READ(12), "")
	s_usetime		=		conDBToString( A_READ(13), "")
	s_price			=		conDBToString( A_READ(14), "")
	s_sumprice	=		conDBToString( A_READ(15), "")
	s_group_name	=		conDBToString( A_READ(16), "")
	seq						=		conDBToString( A_READ(17), "")
	s_group_level	=		conDBToString( A_READ(18), "")

	If buytype = "personal" Then
		columnName = "memcode"
	Else
		columnName = "s_group_memcode"
	End If

	'//주문번호 생성
	s_account_order		=	Right(GetNow,6)&"-"&Right(birth,4) & Right("00" & seq, 3)
	'//결재방법, 미결제 업데이트
	sql = " update tb_ticket_pending set s_account_order='" & s_account_order & "', mobile_yn='"&mobile_yn&"' Where buytype='" & buytype & "' and " & columnName & " = '" & memcode & " ' "
	Conn.Execute( sql )


	If buytype <> "personal" Then
		'//구성원 가져오기
		sql = " select memcode, buytype, s_group_position, s_usetime, s_price, yearcha, s_memage, s_group_couple " &_
					" from tb_ticket_pending where buytype = '" & buytype & "' and s_group_memcode='" & memcode & "' order by s_group_position desc, memcode asc "
		a_GroupList =	QueryRows(Sql)			
	End If


	Call SetDBNot(conn, rs)

	If NullChk(memcode) Then
		Call ScriptAlert("정상적인 접근이 아닙니다(01).")
		Call ScriptLocation("/reservation/ticket/buy/buy01.asp")
		Response.end	
	End If


	'//결제서비스 공통변수
	CST_PLATFORM               = laxpayTest             'LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
	CST_MID                    = lgxpayID                  '상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
	If NullChk(CST_MID) Then CST_MID = lgxpayID
																																				 '테스트 아이디는 't'를 반드시 제외하고 입력하세요.
	if CST_PLATFORM = "test" then                                          '상점아이디(자동생성)
			LGD_MID = "t" & CST_MID
	else
			LGD_MID = CST_MID
	end if
	LGD_OID                    = s_account_order													 '주문번호(상점정의 유니크한 주문번호를 입력하세요)
	LGD_AMOUNT                 = s_sumprice																 '결제금액("," 를 제외한 결제금액을 입력하세요)
	LGD_MERTKEY                = laxpay_MERTKEY														 '상점MertKey(mertkey는 상점관리자(http://pgweb.uplus.co.kr) -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다')
	LGD_BUYER                  = name																		   '구매자명
	LGD_PRODUCTINFO            = "23/24지산시즌권"													 '상품명
	LGD_BUYEREMAIL             = email																		 '구매자 이메일 
	LGD_TIMESTAMP              = GetNowTimeSecond()												 '타임스탬프
	'LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	
	LGD_ENCODING ="UTF-8"
	LGD_ENCODING_NOTEURL ="UTF-8"
	LGD_ENCODING_RETURNURL ="UTF-8"

	If mobile_yn ="y" Then
		'//모바일버전일경우(/config/lgsxpay : 스마트페이 모바일용샘플)
		
		LGD_CUSTOM_FIRSTPAY        = "SC0010"	'상점정의 초기결제수단
		LGD_PCVIEWYN				= trim(request("LGD_PCVIEWYN"))		 '휴대폰번호 입력 화면 사용 여부(유심칩이 없는 단말기에서 입력-->유심칩이 있는 휴대폰에서 실제 결제)
		LGD_CUSTOM_SKIN       = "SMART_XPAY2"                       '상점정의 결제창 스킨 (red, blue, cyan, green, yellow)
		LGD_CASNOTEURL        = "https://www.jisanresort.co.kr/conf/lgsxpay/cas_noteurl.asp"   '//가상계좌시 사용(현재사용무)
		LGD_RETURNURL			= "https://www.jisanresort.co.kr/w2/reservation/ticket/buy02_returnurlm.asp" ' FOR MANUAL 
		'iOS 연동시 필수
		LGD_MPILOTTEAPPCARDWAPURL	= ""	'롯데앱카드 스키마 등록
			
		'/*
		'* ISP 카드결제 연동을 위한 파라미터(필수)
		'*/
		LGD_KVPMISPWAPURL		= ""
		LGD_KVPMISPCANCELURL    = ""			 
			 
		'/*
		'* 계좌이체 연동을 위한 파라미터(필수)
		'*/
		LGD_MTRANSFERWAPURL 	= ""
		LGD_MTRANSFERCANCELURL 	= ""  
		 
		
		LGD_HASHDATA = md5( LGD_MID & LGD_OID & LGD_AMOUNT & LGD_TIMESTAMP & LGD_MERTKEY )
		LGD_CUSTOM_PROCESSTYPE = "TWOTR"
		'/*
		' *************************************************
		' * 2. MD5 해쉬암호화 (수정하지 마세요) - END
		' *************************************************
		' */
		
		CST_WINDOW_TYPE = "submit"                                              '수정불가
		LGD_WINDOW_TYPE = CST_WINDOW_TYPE
		Set payReqMap = Server.CreateObject("Scripting.Dictionary")
		payReqMap.Add "CST_PLATFORM",                CST_PLATFORM                   '테스트, 서비스 구분
		payReqMap.Add "CST_MID",                     CST_MID                        '상점아이디
		payReqMap.Add "CST_WINDOW_TYPE",             CST_WINDOW_TYPE
		payReqMap.Add "LGD_MID",                     LGD_MID                        '상점아이디
		payReqMap.Add "LGD_OID",                     LGD_OID                        '주문번호
		payReqMap.Add "LGD_BUYER",                   LGD_BUYER                      '구매자
		payReqMap.Add "LGD_PRODUCTINFO",             LGD_PRODUCTINFO                '상품정보
		payReqMap.Add "LGD_AMOUNT",                  LGD_AMOUNT                     '결제금액
		payReqMap.Add "LGD_BUYEREMAIL",              LGD_BUYEREMAIL                 '구매자 이메일
		payReqMap.Add "LGD_CUSTOM_SKIN",             LGD_CUSTOM_SKIN                '결제창 SKIN
		payReqMap.Add "LGD_CUSTOM_PROCESSTYPE",      LGD_CUSTOM_PROCESSTYPE         '트랜잭션 처리방식
		payReqMap.Add "LGD_TIMESTAMP",               LGD_TIMESTAMP                  '타임스탬프
		payReqMap.Add "LGD_HASHDATA",                LGD_HASHDATA                   'MD5 해쉬암호값
		payReqMap.Add "LGD_RETURNURL",   			 LGD_RETURNURL      		    '응답수신페이지
		payReqMap.Add "LGD_ENCODING",   			 LGD_ENCODING      		  
		payReqMap.Add "LGD_ENCODING_NOTEURL",   			 LGD_ENCODING_NOTEURL      		 
		payReqMap.Add "LGD_ENCODING_RETURNURL",   			 LGD_ENCODING_RETURNURL    
		payReqMap.Add "LGD_VERSION",         		 "ASP_Non-ActiveX_SmartXPay"    '버전정보 (삭제하지 마세요)
		payReqMap.Add "LGD_CUSTOM_FIRSTPAY",      	 LGD_CUSTOM_FIRSTPAY			'디폴트 결제수단
		payReqMap.Add "LGD_PCVIEWYN",                LGD_PCVIEWYN			        '휴대폰번호 입력 화면 사용 여부
		payReqMap.Add "LGD_CUSTOM_SWITCHINGTYPE",    "SUBMIT"						'신용카드 카드사 인증 페이지 연동 방식
		
		'iOS 연동시 필수
		payReqMap.add "LGD_MPILOTTEAPPCARDWAPURL"	, LGD_MPILOTTEAPPCARDWAPURL

		'/*
		'****************************************************
		'* 신용카드 ISP(국민/BC)결제에만 적용 - BEGIN 
		'****************************************************
		'*/
		payReqMap.add "LGD_KVPMISPWAPURL"  		 	, LGD_KVPMISPWAPURL 	
		payReqMap.add "LGD_KVPMISPCANCELURL"  		, LGD_KVPMISPCANCELURL 
		
		'/*
		'****************************************************
		'* 신용카드 ISP(국민/BC)결제에만 적용  - END
		'****************************************************
		'*/
			
		'/*
		'****************************************************
		'* 계좌이체 결제에만 적용 - BEGIN 
		'****************************************************
		'*/
		payReqMap.add "LGD_MTRANSFERWAPURL"  		, LGD_MTRANSFERWAPURL 	
		payReqMap.add "LGD_MTRANSFERCANCELURL"  	, LGD_MTRANSFERCANCELURL 
		
		'/*
		'****************************************************
		'* 계좌이체 결제에만 적용  - END
		'****************************************************
		'*/
		
		
		'/*
		'****************************************************
		'* 모바일 OS별 ISP(국민/비씨), 계좌이체 결제 구분 값
		'****************************************************
		'- 안드로이드: A (디폴트)
		'- iOS: N
		'- iOS일 경우, 반드시 N으로 값을 수정
		'*/
		payReqMap.add "LGD_KVPMISPAUTOAPPYN"	, "A"		'// 신용카드 결제 
		payReqMap.add "LGD_MTRANSFERAUTOAPPYN"	, "A"		'// 계좌이체 결제
		
		
		
		'가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다.
		payReqMap.Add "LGD_CASNOTEURL",              LGD_CASNOTEURL                 '가상계좌 NOTEURL
		
		
		
		'수정 불가 ( 인증 후 자동 셋팅 )
		payReqMap.Add "LGD_RESPCODE",                ""
		payReqMap.Add "LGD_RESPMSG",                 ""
		payReqMap.Add "LGD_PAYKEY",                  ""
	Else
		'//pc버전일경우(/config/lgxpay pc용xpay)
    LGD_CUSTOM_SKIN            = "red"                                     '상점정의 결제창 스킨 (red, blue, cyan, green, yellow)
		LGD_CUSTOM_SWITCHINGTYPE   = "IFRAME"																	 '신용카드 카드사 인증 페이지 연동 방식
		LGD_CUSTOM_USABLEPAY       = "SC0010"																	 '디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)     SC0010 :신용 SC0030:계좌이체
    LGD_CASNOTEURL					= "https://www.jisanresort.co.kr/conf/lgsxpay/cas_noteurl.asp"          ' 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다
		LGD_RETURNURL				= "https://www.jisanresort.co.kr/w2/reservation/ticket/buy02_returnurl.asp" ' FOR MANUAL 
		LGD_WINDOW_TYPE           =  "iframe"         '수정불가
    LGD_WINDOW_VER					= "2.5"									   '결제창 버젼정보
    LGD_CUSTOM_PROCESSTYPE     = "TWOTR"                                   '결제 방식 정보 (수정불가)

    

    '인증이후 자동세팅되는 파라미터 입니다.
		LGD_RESPCODE = ""
		LGD_RESPMSG = ""
		LGD_PAYKEY = ""
	
    LGD_HASHDATA = md5( LGD_MID & LGD_OID & LGD_AMOUNT & LGD_TIMESTAMP & LGD_MERTKEY )
    
    '/*
    ' *************************************************
    ' * 2. MD5 해쉬암호화 (수정하지 마세요) - END
    ' *************************************************
    ' */
		Set payReqMap = Server.CreateObject("Scripting.Dictionary")
		payReqMap.Add "CST_PLATFORM",                CST_PLATFORM                   '테스트, 서비스 구분
		payReqMap.Add "CST_MID",                     CST_MID                        '상점아이디
		payReqMap.Add "LGD_WINDOW_TYPE",             LGD_WINDOW_TYPE
		payReqMap.Add "LGD_MID",                     LGD_MID                        '상점아이디
		payReqMap.Add "LGD_OID",                     LGD_OID                        '주문번호
		payReqMap.Add "LGD_BUYER",                   LGD_BUYER                      '구매자
		payReqMap.Add "LGD_PRODUCTINFO",             LGD_PRODUCTINFO                '상품정보
		payReqMap.Add "LGD_AMOUNT",                  LGD_AMOUNT                     '결제금액
		payReqMap.Add "LGD_BUYEREMAIL",              LGD_BUYEREMAIL                 '구매자 이메일
		payReqMap.Add "LGD_CUSTOM_SKIN",             LGD_CUSTOM_SKIN                '결제창 SKIN
		payReqMap.Add "LGD_CUSTOM_PROCESSTYPE",      LGD_CUSTOM_PROCESSTYPE         '트랜잭션 처리방식
		payReqMap.Add "LGD_TIMESTAMP",               LGD_TIMESTAMP                  '타임스탬프
		payReqMap.Add "LGD_HASHDATA",                LGD_HASHDATA                   'MD5 해쉬암호값
		payReqMap.Add "LGD_RETURNURL",   			   LGD_RETURNURL      		      '응답수신페이지
		payReqMap.Add "LGD_ENCODING",   			 LGD_ENCODING      		  
		payReqMap.Add "LGD_ENCODING_NOTEURL",   			 LGD_ENCODING_NOTEURL      		 
		payReqMap.Add "LGD_ENCODING_RETURNURL",   			 LGD_ENCODING_RETURNURL  
		payReqMap.Add "LGD_VERSION",         		   "ASP_2.5"                      '버전정보 (삭제하지 마세요)
		payReqMap.Add "LGD_CUSTOM_USABLEPAY",         LGD_CUSTOM_USABLEPAY     	  '결제수단 정보
		payReqMap.Add "LGD_CUSTOM_SWITCHINGTYPE",    "IFRAME"					      '신용카드 카드사 인증 페이지 연동 방식
		payReqMap.Add "LGD_CASNOTEURL",              LGD_CASNOTEURL                 '가상계좌 할당/ 입금시 통보를 받게되는 page URL
		payReqMap.Add "LGD_CUSTOM_ROLLBACK",         ""				   	   		  '비동기 ISP에서 트랜잭션 처리여부
		payReqMap.Add "LGD_WINDOW_VER",  		       LGD_WINDOW_VER			      '비동기 ISP(ex. 안드로이드) 승인결과를 받는 URL						
  
		'****************************************************
		'* 안드로이드폰 신용카드 ISP(국민/BC)결제에만 적용 (끝) *
		'****************************************************

		'수정 불가 ( 인증 후 자동 셋팅 )
		payReqMap.Add "LGD_RESPCODE",                ""
		payReqMap.Add "LGD_RESPMSG",                 ""
		payReqMap.Add "LGD_PAYKEY",                  ""
	End If

	set Session("PAYREQ_MAP") = payReqMap


%>
<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head_reaction.asp"-->
<%
     protocol = "http"
     If request.serverVariables("SERVER_PORT") = "443" Then protocol = "https"

     if CST_PLATFORM = "test" then
     	port = "7080"
     	If request.serverVariables("SERVER_PORT") = "443" Then port = "7443"
        Response.Write "<script language='javascript' src='"& protocol &"://xpay.lgdacom.net:" & port & "/xpay/js/xpay_crossplatform.js'  type='text/javascript' ></script>"
     else
        Response.Write "<script language='javascript' src='"& protocol &"://xpay.lgdacom.net/xpay/js/xpay_crossplatform.js' type='text/javascript'></script>"
     end if
%>
<script type="text/javascript">

/*
* 수정불가.
*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	

/*
* 수정불가
*/
function launchCrossPlatform(){
<% If mobile_yn ="y" Then%>
			lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type);
<% Else %> 
      lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
<% End If %>
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
		     document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			 document.getElementById("LGD_PAYINFO").target = "_self";
			 document.getElementById("LGD_PAYINFO").action = "buy02_card_payres.asp";
			 document.getElementById("LGD_PAYINFO").submit();
		
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

//-->
</script>
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

	<div class="sub ticket buy01 buy02">
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
			<div class="txt_center">
				<ul class="step_wrap fs16">
					<li class="step01">구매하기</li>
					<li class="on step02">결제하기</li>
					<li class="step03">결제완료</li>
				</ul>
			</div>
			
			<p class="sub_tit pb36 pt90">신청내용 확인/결제하기</p>
			<div class="cont03">
				<div class="clearfix">
					<div class="profile tbpc_f_left">
						<div class="box" style="padding-top:0px">
							<% If NullChk(imagefile) = False Then %>
							<img src="/downloads/ticket/upload/<%=imagefile%>" />
							<% Else %>
								<img src="/w2/asset/images/sub/reservation/photo_sample.jpg" alt="업로드이미지">
							<% End If %>
						</div>
						
					</div>
					<table class="basic_table tbpc_f_left">
						<colgroup>
							<col style="width:27%">
							<col style="width:auto">
						</colgroup>
						<caption>개인권 사용자정보</caption>
							<tbody>
							<tr>
								<th scope="row">사용자명</th>
								<td scope="row"><p class="fs17 gray"><%=name%> / <%=memcode%></p></td>
							</tr>
							<tr>
								<th scope="row">생년월일/성별</th>
								<td scope="row"><p class="fs17 gray"><%=putDate(birth, "YYYY-MM-DD")%> / <%=fn_sexName(sex)%></p></td>
							</tr>
							<tr>
								<th scope="row">휴대전화 번호</th>
								<td scope="row"><p class="fs17 gray"><%=hp%></p></td>
							</tr>
							
							<tr>
								<th scope="row">이메일</th>
								<td scope="row"><p class="fs17 gray"><%=email%></p></td>
							</tr>
							<tr>
								<th scope="row">회원번호</th>
								<td scope="row"><p class="fs17 gray"><%=memcode%></p></td>
							</tr>
							<tr>
								<th scope="row">권종선택</th>
								<td scope="row">
									<p class="fs17 gray">
									<% 
										tmpMemtype = memtype
										If memtype = "6" And s_usetime <> "1" Then 
											tmpMemtype = "1"
										End If
									%>											
									<% If s_usetime="1" or s_usetime="2" Then %>
									<%=fn_memtypeName(tmpMemtype)%><%If tmpMemtype = "1" And yearcha <> "1" Then Response.write "(" & yearcha & "년차) /" End If %> 
									<% End If %>
									<%=fn_ageName(s_memage)%> / <%=fn_useTimeName(s_usetime)%>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
<%	If isArray(a_GroupList) Then	%>
			<div class="buy02_pay inner">
	
				<p class="sub_stit pb36 pt60">구성원</p>
				<div class="org">
					<table class="org_table02 basic_table txt_center">
					<caption>구매내역 목록입니다.</caption>
					<colgroup>
						<col style="width: auto"/>
					<% If memtype = "8" Then %>								
						<col style="width: 25%"/>
						<col style="width: 16%"/>
					<% Else %>

						<col style="width: 16%"/>
						<col style="width: 7.8%"/>
						<col style="width: 16.5%"/>
					<% End If %>
						<col style="width: 16.5%"/>
					</colgroup>
					<thead>
						<tr>
						<th>회원번호</th>
					<% If memtype = "8" Then %>
						<th>구분</th>
						<th>권종</th>
					<% Else %>
						<th>구분</th>
						<th>권종</th>
						<th>금액</th>
					<% End If %>
						<th>대/소인</th>
						</tr>
					</thead>
					<tbody>
<%		For ai = 0 To UBound( a_GroupList, 2)	%>
						<tr>
							<td><%=a_GroupList(0, ai)%></td>
							<% If memtype = "8" Then %>
							<td><%=fn_buytypeName(a_GroupList(1, ai))%> (<% If a_GroupList(2, ai) ="Y" Then %>대표<% Else %>구성원<% End If %>)</td>
							<td><%=fn_useTimeName(a_GroupList(3, ai))%></td>					
							<% Else %>
							<td><%=fn_buytypeName(a_GroupList(1, ai))%> (<% If a_GroupList(2, ai) ="Y" Then %>대표<% Else %>구성원<% End If %>)</td>
							<td><%=fn_useTimeName(a_GroupList(3, ai))%></td>					
							<td><%=FormatNumber(a_GroupList(4, ai),0)%>원</td>
							<% End If %>
							<td><%=fn_ageName(a_GroupList(6, ai))%><% If a_GroupList(5, ai) <> "1" Then Response.write " ["&a_GroupList(5, ai) & "년차]" End If %></td>
						</tr>
<%		Next	%>	
				
					</tbody>			
					</table>
				</div>
			</div>
<% End If %>


			
			<p class="sub_tit pb36 pt90">요금 및 결제 정보</p>
			<div class="cont02">
				<table class="basic_table">
				<form method="post" name ="LGD_PAYINFO" id="LGD_PAYINFO" action="buy02_card_payres.asp">
					<input type="hidden" name="memcode" id="memcode" value="<%=memcode%>">
					<input type="hidden" name="buytype" id="buytype" value="<%=buytype%>">
					<caption>요금 및 결제 정보</caption>
					<colgroup>
						<col style="width:50%">
						<col style="width:50%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" class="bg_gray">총요금</th>
							<td class="bg_gray price"><%=FormatNumber(s_sumprice,0)%>원</td>
						</tr>
						<!-- <tr>
							<th scope="row">배송여부</th>
							<td>
								<p class="fs16 fw300 gray"><input type="radio" name="s_deliver" id="deliver1" class="deliver" value="1" data-valid="notnull" data-alert="배송방법"><label for="">현장수령</label></p>
								<p class="fs16 fw300 gray"><input type="radio" name="s_deliver" id="deliver2" class="deliver" value="2"><label for="">우편배송</label></p>
							</td>
						</tr> -->
						<tr id="addrTr" style="display:none">
							<th scope="row">주소</th>
							<td>
								<div class="fs16 fw300 gray address">
									<p class="search_wrap mb10"><input type="text" title="주소" class="basic_input" name="s_post" id="s_post"><span class="search_btn fs15" onclick="sample6_execDaumPostcode()" >주소지 검색</span></p>
									<p class="mb10"><input type="text"  class="basic_input" title="주소" name="s_addr1" id="s_addr1"  data-valid="notnull" data-alert="주소" readonly></p>
									<p class="mb10"><input type="text"  class="basic_input" title="주소" name="s_addr2" id="s_addr2"  data-valid="notnull" data-alert="주소"></p>

									<!-- 
										<p class="buy_mb9 "><input type="text" title="주소" class="basic_input" name="s_post" id="s_post"  style="width:70px" ><span class="btn_buy search_btn" onclick="sample6_execDaumPostcode()" >주소지 검색</span></p>
										<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
										<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
										</div>
										<p class="buy_mb9"><input type="text"  class="basic_input" title="주소" name="s_addr1" id="s_addr1"  data-valid="notnull" data-alert="주소" readonly></p>
										
										<p><input type="text"  class="basic_input" title="주소" name="s_addr2" id="s_addr2"  data-valid="notnull" data-alert="주소" >	</p>
									-->
								</div>
								
							</td>
						</tr>
						<tr>
							<th scope="row">결제방법</th>
							<td>
								<p class="fs16 fw300 gray"><input type="radio" name="s_account_method" id="pay1" value="1" data-valid="notnull" data-alert="결제방법"><label for="">신용카드</label></p>
								<p class="fs16 fw300 gray"><input type="radio" name="s_account_method" id="pay3" value="3"><label for="">무통장입금</label></p>
							</td>
						</tr>
						<%
								For Each eachitem In payReqMap
									response.write "<input type=""hidden"" name="""& eachitem &""" id="""& eachitem &""" value=""" & payReqMap.item(eachitem) & """>"
								Next
						%>		
					</tbody>
				</table>
			</div>

			
			<div class="txt_center mt40">
				<button type="button" class="brown_btn fs18 fw600 white mr15" onclick="save();"  >결제</button>
				<button type="button" class="white_btn fs18 fw600 brown" onclick="location.href='buy.asp'">취소</button>
			</div>
		</div>
	</div>	


	<script>
	
	</script>

	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body> 
<script>
	var form = document.getElementById("LGD_PAYINFO");
	function save() {
		if (web.formValidation(form)){		
			var s_account_method = $('input[name="s_account_method"]:checked').val();
			var s_deliver = $('input[name="s_deliver"]:checked').val();
			//form.action = "buy_account_save.asp";
			//form.submit();
			var params = $("#LGD_PAYINFO").serialize();
			$.ajax({
				url : "buy02_ajax.asp",
				dataType : "text",
				method: "POST",
				data : {"memcode":escape($("#memcode").val()),"buytype":$("#buytype").val(),"s_account_method":s_account_method,"s_deliver":s_deliver,"s_post":escape($("#s_post").val()),"s_addr1":escape($("#s_addr1").val()),"s_addr2":escape($("#s_addr2").val())},
				success : function(result) {
					if(result=="success"){	
						if(s_account_method =="1"){
							launchCrossPlatform();
						} else {
							form.action = "buy03_end.asp";
							form.submit();							
						}

					}else{
						web.alert(result);
					}
				},
				error : function(status) {
					web.alert("에러가 발생하였습니다.");	
				}
			});
		}
	}

	$(function(){
		$("body").on("click",".deliver",function(){
			var deliver = $(this).val();
			if (deliver =="2")	{
				$("#addrTr").show();
			} else {
				$("#addrTr").hide();
			}
		})
	});
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" charset="UTF-8"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("s_addr1").value = extraAddr;
                
                } else {
                    document.getElementById("s_addr1").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('s_post').value = data.zonecode;
                document.getElementById("s_addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("s_addr2").focus();
            }
        }).open();
    }
</script>
</html>