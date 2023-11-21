<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<%
	On Error resume Next

    Set payReqMap = Session.Contents("PAYREQ_MAP")

  'payreq_crossplatform.asp 에서 세션에 저장했던 파라미터 값이 유효한지 체크
  '세션 유지 시간(로그인 유지시간)을 적당히 유지 하거나 세션을 사용하지 않는 경우 DB처리 하시기 바랍니다.
	if IsNull(payReqMap)then
		response.write "세션이 만료 되었거나 유효하지 않은 요청 입니다."
	end if 
	sns_id = Session("sns_id")

	
Dim id 
		If IsEmpty(js_id) Then
			id = sns_id
		Else
			id = js_id
		End If
	If Err.Number <> 0 Then
		Call SetDB(conn, rs)
		Sql =	" Insert Into	tb_card_returnFail_log( m_id, gu, USER_AGENT, REFERER, LGD_RESPCODE, LGD_RESPMSG, WRITE_DT,  REG_IP ) " & _
					" Values (  '" & id & "','" & conStringToDB(request.servervariables("HTTP_url")) & "', '" & conStringToDB(Request.ServerVariables("HTTP_USER_AGENT")) & "' " &_
					" ,'" & conStringToDB(Request.ServerVariables("HTTP_REFERER")) & "', '" & conStringToDB(Request("LGD_RESPCODE")) & "', '" & conStringToDB(Request("LGD_RESPMSG")) & "', '" & GetNow() & "', '" & selfip() & "' ) "
		Conn.Execute(Sql)
		Call SetDBNot(conn, rs)
%>
	<script>
		alert("결제가 정상적으로 이뤄지지 않았습니다.\n다른 인터넷 브라우져로 다시 시도해주세요.\n감사합니다.");
		parent.location.reload();
	</script>
<%
		Response.end
	End If 

%>

<HTML>
<head>
	<script type="text/javascript">
		function setLGDResult() {
			document.getElementById('LGD_PAYINFO').submit();
		}
	</script>
</head>
<body onload="setLGDResult()">
<%
  LGD_RESPCODE = Trim(Request("LGD_RESPCODE"))
  LGD_RESPMSG  = Trim(Request("LGD_RESPMSG"))
  LGD_PAYKEY	 = ""
  if LGD_RESPCODE = "0000" then
	  LGD_PAYKEY = Trim(Request("LGD_PAYKEY"))
	  payReqMap.item("LGD_RESPCODE") = LGD_RESPCODE
	  payReqMap.item("LGD_RESPMSG")  = LGD_RESPMSG
	  payReqMap.item("LGD_PAYKEY")   = LGD_PAYKEY
%><form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="buy02_card_payres.asp"><%
    For Each eachitem In payReqMap
      response.write "<input type=""hidden"" name="""& eachitem &""" id="""& eachitem &""" value=""" & payReqMap.item(eachitem) & """><br>"
    Next
%></form><%
  }
  else
	  response.write "LGD_RESPCODE:" & LGD_RESPCODE & " ,LGD_RESPMSG:" & LGD_RESPMSG '인증 실패에 대한 처리 로직 추가
  end if
%>
</body>
</html>
