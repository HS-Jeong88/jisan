<%
		Dim pricep1(15, 4)	'//정상요금
		Dim pricep2(6, 3)	'//단체요금
		Dim pricep3(13, 4) '//플러스요금
		Dim a_pRead(30)

		Call SetDB(conn, rs)

		'//설정가져오기
		Sql = " select * from tb_ticket_set "
		Call QueryArray( Sql, a_pRead, 28)
		period_ymd_start1			= conDBToString(a_pRead(1), "")
		period_ymd_end1				= conDBToString(a_pRead(2), "")
		period_time_start1		= conDBToString(a_pRead(3), "")
		period_time_end1		  = conDBToString(a_pRead(4), "")
		period_ymd_start2			= conDBToString(a_pRead(5), "")
		period_ymd_end2				= conDBToString(a_pRead(6), "")
		period_time_start2		= conDBToString(a_pRead(7), "")
		period_time_end2			= conDBToString(a_pRead(8), "")
		period_ymd_start3			= conDBToString(a_pRead(9), "")
		period_ymd_end3				= conDBToString(a_pRead(10), "")
		period_time_start3		= conDBToString(a_pRead(11), "")
		period_time_end3			= conDBToString(a_pRead(12), "")
		teen_ymd_start				= conDBToString(a_pRead(13), "")
		teen_ymd_end					= conDBToString(a_pRead(14), "")
		child_ymd_start				= conDBToString(a_pRead(15), "")
		child_ymd_end					= conDBToString(a_pRead(16), "")
		couple_ymd_start			= conDBToString(a_pRead(17), "")
		couple_ymd_end				= conDBToString(a_pRead(18), "")

		group_ymd_start1			= conDBToString(a_pRead(19), "")
		group_ymd_end1				= conDBToString(a_pRead(20), "")
		group_time_start1			= conDBToString(a_pRead(21), "")
		group_time_end1				= conDBToString(a_pRead(22), "")
		group_ymd_start2			= conDBToString(a_pRead(23), "")
		group_ymd_end2				= conDBToString(a_pRead(24), "")
		group_time_start2			= conDBToString(a_pRead(25), "")
		group_time_end2				= conDBToString(a_pRead(26), "")

		price_notice1					= a_pRead(27)
		price_notice2					= a_pRead(28)
		price_notice1					= Replace( price_notice1, Chr(10), "<br />" )
		price_notice2				  = Replace( price_notice2, Chr(10), "<br />" )


		
		'//동호회단체요금
		Sql = " select * from ( " &_
					"		Select yearcha, price_1, price_2, bigo, memtype+members+age+usetime as orderby from tb_ticket_price where memtype='2' or memtype='3' or memtype='4' " &_
					"	) c order by CAST(orderby AS int) "
		pricepList = QueryRows( Sql)

		If isArray(pricepList) Then
				For ci = 0 To UBound( pricepList, 2)
					pricep2(ci+1, 1) = pricepList(1, ci)
					pricep2(ci+1, 2) = pricepList(2, ci)
					pricep2(ci+1, 3) = pricepList(3, ci)
				Next
		End If


		'//정상요금 가져오기(권종+대청소 순으로)
		Sql = " select * from ( " &_
					"		Select yearcha, price_1, price_2, price_3, price_4, usetime+age as orderby, memo from tb_ticket_price where memtype='1' and yearcha='1' and members='1'  " &_
					"	) c order by CAST(orderby AS int) "
		pricepList = QueryRows( Sql)

		If isArray(pricepList) Then
				For ci = 0 To UBound( pricepList, 2)
					If NullChk(Replace(pricepList(1, ci)," ","")) Then pricepList(1, ci) = 0
					If NullChk(Replace(pricepList(2, ci)," ","")) Then pricepList(2, ci) = 0
					If NullChk(Replace(pricepList(3, ci)," ","")) Then pricepList(3, ci) = 0
					If NullChk(Replace(pricepList(4, ci)," ","")) Then pricepList(4, ci) = 0
					pricep1(ci+1, 1) = pricepList(1, ci)
					pricep1(ci+1, 2) = pricepList(2, ci)
					pricep1(ci+1, 3) = pricepList(3, ci)
					pricep1(ci+1, 4) = pricepList(4, ci)
				Next
		End If

		'//PLUS요금 가져오기(가족권은 동호회/년차등으로 해서 고정금액이 아니라서 코딩으로 박혀져있음)
		Sql = " select yearcha, price_1, price_2, price_3, price_4, usetime+age as orderby, memo from tb_ticket_price where memtype=8 order by CAST(age AS int)  asc "
		pricepList = QueryRows( Sql)

		If isArray(pricepList) Then
				For ci = 0 To UBound( pricepList, 2)
					If NullChk(Replace(pricepList(1, ci)," ","")) Then pricepList(1, ci) = 0
					If NullChk(Replace(pricepList(2, ci)," ","")) Then pricepList(2, ci) = 0
					If NullChk(Replace(pricepList(3, ci)," ","")) Then pricepList(3, ci) = 0
					If NullChk(Replace(pricepList(4, ci)," ","")) Then pricepList(4, ci) = 0
					pricep3(ci+1, 1) = pricepList(1, ci)
					pricep3(ci+1, 2) = pricepList(2, ci)
					pricep3(ci+1, 3) = pricepList(3, ci)
					pricep3(ci+1, 4) = pricepList(4, ci)
				Next
		End If

		Dim charge_family(4)
		charge_family(1) = "1,045,000"
		charge_family(2) = "1,090,000"
		charge_family(3) = "1,135,000"
		charge_family(4) = "1,310,000"

		toNow = CDbl(getNow())

		If selfip() = "121.126.92.182" Then
			'Response.write period_ymd_end1 & " :: " & period_ymd_end2 & " :: " & period_ymd_end3

			'period_ymd_end1 = "20211007"
			'period_ymd_end2 = "20211021"
		End If
	
		If toNow <= cDbl(period_ymd_end1) Then
			charge_cnt = 1
			If period_ymd_start1 = "20210927" Then
				period_ymd_start1 = "20210927"
			End If
			period_ymd_end1 = "20211010"
			chargr_day = "2021년 " & putDate(period_ymd_start1,"krmd") & " ~ " & "2021년 " & putDate(period_ymd_end1,"krmd")

		ElseIf toNow <= cDbl(period_ymd_end2) Then
			charge_cnt = 2
			period_ymd_end2 = "20211024"
			chargr_day = "2021년 " & putDate(period_ymd_start2,"krmd") & " ~ " & "2021년 " & putDate(period_ymd_end2,"krmd")
		ElseIf toNow <= cDbl(period_ymd_end3) Then
			charge_cnt = 3
			chargr_day = "2017년 " & putDate(period_ymd_start3,"krmd") & " ~ 개장전"
			'chargr_day = "2021년 " & putDate(period_ymd_start3,"krmd") & " ~ " & "2021년 " & putDate(period_ymd_end3,"krmd")
		Else
			charge_cnt = 4
			
		End If


		Call SetDBNot(conn, rs)

%>