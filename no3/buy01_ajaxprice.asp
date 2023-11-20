<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<%
	memcode = unescape(request("memcode"))
	buytype = request("buytype")
	members = request("members")  '//4인 8인
	group_couple = request("group_couple")  '// 그룹일때 커플선택
	halfPrice = request("halfPrice")  '// 가족-아이-반값
	groupName = unescape(request("groupName")) '// 그룹체크


	'//요금차수 설정(여기하고 buy_02_ajax.asp 두군데 해줘야함)
	'// 19780630-1-7773-송형일  20131027-1-7773-송민석 20151013-1-7773-송준하
'	If  Or memcode = "19771015-1-5303-권호삼"   Then
'		period ="period1"
'	End If
'
'	If memcode = "19780417-1-1417-정시현" Or memcode="19750804-2-7417-이은경" Then
'		g_period = "g_period1"
'	End If


	If NullChk(groupName) Then 
		a_ticketMem = fn_memtypeChk(memcode)	
		memtype = a_ticketMem(1)	'//회원타입	 0 회원, 1 일반, 2, 정동호회원, 3준동
		yearcha = a_ticketMem(2)	'//년차
		memage  = a_ticketMem(3)	'//1:대인, 2:청소년/커플, 3,소인

		'//기간체크(동호회원 일반회원은 기간이 틀림)
		If memtype="2" Or memtype="3" Then
			If g_period = "false" Then
				'Call ScriptAlert("동호회시즌권 판매기간이 아닙니다.")
				'Call ScriptLocation("../info/info.asp")
				Response.write "not"
				Response.end
			End If
		End If

		If NullCHk(members) Then members = "1"

		'//로그용
		sql = "insert into tb_ticket_firstlog(jisan_id, memcode, memtype, yearcha, memage, fn_option, reg_ip) " &_
				"	values('"& js_id &"','"& memcode &"','"& memtype &"','"& yearcha &"','"& memage &"','buy_02_ajax.asp','"& selfip() &"') "
		Conn.Execute( sql )

		'//구매가능 권종및 비용가져오기
		a_ticUsetime = fn_memTimeOption(memtype, yearcha, members, memage, buytype, halfPrice, group_couple, memcode)	

		Response.write a_ticUsetime &"!!!"&memtype&","&yearcha&","&memage
	Else
		'// 그룹명체크

		Call SetDB(conn, rs)
		'// Y : 사용가능, N : 사용불가
		sql = " select count(*) from tb_ticket_buy where s_group_name='"&groupName&"' and buytype='group' "	
		Call QueryOne(sql, realcnt)
		If realcnt > 0 Then 
			Response.write "N"
		Else
			sql = " select distinct s_group_memcode from tb_ticket_pending where s_group_name='"&groupName&"' and buytype='group' "	
			Call QueryOne(sql,tmpGroupmemcode)
			If NullChk(tmpGroupmemcode) = False Then 
				If tmpGroupmemcode = memcode Then
					sql = " select name, birth, sex, s_group_couple, hp, tel, email, memcode, imagefile, s_group_level, s_usetime " &_
						  " from tb_ticket_pending where buytype = 'group' and s_group_memcode='" & memcode & "' and s_group_position='N' "
					a_GroupList =	QueryRows(Sql)	

					If isArray(a_GroupList) Then
						innerHtml = ""
						For i = 0 To UBound( a_GroupList, 2)
							sex1 = ""
							sex2 = ""
							s_group_couple_chk = ""
							imgUrl = "../img/buy/photo_sample.jpg"

							name = a_GroupList(0, i)
							birth = a_GroupList(1, i)
							sex = a_GroupList(2, i)
							If sex = "1" Then 
								sex1 = "checked"
							Else
								sex2 = "checked"
							End If 
							s_group_couple = a_GroupList(3, i)
							If s_group_couple = "Y" Then
								s_group_couple_chk = "checked"
							End If 
							hp = a_GroupList(4, i)
							hpArr = Split(hp,"-")
							hp1 = hpArr(0)
							hp2 = hpArr(1)
							hp3 = hpArr(2)
							tel = a_GroupList(5, i)
							telArr = Split(tel,"-")
							tel1 = telArr(0)
							tel2 = telArr(1)
							tel3 = telArr(2)
							email = a_GroupList(6, i)
							tmpmemcode = a_GroupList(7, i)
							imagefile = a_GroupList(8, i)
							If NullChk(imagefile) = False Then 
								imgUrl = "/sub/ticket/upload/original/"&imagefile
							End If 
							s_group_level = a_GroupList(9, i)
							s_usetime = a_GroupList(10, i)

							tmpNo = i+2

							innerHtml = innerHtml + "<div class='buy02_border infoWrap' id='"&tmpNo&"' data-level='"&s_group_level&"'><span class='userCount'>#"&tmpNo&"[-]</span><div class='table_left_icon'><p><img src='"& imgUrl &"' alt='업로드이미지' class='imgDummy"&tmpNo&"'/></p><div style='text-align:center'><input type='hidden' class='box015' id='imagefile"&tmpNo&"' name='imagefile"&tmpNo&"' title='파일첨부' value='"& imagefile &"'><label for='file4' class='btn_filefind' onclick='fileupwindow("&tmpNo&");'>찾아보기</label></div></div><table class='buy02_table'><input type='hidden' name='memtype"&tmpNo&"' id='memtype"&tmpNo&"'><input type='hidden' name='yearcha"&tmpNo&"' id='yearcha"&tmpNo&"'><input type='hidden' name='memage"&tmpNo&"' id='memage"&tmpNo&"'><caption>개인권 사용자정보</caption><colgroup><col width='150'/><col width='auto;'/></colgroup><tr><th scope='row'><span class='color_red'>*</span> 사용자명</th><td scope='row'><label for='name' class='dis_none'>사용자명 입력칸</label><input type='text' name='name"&tmpNo&"' id='name"&tmpNo&"' class='box001' data-valid='notnull' data-alert='이름'  data-memcode='true' value='"& name &"'></td></tr><tr><th scope='row'><span class='color_red'>*</span> 생년월일/성별</th><td scope='row'><input type='text' id='birth"&tmpNo&"' name='birth"&tmpNo&"' class='box001 birth' data-valid='notnull' data-alert='생년월일' data-memcode='true' value='"& birth &"' readonly>&nbsp;&nbsp;&nbsp;&nbsp;<input type='radio' name='sex"&tmpNo&"' value='1' data-memcode='true' "&sex1&"/>남&nbsp;&nbsp;<input type='radio' name='sex"&tmpNo&"' value='2' data-memcode='true' "&sex2&"/>여&nbsp;&nbsp;<input type='checkbox' name='group_couple"&tmpNo&"' id='group_couple"&tmpNo&"' class='group_couple' value='Y' "&s_group_couple_chk&"/>커플</td></tr><tr><th scope='row'><span class='color_red'>*</span> 휴대폰번호</th><td scope='row'><select id='hp1"&tmpNo&"' name='hp1"&tmpNo&"' class='phone_hp'> <option value='010' >010</option><option value='011'>011</option><option value='016'>016</option><option value='017'>017</option><option value='018'>018</option><option value='019'>019</option></select><input type='text' class='box002' name='hp2"&tmpNo&"' id='hp2"&tmpNo&"' class='box002' numberOnly='true' maxlength='4' data-valid='notnull' data-alert='휴대폰번호' value='"&hp2&"'>-<input type='text' class='box002' name='hp3"&tmpNo&"' id='hp3"&tmpNo&"' class='box002' numberOnly='true' maxlength='4' data-valid='notnull' data-alert='휴대폰번호' data-memcode='true' value='"&hp3&"'></td></tr><tr><th scope='row'><span class='color_red'>&nbsp;&nbsp;</span> 전화번호</th><td scope='row'><select id='tel1"&tmpNo&"' name='tel1"&tmpNo&"' class='phone_tel'> <option value='02'>02</option><option value='031'>031</option><option value='032'>032</option><option value='033'>033</option><option value='041'>041</option><option value='042'>042</option><option value='043'>043</option><option value='051'>051</option><option value='052'>052</option><option value='053'>053</option><option value='054'>054</option><option value='055'>055</option><option value='061'>061</option><option value='062'>062</option><option value='063'>063</option><option value='064'>064</option><option value='070'>070</option></select><input type='text' name='tel2"&tmpNo&"' id='tel2"&tmpNo&"' class='box002' numberOnly='true' maxlength='4' value='"&tel2&"'>-<input type='text' name='tel3"&tmpNo&"' id='tel3"&tmpNo&"' class='box002' numberOnly='true' maxlength='4' value='"&tel3&"'></td></tr><tr><th scope='row'><span class='color_red'>&nbsp;&nbsp;</span> 이메일</th><td scope='row'><input type='text' id='email"&tmpNo&"' name='email"&tmpNo&"' class='box009' value='"& email &"'></td></tr><tr><th scope='row'><span class='color_red'>*</span> 회원번호</th><td scope='row'><input type='text' name='memcode"&tmpNo&"' id='memcode"&tmpNo&"' class='box009' data-valid='notnull' data-alert='회원번호' readonly value='"& tmpmemcode &"'></td></tr><tr><th scope='row' class='color_red'><span class='color_red'>*</span> 권종선택</th><td scope='row'><select id='selgubun"&tmpNo&"' name='selgubun"&tmpNo&"' class='selectbg' data-usetime='"& s_usetime &"'></select></th></td></tr></table></div>"
						Next 
						sql = " select s_group_couple, imagefile, s_usetime from tb_ticket_pending where buytype = 'group' and s_group_memcode='" & memcode & "' and s_group_position='Y' "
						Call QueryThree(sql, s_group_couple2, imagefile2, s_usetime2)
						If s_group_couple2 = "Y" Then 														
							s_group_couple2 = "true"
						Else 
							s_group_couple2 = "false"
						End If 
						If NullChk(imagefile2) = False Then 
							imagefile2 = "/sub/ticket/upload/original/"&imagefile2
						Else
							imagefile2 = "../img/buy/photo_sample.jpg"
						End If 
						innerHtml = innerHtml & "<input type='hidden' name='groupJang' id='groupJang' data-img='"&imagefile2&"' data-group-couple='"&s_group_couple2&"' data-usetime='"& s_usetime2 &"'/>"
						Response.write innerHtml
					Else
						Response.write "Y"						
					End If 
				Else
					Response.write "Y"
				End if
			Else
				Response.write "Y"			
			End If 
		End If 

		Call SetDBNot(conn, rs)
	End If 
%>
