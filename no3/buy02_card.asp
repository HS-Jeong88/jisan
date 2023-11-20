<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<%
	Response.Expires = -1
	Response.Expiresabsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"

	On Error resume Next

	Call SetDB(conn, rs)
	
	
	'공통정보
    CST_PLATFORM               = trim(request("CST_PLATFORM"))       'LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
    CST_MID                    = trim(request("CST_MID"))            '상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
                                                                     '테스트 아이디는 't'를 반드시 제외하고 입력하세요.
    if CST_PLATFORM = "test" then                                    '상점아이디(자동생성)
        LGD_MID = "t" & CST_MID
    else
        LGD_MID = CST_MID
    end if
    LGD_OID                 = trim(request("LGD_OID"))            	'주문번호(상점정의 유니크한 주문번호를 입력하세요)
    LGD_PAYKEY          		= trim(request("LGD_PAYKEY"))     		'구매자명
    
    configPath				   = "c:/lgdacom"						 'LG유플러스에서 제공한 환경파일(/conf/lgdacom.conf, /conf/mall.conf)이 위치한 디렉토리 지정 
    
	Dim xpay
	Dim i, j
	Dim itemName
	
	Set xpay = CreateObject("XPayClientCOM.XPayClient")	
    xpay.Init configPath, CST_PLATFORM    
    xpay.Init_TX(LGD_MID)

    xpay.Set "LGD_TXNAME", "PaymentByKey"
    xpay.Set "LGD_PAYKEY", LGD_PAYKEY 
	    
    if  xpay.TX() then
        '1)결제결과 처리(성공,실패 결과 처리를 하시기 바랍니다.)
'				Response.Write("결제요청이 완료되었습니다. <br>")
'				Response.Write("TX Response_code = " & xpay.resCode & "<br>")
'				Response.Write("TX Response_msg = " & xpay.resMsg & "<p>")
'
'				Response.Write("거래번호 : " & xpay.Response("LGD_TID", 0) & "<br>")
'				Response.Write("상점아이디 : " & xpay.Response("LGD_MID", 0) & "<br>")
'				Response.Write("상점주문번호 : " & xpay.Response("LGD_OID", 0) & "<br>")
'				Response.Write("결제금액 : " & xpay.Response("LGD_AMOUNT", 0) & "<br>")
'				Response.Write("결과코드 : " & xpay.Response("LGD_RESPCODE", 0) & "<br>")
'				Response.Write("결과메세지 : " & xpay.Response("LGD_RESPMSG", 0) & "<p>")
'
'        Response.Write("[결제요청 결과 파라미터]<br>")

				resCode = xpay.resCode

        '아래는 결제요청 결과 파라미터를 모두 찍어 줍니다.
        Dim itemCount
        Dim resCount
        itemCount = xpay.resNameCount
        resCount = xpay.resCount

				LGD_RESPALL = ""
				For i = 0 To itemCount - 1
            itemName = xpay.ResponseName(i)
            LGD_RESPALL = LGD_RESPALL & itemName & "&nbsp:&nbsp"
            For j = 0 To resCount - 1
							LGD_RESPALL = LGD_RESPALL & xpay.Response(itemName, j) & "<br>"
            Next
        Next

				

				s_account_order = xpay.Response("LGD_OID", 0)

				sql = " INSERT INTO tb_ticket_lgdacom " &_
							"		(resCode, resMsg, LGD_TID, LGD_MID, LGD_OID, LGD_AMOUNT, LGD_RESPCODE, LGD_RESPMSG, LGD_RESPALL, jisan_id, reg_ymd, reg_ip) " &_
							"	VALUES('"& conStringToDB(xpay.resCode) &"','"& conStringToDB(xpay.resMsg) &"','"& conStringToDB(xpay.Response("LGD_TID", 0)) &"','"& conStringToDB(xpay.Response("LGD_MID", 0)) &"' " &_
							",'"& conStringToDB(s_account_order) &"' ,'"& conStringToDB(xpay.Response("LGD_AMOUNT", 0)) &"','"& conStringToDB(xpay.Response("LGD_RESPCODE", 0)) &"' " &_
							",'"& conStringToDB(xpay.Response("LGD_RESPMSG", 0)) &"','"& conStringToDB(LGD_RESPALL) &"','"& js_id &"','"& GetNow() &"','"& SelfIP() &"') "
				Conn.Execute( sql )


				'//트랜재션시작
				Conn.BeginTrans
				errCnt = 0	'//에러카운트


        
        if xpay.resCode = "0000" then
        	'최종결제요청 결과 성공 DB처리
        	'//결재방법, 미결제 업데이트
					sql = " update tb_ticket_pending set lgd_tid='" & xpay.Response("LGD_TID", 0) & "', s_account_check='" & xpay.resCode & "',  s_account_dt=getdate() Where s_account_order = '" & s_account_order & " ' "
					Conn.Execute( sql )
					errCnt = errCnt + Conn.Errors.Count

					sql = "exec sp_TicketBuy @s_account_order='" & s_account_order & "' "
					Call QueryTwo(sql, re_rtn, rtn_msg)
					errCnt = errCnt + Conn.Errors.Count

					'최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
        	isDBOK = true 'DB처리 실패시 false로 변경해 주세요.

					If re_rtn <> "success" Or errCnt > 0 Then
						Conn.RollBackTrans			
						isDBOK = False
					Else
						Conn.CommitTrans

						sql = " select top 1 hp, name from tb_ticket_buy where s_account_order='" & s_account_order & "' order by seq asc"
						Call QueryTwo(sql, smshp, smsName)
						'sql = " INSERT INTO smslmsmms.dbo.SC_TRAN " &_
						'	"		(TR_SENDDATE , TR_SENDSTAT , TR_MSGTYPE, TR_PHONE, TR_CALLBACK, TR_MSG, TR_ETC3) " &_
						'	"	VALUES (GetDate(), '0', '0', '" & smshp & "', '031-644-1374', '[지산리조트] " & smsName & "님 23/24시즌 시즌권 구매가완료되었습니다.', 'resort_ticket') "		
						'Conn.Execute( Sql )

						msg = "[지산리조트] 시즌권 구매가 완료되었습니다." & chr(10)
						msg = msg & "-시즌 : "& seasonYear & "시즌권" & chr(10)
						msg = msg & "-구매자명 : "& smsName &"" & chr(10)
						msg = msg & "-결제방법 : 신용카드"

						'//비즈톡보내기or 문자보내기
						template_code = "JSTK01"
						bt_tel = Replace( smshp, "-", "") 
						bt_subject = "[지산리조트]시즌권 구매신청완료"
						bt_msg = msg
						bt_template_code = template_code
						'//기존에 문자는 안나갔었음
						Call biztalkSend(bt_tel, bt_subject, bt_msg, bt_template_code)

					End If
        	
        	if isDBOK then
        	else
        		Response.Write("<p>")
        		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" & xpay.Response("LGD_TID",0) & ",MID:" & xpay.Response("LGD_MID",0) & ",OID:" & xpay.Response("LGD_OID",0) & "]")
        		
                Response.Write("TX Rollback Response_code = " & xpay.resCode & "<br>")
                Response.Write("TX Rollback Response_msg = " & xpay.resMsg & "<p>")

								sql = " insert into tb_ticket_card_faillog (query, resCode, resMsg, s_account_order, errCnt, re_rtn, rtn_msg, jisan_id, reg_ip) " &_
												"	values('"& conStringtoDB(sql) &"','"& xpay.resCode &"','"& xpay.resMsg &"','"& s_account_order &"','"& errCnt &"','"& re_rtn &"','"& rtn_msg &"' " &_
												",'"& js_id &"','"&selfip()&"') "
								Conn.Execute( sql )
								Call SetDBNot(conn,rs)
        		
                if "0000" = xpay.resCode Then
									
                	'Response.Write("자동취소가 정상적으로 완료 되었습니다.<br>")
									Call ScriptAlert("결제가 정상적으로 이뤄지지 않았습니다.\n다시 시도해주세요.")
									Call ScriptLocation("../buy/buy01.asp")
                else
                	Response.Write("자동취소가 정상적으로 처리되지 않았습니다.<br>")
                end If                
								
								Response.end
        	end if            	
        else
        	'결제결제요청 결과 실패 DB처리
 '       	Response.Write("결제결제요청 결과 실패 DB처리하시기 바랍니다." & "<br>")
        end if
    else
        '2)API 요청실패 처리
'				Response.Write("결제요청이 실패하였습니다. <br>")
'				Response.Write("TX Response_code = " & xpay.resCode & "<br>")
'				Response.Write("TX Response_msg = " & xpay.resMsg & "<p>")
'
'				'결제요청 결과 실패 상점 DB처리
'				Response.Write("결제결제요청 결과 실패 DB처리하시기 바랍니다." & "<br>")

				sql = " INSERT INTO tb_ticket_lgdacom " &_
							"		(resCode, resMsg, LGD_TID, LGD_MID, LGD_OID, LGD_AMOUNT, LGD_RESPCODE, LGD_RESPMSG, LGD_RESPALL, jisan_id, reg_ymd, reg_ip) " &_
							"	VALUES('"& conStringToDB(xpay.resCode) &"','"& conStringToDB(xpay.resMsg) &"','"& conStringToDB(xpay.Response("LGD_TID", 0)) &"','"& conStringToDB(xpay.Response("LGD_MID", 0)) &"' " &_
							",'"& conStringToDB(xpay.Response("LGD_OID", 0)) &"' ,'"& conStringToDB(xpay.Response("LGD_AMOUNT", 0)) &"','"& conStringToDB(xpay.Response("LGD_RESPCODE", 0)) &"' " &_
							",'"& conStringToDB(xpay.Response("LGD_RESPMSG", 0)) &"','','"& js_id &"','"& GetNow() &"','"& SelfIP() &"') "
				Conn.Execute( sql )
				errCnt = errCnt + Conn.Errors.Count

    end if 

		Call SetDBNot(conn,rs)

		If resCode <> "0000" Then
			Call ScriptAlert("결제가 정상적으로 이뤄지지 않았습니다.\n다시 시도해주세요.")
			Call ScriptLocation("./buy.asp")
			Resposne.end
		End If
%>
<form name="f" method="post">
<input type="hidden" name="s_account_order" value="<%=s_account_order%>">
</form>
<html>
<head>
<script>
document.f.action = "buy03_end.asp";
document.f.submit();
</script>
</head>
<body>

</body>
</html>
