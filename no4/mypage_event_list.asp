<%
	If NullChk(js_id) And NullChk(Session("sns_id")) Then
		Session("page") =	self()
		Call ScriptLocation(agentChk & "/member/login.asp")
		Response.End
	End If

	eventUseCnt = 0
	liftUseCnt = 0
	gradeCnt = 0
	eventCnt = 0

	dim id
	If NullChk(js_id) Then
		id = Session("sns_id")
	Else
		id = js_id
	End If		

'-----------------------<%

   sns_id = Session("sns_id")
   'If NullChk(s_id) Then
   If NullChk(js_id) And NullChk(sns_id) Then
      Session("page") =   self()
      Call ScriptLocation(agentChk & "/member/login.asp")
      Response.End
   End If

   eventUseCnt = 0
   liftUseCnt = 0
   gradeCnt = 0
   eventCnt = 0


'------------------------------------------------------------------------------ DB Open

   '//지산디비조회 응모가능수 체크
   Call SetDBSki(conn, rs)
   '//응모가능수 카운트하기(횟수인지 매수인지에크하기)
   
   '//리프트 사용횟수
   If NullChk(sns_id) Then
      sql = " exec xtw_WB_TK_SALES_S5 '"&js_id&"'  "
   Else
      sql = " exec xtw_WB_TK_SALES_S5 '"&sns_id&"'  "
   Call QueryThree(sql, member_id, nouse_qty, liftUseCnt)
   End If

   If NullChk(liftUseCnt) Then 
      liftUseCnt = 0
   Else
      liftUseCnt = CInt(liftUseCnt)
   End If
   Call SetDBNot(conn, rs)


   Call SetDB( Conn, rs)
   
   '//이벤트 응모수
   If NullChk(sns_id) Then
      sql = " select count(*) from tEvent_2022_event_list  where mb_id='"&js_id&"' "
   Else
      sql = " select count(*) from tEvent_2022_event_list  where mb_id='"&sns_id&"' "
   End If
   
   Call QueryOne(sql, eventCnt)

   eventCnt = CInt(eventCnt)

   '//당첨수
   If NullChk(sns_id) Then
      sql = " select count(*) from tEvent_2022_event_list where mb_id='"&js_id&"' and graderank is not null "
   Else
      sql = " select count(*) from tEvent_2022_event_list where mb_id='"&sns_id&"' and graderank is not null "
   End If
   Call QueryOne(sql, gradeCnt)

   gradeCnt = CInt(gradeCnt)

   If NullChk(sns_id) Then
      Sql =   " select a.seq, a.cpnum, a.winday, a.graderank, b.graderank,  b.gradename, convert(char(16), a.reg_dt, 120) as reg_dt , a.mb_name, a.visitid from tEvent_2022_event_list a left join tEvent_2022_event_grade b on a.p_seq = b.seq where a.mb_id='"&js_id&"' and a.p_seq is not null  order by a.reg_dt desc"   
   Else
      Sql =   " select a.seq, a.cpnum, a.winday, a.graderank, b.graderank,  b.gradename, convert(char(16), a.reg_dt, 120) as reg_dt , a.mb_name, a.visitid from tEvent_2022_event_list a left join tEvent_2022_event_grade b on a.p_seq = b.seq where a.mb_id='"&sns_id&"' and a.p_seq is not null  order by a.reg_dt desc"   
   End If
   
   a_grade = QueryRows(Sql)

   If IsArray(a_grade) Then
      For i = 0 To UBound( a_grade, 2) 
         If a_grade(4, i) = "s1" Then
            sql = " select useyn from tb_coupon_data where cpnum='"&a_grade(1, i)&"' "
            Call QueryOne(sql, useyn)
            If useyn = "y" Then 
               a_grade(3, i) = "사용완료"
            Else
               a_grade(3, i) = "사용가능"
            End If
         Else
            a_grade(3, i) = ""            
         End if
      Next
   End If


   Call SetDBNot (conn, rs)

   
   '//지산디비조회 응모가능수 체크끝

   eventUseCnt = liftUseCnt - eventCnt

   If eventUseCnt < 0 Then eventUseCnt = 0
%>------------------------------------------------------- DB Open

	'//지산디비조회 응모가능수 체크
	Call SetDBSki(conn, rs)
	'//응모가능수 카운트하기(횟수인지 매수인지에크하기)
	
	'//리프트 사용횟수
	sql = " exec xtw_WB_TK_SALES_S5 '"&id&"'  "
	Call QueryThree(sql, member_id, nouse_qty, liftUseCnt)

	If NullChk(liftUseCnt) Then 
		liftUseCnt = 0
	Else
		liftUseCnt = CInt(liftUseCnt)
	End If
	Call SetDBNot(conn, rs)


	Call SetDB( Conn, rs)
	
	'//이벤트 응모수
	sql = " select count(*) from tEvent_2022_event_list  where mb_id='"&id&"' "
	Call QueryOne(sql, eventCnt)

	eventCnt = CInt(eventCnt)

	'//당첨수
	sql = " select count(*) from tEvent_2022_event_list where mb_id='"&id&"' and graderank is not null "
	Call QueryOne(sql, gradeCnt)

	gradeCnt = CInt(gradeCnt)

	Sql =	" select a.seq, a.cpnum, a.winday, a.graderank, b.graderank,  b.gradename, convert(char(16), a.reg_dt, 120) as reg_dt , a.mb_name, a.visitid from tEvent_2022_event_list a left join tEvent_2022_event_grade b on a.p_seq = b.seq where a.mb_id='"&id&"' and a.p_seq is not null  order by a.reg_dt desc"	
	a_grade = QueryRows(Sql)

	If IsArray(a_grade) Then
		For i = 0 To UBound( a_grade, 2) 
			If a_grade(4, i) = "s1" Then
				sql = " select useyn from tb_coupon_data where cpnum='"&a_grade(1, i)&"' "
				Call QueryOne(sql, useyn)
				If useyn = "y" Then 
					a_grade(3, i) = "사용완료"
				Else
					a_grade(3, i) = "사용가능"
				End If
			Else
				a_grade(3, i) = ""				
			End if
		Next
	End If


	Call SetDBNot (conn, rs)

	
	'//지산디비조회 응모가능수 체크끝

	eventUseCnt = liftUseCnt - eventCnt

	If eventUseCnt < 0 Then eventUseCnt = 0
%>