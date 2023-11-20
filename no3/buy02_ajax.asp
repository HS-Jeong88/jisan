<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자

	'On Error resume Next

	memcode						=	Trim(unescape(request("memcode")))		
	buytype						=	Trim(request("buytype"))		
	s_account_method	= Trim(request("s_account_method"))	

	s_deliver = Trim(unescape(request("s_deliver")))	
	If s_deliver ="2" Then
		s_post	= Trim(unescape(request("s_post")))			
		s_addr1	= Trim(unescape(request("s_addr1")))		
		s_addr2	= Trim(unescape(request("s_addr2")))
	End If


	Call SetDB(conn, rs)

	Dim a_Read(10)

	sql = "Select seq, birth, buytype, name, s_sumprice, email, s_account_order, hp From tb_ticket_pending Where buytype='" & buytype & "' and memcode = '" & memcode & " '"
	Call QueryArray( Sql, a_Read, 8)

	seq					= a_Read(1)
	birth				= a_Read(2)
	r_buytype		= a_Read(3)
	name				= a_Read(4)
	s_sumprice	= a_Read(5)
	email				= a_Read(6)
	s_account_order				= a_Read(7)
	hp				= a_Read(8)

	If NullChk(seq) Then
		Call SetDBNot(conn, rs)
		Response.write "조회되는 데이타가 없습니다."
		Response.end
	End If

	If r_buytype <> buytype Then
		Call SetDBNot(conn, rs)
		Response.write "구매내역이 일치하지 않습니다."
		Response.end
	End If


	'//트랜재션시작
	Conn.BeginTrans
	errCnt = 0	'//에러카운트

	If buytype = "personal" Then
		columnName = "memcode"
	Else
		columnName = "s_group_memcode"
	End If

	

	sql = " select count(*) precnt from tb_ticket_buy Where seasonYear='" & seasonYear & "' and memcode = '" & memcode & " ' "	


	Call QueryOne(sql, precnt)
	errCnt = errCnt + Conn.Errors.Count

	If precnt > 0 Then
		errCnt = errCnt + 1
	Else
		'//결재방법, 미결제 업데이트
		sql = " update tb_ticket_pending set s_account_method='" & s_account_method & "' , s_account_check = '0', s_post = '" & s_post & "', s_addr1 = '" & s_addr1 & "', s_addr2 = '" & s_addr2 & "' Where buytype='" & buytype & "' and " & columnName & " = '" & memcode & " ' "
		Conn.Execute( sql )
		errCnt = errCnt + Conn.Errors.Count


		'//무통장이면 구매완료 테이블로 이동시키고 삭제처리함
		If s_account_method = "3" Then
			'//구매테이블로 이동하고 임시테이블에서 삭제함
			sql = "exec sp_TicketBuy @s_account_order='" & s_account_order & "' "
			Call QueryTwo(sql, re_rtn, rtn_msg)
			errCnt = errCnt + Conn.Errors.Count

			If re_rtn = "error" Then
				errCnt = errCnt + 1
			End If

			smshp = hp
			smsName = name
			'//문자보내기
			'sql = " INSERT INTO smslmsmms.dbo.SC_TRAN " &_
			'	"		(TR_SENDDATE , TR_SENDSTAT , TR_MSGTYPE, TR_PHONE, TR_CALLBACK, TR_MSG, TR_ETC3) " &_
			'	"	VALUES (GetDate(), '0', '0', '" & smshp & "', '031-644-1374', '[지산리조트] " & smsName & "님 시즌권신청완료. 입금계좌안내[지산리조트(주)/농협/233060-51-030280]', 'resort_ticket') "		
			'Conn.Execute( Sql )
			'//알림톡보내기

'			msg = "[지산리조트] 시즌권 구매가 완료되었습니다." & chr(10)
'			msg = msg & "-시즌 : "& seasonYear & "시즌권" & chr(10)
'			msg = msg & "-구매자명 : "& smsName &"" & chr(10)
'			msg = msg & "-결제방법 : 무통장" & chr(10)
'			msg = msg & "-입금계좌 : 지산리조트(주)/농협/233060-51-030280"


			msg = "[지산리조트] 시즌권 구매가 완료되었습니다." & chr(10)
			msg = msg & "-시즌 : "& seasonYear & "시즌권" & chr(10)
			msg = msg & "-구매자명 : "& smsName &"" & chr(10)
			msg = msg & "-결제방법 : 무통장(차수별 마감일까지 입금)" & chr(10)
			msg = msg & "-입금계좌 : 지산리조트(주)/농협/233060-51-030280"  & chr(10)
			msg = msg & "*입금시 : 성명 생년월일(앞자리) 필히 기재"


			'//비즈톡보내기or 문자보내기
			'template_code = "JSTK02"
			template_code = "JSTK04"
			bt_tel = Replace( smshp, "-", "") 
			bt_subject = "[지산리조트]시즌권 구매신청완료"
			bt_msg = msg
			bt_template_code = template_code

			If selfip() <> "" then
				Call biztalkSend(bt_tel, bt_subject, bt_msg, bt_template_code)
			End if


			'//구매완료 페이지
			returnUrl = "buy03_end.asp"
		ElseIf s_account_method ="1" Then
			LGD_CUSTOM_USABLEPAY = "SC0010"
			'//신용카드 결제페이지로 이동
			returnUrl = "buy_03_card.asp"
		ElseIf s_account_method ="2" Then
			LGD_CUSTOM_USABLEPAY = "SC0030"
			'//신용카드 결제페이지로 이동
			returnUrl = "buy_03_card.asp"
		End If
	End If

	
	'// 에러발생시 롤백시
	If errCnt > 0 Or Err.Number <> 0 Then
		Conn.RollBackTrans		
		errmsg = errmsg & "파일명 : " & self & " ===> "
		errmsg = errmsg & "에러내용 : " & Err.Description & "(" & Err.Number & ")=>"
		errmsg = errmsg & "프로시져에러 : 주문번호 : " & s_account_order & "(" & rtn_msg & ")=>"
		Call fn_LogText(errmsg)
		Response.end
	Else		
		Conn.CommitTrans
	End If	

	Call SetDBNot(conn, rs)

	msg = "success"

	If precnt > 0 Then
		msg = "이미 구매내역이 있습니다."
	End If

	If errCnt > 0 Then
		msg = "다시 시도해주세요."
	End If

	Response.write msg
%>