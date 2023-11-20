<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	'//넘어온값 체크해서 어쩌구저쩌구 해보자
	
	memcode				=	Trim(request("memcode"))		
	imagefile				=	Trim(request("imagefile"))		

	rtnMsg = ""

	'//값체크
	If NullChk(memcode) Or NullChk(imagefile) Then
		Response.write "정상적인 접근이 아닙니다."
		Response.end
	End If



	Call SetDB(conn, rs)

	sql = " Select seq, name, fileok, s_account_check from tb_ticket_buy where memcode='" & memcode & "' "
	Call QueryFour(sql, seq, name, fileok, s_account_check)

	If NullChk(fileok) Then fileok = "N"

	If NullChk(seq) Then
		rtnMsg = "구매내역이 조회되지 않습니다."
	ElseIf fileok = "Y" Then
		rtnMsg = "사진이 확정되어 수정불가합니다."
	Else
		sql = " Update tb_ticket_buy set imagefile='" & imagefile & "'  where memcode='" & memcode & "' "
		Conn.Execute( sql )
	End If

	Call SetDBNot(conn, rs)

	If NullChk(rtnMsg) = False Then
		Response.write rtnMsg
		Response.end
	End	If

	Response.write "success" 

	


%>
