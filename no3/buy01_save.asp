<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자


	'On Error resume Next

	buytype				=	Trim(request("buytype"))	
	userCnt				=	Trim(request("userCnt"))	
	
	'//커플권, 단체(커플) 카운트하기 위한 변수
	coupleSexCntM = 0
	coupleSexCntF = 0

	'//가족권 성인수카운트
	familyCntAdult = 0
	familyCntChild = 0
	familyCntHalf = 0


	'//리턴메세지 설정(오류시
	msg = ""

	'//선택 구매구분(개인권, 가족권등)
	If NullChk(userCnt) Then
		userCnt = 1		
	End If

	'//설문없어져서 선택약관동의 체크용으로 사용함
	poll1 = Trim(request("agree02"))	

	'//사용안함 하단에서 여성요금제/셋팅요금제여부 체크해서 넣어줌
	poll2 = Trim(request("agree03"))	

	If NullChk(buytype) Then
		Call ScriptAlert("정상적인 접근이 아닙니다(save).")
		Response.write "<script>parent.ifrmAlert();</scirpt>"
		Response.end
	End If

'	If buytype="group" Then
'		s_group_name	 = Trim(conStringToDB(request("s_group_name")))	
'		s_group_level  = Trim(conStringToDB(request("s_group_level")))	
'	Else
		s_group_level = "1"
'	End If
	
	Call SetDB(conn, rs)

	'//트랜재션시작
	Conn.BeginTrans
	errCnt = 0	'//에러카운트

	s_sumprice = 0


'	If buytype = "group" Then
'		'//임시데이타도 삭제시 이력남기고 삭제함
'		sql = " exec sp_TicketPending_Del @clummn='s_group_name', @delVal='" & s_group_name & "' "
'		Conn.Execute( sql )
'		errCnt = errCnt + Conn.Errors.Count
'	End If
		

	'//구성원 인서트 작업(기존 완료안한 데이타있으면 삭제후 인서트함)
	For i = 1 To userCnt
		womanSale = "" '//여성할인권 3만원 할인여부체크함
		ySetPrice = "" '//년차고객 가격셋팅요금인지 체크함
		name = Trim(request("name" &i))

		birth = Trim(request("birth" &i))	
		sex = Trim(request("sex" &i))	
		hp1 = Trim(request("hp1" &i))	
		hp2 = Trim(request("hp2" &i))	
		hp3 = Trim(request("hp3" &i))	
		hp = hp1 & "-" & hp2 & "-" & hp3

		tel1 = Trim(request("tel1" &i))	
		tel2 = Trim(request("tel2" &i))	
		tel3 = Trim(request("tel3" &i))	

		tel = tel1 & "-" & tel2 & "-" & tel3
		tel = unescape(tel)

		email = Trim(request("email" &i))	
		imagefile = Trim(URLDecode(unescape(request("imagefile" &i))))	
		memcode = Trim(unescape(request("memcode" &i)))	

		memtype = Trim(request("memtype" &i))	
		yearcha = Trim(request("yearcha" &i))	
		memage = Trim(request("memage" &i))	

		If selfip() = "121.126.92.182" Then
			'Response.write memage
		End If

		s_group_couple = Trim(request("group_couple" &i))	

		selgubun = Trim(unescape(request("selgubun" &i)))

		If InStr(selgubun,"|") > 0 Then
			arr_selgubun = Split(selgubun, "|")

			s_usetime = Trim(arr_selgubun(0))
			If s_usetime = "w1" Then '//1년차 여성권:년차 1년차로 조정해줌"
				s_usetime = "1"
				yearcha = "1"
				womanSale = "y"
			ElseIf s_usetime = "p1" Then '//요금셋팅된 회원 전일
				s_usetime = "1"
				ySetPrice = "y"
			ElseIf s_usetime = "p2" Then '//요금셋팅된 회원 야심
				s_usetime = "2"
				ySetPrice = "y"
			End If
			s_price = Trim(arr_selgubun(1))
		Else
			errCnt = errCnt +1
			msg = "누락된 값이 있습니다.."
			Exit for
		End If

		If NullChk(memcode) Or NullChk(memtype) Or NullChk(yearcha) Or NullChk(memage) Then
			errCnt = errCnt +1
			msg = "누락된 값이 있습니다."
			Exit For
		End if

		'//개인권이 아닌경우 대표자 회원번호와 대표자 표시함
		If buytype = "couple" or buytype = "family" or buytype = "group" Then
			If i = 1 Then  '//첫번째 데이타의 사람이 대표자임
				s_group_memcode = memcode		'//대표자 회원번호
				s_group_position = "Y"			'//대표장
			Else
				s_group_position = "N"			'//구서원
			End If			
		End If

		'//구매권종별 체크(커플일경우, 가족권일경우, 그룹커플일경우 체크

		If buytype="family" Then
			chkAge = fn_ticketSet("age",memcode)
			If chkAge <> "3" Then
				familyCntAdult = familyCntAdult + 1

				'//성인남녀수
				If sex = "1" Then
					coupleSexCntM = coupleSexCntM+1
				Else
					coupleSexCntF = coupleSexCntF+1
				End If

			ElseIf chkAge = "3" Then
				'//가격가져오기(yearcha 1년차로 펑션에서 변경하여 가격가져와서 반값인지 체크함)
				chkprice = fn_memTimePrice(memtype, yearcha, "1", memage, buytype, "", "", s_usetime, memcode)

				'//반값 적용대상자 카운트
				If CDbl(chkprice) = CDbl(s_price) * 2 Then
					familyCntHalf = familyCntHalf + 1
				End If

				
				familyCntChild = familyCntChild + 1
			End If
		End if

		'//합계금액
		s_sumprice = s_sumprice + s_price

		'//가격맞나 체크하기(가족소인은 위에서 체크해서 체크안함)	
		If memcode <> "19850212-1-9787-어쩌구" And memcode <> "19780630-1-7773-송형일" And memcode <> "20131027-1-7773-송민석" And memcode <> "20151013-1-7773-송준하" And memcode <> "19771015-1-5303-권호삼"   Then '//이아이는 예외 코드에서 가격박아줌
			If NullChk(chkprice) Then
				chkprice = fn_memTimePrice(memtype, yearcha, s_group_level, memage, buytype, "", s_group_couple, s_usetime, memcode)
				
				If memtype = "0" Then '//회원이면
					If period = "period1" Then
						clumName = "price_1"
					ElseIf period = "period2" Then
						clumName = "price_2"
					ElseIf period = "period3" Then
						clumName = "price_3"
					End If
					'//설정가있으면 설정가 없으면 40프로(회원도 설정가 가능하도록 해놓음)
					sql2 = " select "&clumName&"_1, "&clumName&"_2 from tb_ticket_member where memcode='"&memcode&"'  and price_1_1 != '' and price_1_1 is not null "
					Call QueryTwo(sql2, setPrice1, setPrice2)
					If NullChk(setPrice1) = False Then
						chkprice = setPrice1
					Else
						chkprice = chkprice * 0.4
					End If
				End If

				If womanSale = "y" Then
					chkprice = chkprice - 20000
				End If

			
				if Trim(chkprice) <> Trim(s_price) Then
					errmsg = errmsg & "파일명 : " & self & " ===> "
					errmsg = errmsg & "에러내용 : " & memtype & "," & yearcha & "," & s_group_level & "," & memage & "," & buytype & "," & "" & "," & s_group_couple & "," & s_usetime & " ===> "
					errmsg = errmsg & "에러 : 회원번호 : " & memcode & "(조회가격 : " & chkprice & "<> 넘어온가격 : " & s_price & ")=>"
					Call fn_LogText(errmsg)
					errCnt = errCnt +1
					msg = "실제 판매가격과 일치하지 않습니다("&name&").\n\n초기화후 다시 입력해주세요."
					Exit for
				End IF

			End If
		End If
		chkprice = ""

		
		'//기존 완료안한 데이타는 삭제후 재 인서트함
		'//임시데이타도 삭제시 이력남김
		sql = " exec sp_TicketPending_Del @clummn='memcode', @delVal='" & memcode & "' "
		Conn.Execute( sql )
		errCnt = errCnt + Conn.Errors.Count
		

		sql = " select count(*) precnt from tb_ticket_buy Where seasonYear='" & seasonYear & "' and memcode = '" & memcode & " ' "	
		Call QueryOne(sql, precnt)

		If precnt > 0 Then
			errCnt = errCnt +1
			msg = "이미 구매한 내역이 있습니다."
			Exit for
		End If

		'//요금체크구분값(특이요금:여성할인/년차셋팅요금)
		If womanSale = "y" Then
			poll2 = "woman"
		ElseIf ySetPrice = "y" Then
			poll2 = "setprice"
		Else
			poll2 = ""			
		End If


		sql = " Insert into tb_ticket_pending "
		sql = sql & "( seasonYear, memcode, memtype, yearcha, name, birth, sex, hp, tel, email, imagefile "
		sql = sql & " , poll1, poll2, login_id, buytype, s_memage, s_usetime " 
		sql = sql & " , s_group_memcode, s_group_name, s_group_level, s_group_position, s_group_couple "
		sql = sql & " , s_price, s_sumprice, reg_ymd, reg_ip ) "
		sql = sql & " Values "
		sql = sql & "('"& seasonYear &"','"& memcode &"','"& memtype &"','"& yearcha &"','" &name &"','"& birth &"','"& sex &"','"& hp &"','"& tel &"','"& email &"','"& imagefile &"' "
		sql = sql & " ,'"& poll1 &"','"& poll2 &"' ,'" & js_id &"','"& buytype &"','"& memage &"','"& s_usetime &"' "
		sql = sql & " ,'"& s_group_memcode &"','"& s_group_name &"' ,'" & s_group_level &"','"& s_group_position &"','"& s_group_couple &"' "
		sql = sql & " ,'"& s_price &"','"& s_price &"','"& GetNow() &"','"& selfip() &"') "

		Conn.Execute( sql )
		errCnt = errCnt + Conn.Errors.Count

	Next

	If errCnt < 1 Then
		
		'//가족권 인원수체크
		'//배종일 가족은 남남성인에 소인임(넘어가도록 해줘야함)
		If buytype="family" Then
			If familyCntAdult < 2 Then
				errCnt = errCnt +1
				msg = "성인 2인이상 구성되어야 합니다."		
			ElseIf familyCntChild < 1 Then
				errCnt = errCnt +1
				msg = "소인이 1인이상 등록하셔야 합니다."
			ElseIf familyCntHalf <> 1 Then
				errCnt = errCnt +1
				msg = "소인1인 반값 적용대상자가 있습니다."
			End If
		End If
		'//가족권 체크끝

	End If


	If errCnt < 1 Then
		If buytype = "family" Then
			'//대표자외 토탈금액 실결제금액 삭제
			sql = " update tb_ticket_pending set s_sumprice = '' where s_group_memcode='" & s_group_memcode& "' "
			Conn.Execute( sql )
			errCnt = errCnt + Conn.Errors.Count

			'//대표자 토탈금액 업데이트(대표자가 대표로 결제하는금액)
			sql = " update tb_ticket_pending set s_sumprice = '" &  s_sumprice & "' where memcode='" & s_group_memcode& "' "
			Conn.Execute( sql )
			errCnt = errCnt + Conn.Errors.Count
		End If
	End If


	'// 에러발생시 롤백시키고 꽝 보여줌
	If errCnt > 0 Then
		Conn.RollBackTrans			
	Else		
		Conn.CommitTrans
	End If	


	Call SetDBNot(conn, rs)

	If errCnt > 0 Then
		If NullChk(msg) Then msg = "다시 시도해주세요"
	Else
		msg = "success"		
	End If


%>
<script type="text/javascript">
	var msg = "<%=msg%>";
	if (msg == "success") {
		parent.saveNextMove();
	} else {
		parent.ifrmAlert();
		alert(msg);
	}
</script>