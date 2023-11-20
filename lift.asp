<!--#include virtual="/conf/config.asp"-->
<%
'   
'   '//마감
'   If  js_id<>"khs532" Then
'      If getnowtime() >= "202302282200" Then
'         Call ScriptAlert("3월1일 폐장으로 온라인 판매가 종료되었습니다.\n폐장일 리프트, 장비렌탈권은 50%할인된 가격에 현장판매됩니다.")
'         Call ScriptBack()
'         Response.end
'      End If
'   End If
'
'   ipList = "--211.181.191.131--211.40.187.2--211.181.191.130--211.40.187.251--121.126.75.249--121.126.92.182--121.126.176.114--121.126.247.10--121.126.92.182--121.134.191.140--106.101.131.8--106.101.130.241--14.32.136.116--121.126.87.78--221.149.80.12,61.73.8.166,172.16.0.2--211.237.252.101"
    sns_id = Session("sns_id"))  
    Dim id
    If NullChk(js_id) Then
        id = sns_id
    Else
        id = js_id
    End If
'
'   If InStr(ipList, Request.ServerVariables("Remote_Addr")) < 1 And id<>"khs532" Then
'   
'      ///아래 주석풀기
'      If getnowtime() < "202212082300" Then
'         Call ScriptAlert("현장 오픈 할인 종료 후 12월 8일 23시부터 예약 가능합니다.")
'         Call ScriptBack()
'         Response.end
'      End If
'   End If

%>
<!--#include virtual="/conf/resvLift/prdt_setting.asp"-->
<!--#include virtual="/conf/resvLift/func.asp"-->
<%
  inwonMax = 10
  Call SetDBSki(conn, rs)

  '//아이디당 미사용 구매 4회까지 가능
  'sql = "SELECT count(*) cnt FROM WB_TK_ORDER_MST where member_id='"&js_id&"' and ticket_chk='*' and use_yn='N' "
  'Call QueryOne(sql, buyCnt)

  '//아이디당 미사용 구매 4회까지 가능
  sql = "exec xtw_WB_TK_SALES_S5 '"&id&"'  "
  Call QueryFive(sql, getId, noUse_Qty, Use_Qty, Rent_NoUse_Qty, Rent_Use_Qty)

  If getId ="ERROR" Then
    noUse_Qty = 0
    Rent_NoUse_Qty = 0 
  End If

  If  NullChk(noUse_Qty) Then noUse_Qty = 0
  If  NullChk(Rent_NoUse_Qty) Then Rent_NoUse_Qty = 0

  Call SetDBNot(conn, rs)
  '//휴대폰번호 불러오기
  Call SetDB(conn, rs)
  If jsn_type = "js" Then
    sql = " select mb_hp from jsmember where mb_id='"&id&"' " 
    Call QueryOne(sql, mb_hp)
  Else If jsn_type ="sns" Then
    sql = " select mb_hp from jssnsmember where mb_id='"&id&"' " 
    Call QueryOne(sql, mb_hp)
  End If
  '//휴대폰번호 불러오기 끝 할당시작
  numArr = Split(mb_hp, "-")
  userNum1 = numArr(0)
  userNum2 = numArr(1)
  userNum3 = numArr(2)
  '//번호관련 끝

  Call SetDbnot(conn, rs)

'  If js_id="khs532" Then
'    noUse_Qty = 0
'  End If

  Session("liftUrl")= "prdt01"

  eventPriod = "ing"
  If getnow() > endYmdSet Then
    eventPriod = "end"
  End If

%>
<!doctype html>
<html lang="kr">

<head>
  <!-- #include virtual="/w2/asset/inc/head_reaction.asp"-->
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
  <div class="sub lift new_lift">
    <div class="top bg_reserv">
      <h2 class="tit">리프트/장비 렌탈 예약</h2>
      <span class="bg"></span>
      <div class="location no_tab">
        <ul class="clearfix">
          <li class="first"><a href="/w2/"><img src="/w2/asset/images/common/home_icon.png" alt=""></a></li>
          <li class="arrow">
            <a href="javascript:void(0)">스키</a>
          </li>
          <li class="arrow">
            <a href="javascript:void(0)">예약안내</a>
          </li>
          <li class="arrow sub_menu">
            <a href="javascript:void(0)" class="mw174">리프트/장비 렌탈 예약</a>
            <ul>
              <li><a href="/w2/reservation/golf/member_reserv01.asp">회원제 골프장 예약</a></li>
              <li><a href="/w2/reservation/golf/public_reserv01.asp">퍼블릭 골프장 예약</a></li>
              <li><a href="/w2/reservation/shuttle/reservation.asp">셔틀버스 예약</a></li>
              <li class="on"><a href="/w2/reservation/lift/lift.asp">리프트권 예약</a></li>
              <li><a href="/w2/reservation/lesson/ski_board01.asp">강습 예약</a></li>
              <li><a href="/w2/reservation/condo/condo.asp">콘도 예약</a></li>
              <li><a href="/w2/reservation/ticket/info.asp">시즌권 구매</a></li>
              <li><a href="/w2/reservation/locker/agree.asp">부츠 보관함 구매</a></li>
              <li><a href="/w2/member/mypage.asp">구매&amp;예약확인</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <div class="new_top">
        <div class="new_tit_wrap">
          <p class="new_tit_bar">리프트/장비 렌탈 예약</p>
          <p class="new_tit_sub">지산 리조트는 리프트권/장비 렌탈 온라인 예약을 통해<br />더욱 편리하게 지산을 즐기실 수 있도록 노력하고 있습니다</p>
        </div>
      </div>
    </div>
    <div class="inner pb200 new_mt230">
      <form name="insertF" id="insertF" method="post">
        <input type="hidden" name="cd_chk" value="other_cd" id="other_cd">
        <input type="hidden" name="liftSelCnt" id="liftSelCnt" value="0">
        <div class="txt_center mb70">
          <ul class="step_wrap fs16 lh22_ver4">
            <li class="on step01">구매하기</li>
            <li class="step02">결제하기</li>
            <li class="step03">결제완료</li>
          </ul>
        </div>
        <h3 class="sub_tit mb24">구매 전 유의사항</h3>
        <div class="bg_gray notice_bottom fs18 gray fw200">
          1. 장비렌탈권은 의류 및 기타 렌탈이 포함되지 않습니다.
          <br />2. 리프트, 장비렌탈권은 회차당 10매까지 구매 가능하며, 반복 구매 가능합니다.
          <br />3. 회차당 일괄 발권만 가능하며 부분 발권 및 교환, 환불은 불가합니다.
          <br />4. 리프트, 장비렌탈권은 30% 할인됩니다.
          <br />5. 리프트, 장비렌탈권은 구매일로부터 29일 후, 미사용 시 자동 취소 처리됩니다.
          <br />6. 22/23 스노우 시즌 셔틀버스는 별도 운영하지 않습니다.
          <br />7. 리프트, 장비 렌탈권 구매 시 주중권(월~금), 주말권(토/일) 확인 후 선택바랍니다.
          <br />&nbsp&nbsp&nbsp&nbsp(공휴일이 주중일 경우 주중권 티켓으로 구매 가능합니다.)
          <br />8. 발권된 티켓은 당일 사용만 가능하며, 미사용 티켓에 한하여 30분내에 환불 또는 교환 가능합니다.
        </div>
        <div class="txt_center mt10"><input type="checkbox" id="liftchk" name="liftchk"><label for="liftchk"
            class="fs18">위 내용을 모두 확인하였습니다.</label></div>
        <h3 class="sub_tit mb24 pt90">예매상품/인원수 선택</h3>
        <table class="basic_table">
          <caption>예매상품/인원수 선택</caption>
          <colgroup>
            <col style="width:18%">
            <col style="width:45%">
            <col style="width:auto">
          </colgroup>
          <thead>
            <tr>
              <th colspan="3" class="rel txt_left_imp bg_gray">
                예매 상품과 인원수를 선택해주세요.
                <a href="javascript:void(0)" class="brown_btn white fs16 lift_view txt_left">
                  할인 요금 보기
                </a>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th class="bg_gray br1">주중/주말</th>
              <td colspan="3">
                <!-- <span class="mr15">구분</span> -->
                <i class="mt_block"></i>
                <select name="weekCd" id="weekCd" class="select_wrap w350">
                  <option value="">주중/주말을 선택해주세요.</option>
                  <option value="0">주중(월~금)</option>
                  <option value="1">주말(토/일)</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="bg_gray br1">리프트</th>
              <td>
                <!-- <span class="mr15">권종</span> -->
                <i class="mt_block"></i>
                <select name="prdtCd" id="prdtCd" class="select_wrap w350 spdt" data-check='true'>
                  <option value="">권종을 선택해주세요.</option>
                  <% For i=0 To UBound(arrPrdtLiftCd) %>
                    <option value="<%=arrPrdtLiftCd(i)%>" price="<%=arrPrdtLiftPc(i)%>">
                      <%=arrPrdtLiftNm(i)%>
                    </option>
                  <% Next %>
                </select>
              </td>
              <td>
                <!-- <span class="mr15">인원</span> -->
                <i class="mt_block"></i>
                <select name="prdtEa" id="prdtEa" class="select_wrap w130" data-check='true'>
                  <option value="">인원</option>
                  <% For inwoni=1 To inwonMax %>
                    <option value="<%=inwoni%>">
                      <%=inwoni%>명
                    </option>
                  <% Next %>
                </select>
              </td>
            </tr>
            <tr>
              <th class="bg_gray br1">스키 렌탈</th>
              <td>
                <!-- <span class="mr15">스키</span> -->
                <i class="mt_block"></i>
                <select name="skiCd" id="skiCd" class="select_wrap w350 spdt" ski-check='true'>
                  <option value="">렌탈종류을 선택해주세요.</option>
                  <% For i=0 To UBound(arrPrdtSkiCd) %>
                    <option value="<%=arrPrdtSkiCd(i)%>" price="<%=arrPrdtSkiPc(i)%>">
                      <%=arrPrdtSkiNm(i)%>
                    </option>
                  <% Next %>
                </select>
              </td>
              <td>
                <!-- <span class="mr15">인원</span> -->
                <i class="mt_block"></i>
                <select name="skiEa" id="skiEa" class="select_wrap w130" ski-check='true'>
                  <option value="">인원</option>
                  <% For inwoni=1 To inwonMax %>
                    <option value="<%=inwoni%>">
                      <%=inwoni%>명
                    </option>
                  <% Next %>
                </select>
              </td>
            </tr>
            <tr>
              <th class="bg_gray br1">보드 렌탈</th>
              <td>
                <!-- <span class="mr15">보드</span> -->
                <i class="mt_block"></i>
                <select name="bordCd" id="bordCd" class="select_wrap w350 spdt" bord-check='true'>
                  <option value="">렌탈종류을 선택해주세요.</option>
                  <% For i=0 To UBound(arrPrdtBordCd) %>
                    <option value="<%=arrPrdtBordCd(i)%>" price="<%=arrPrdtBordPc(i)%>">
                      <%=arrPrdtBordNm(i)%>
                    </option>
                  <% Next %>
                </select>
              </td>
              <td>
                <!-- <span class="mr15">인원</span> -->
                <i class="mt_block"></i>
                <select name="bordEa" id="bordEa" class="select_wrap w130" bord-check='true'>
                  <option value="">인원</option>
                  <% For inwoni=1 To inwonMax %>
                    <option value="<%=inwoni%>">
                      <%=inwoni%>명
                    </option>
                    <% Next %>
                </select>
              </td>
            </tr>
          </tbody>
        </table>
        <!-- <p class="fs16 info pl15 pt10 gray">※ 주중 : 월~목 09:00 ~ 02:00, 금 09:00 ~ 04:00<br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp주말 : 토 09:00 ~ 04:00, 일 09:00 ~ 02:00</p> -->
        <p class="fs16 info pl15 pt10 gray">※ 소인 기준 :만 12세 이하(2010년 1월 1일 이후 출생자)</p>
        <p class="fs16 info pl15 red3">* 우대 할인은 현장 매표소에서 할인 가능합니다</p>
        <div id="prdtStep" style="display:none">
          <h3 class="sub_tit mb24 pt90">상품 및 인원 정보</h3>
          <div class="def_table_wrap">
            <div class="table_scroll">
              <table class="basic_table txt_center fs18">
                <caption>상품 및 인원 정보</caption>
                <colgroup>
                  <col style="width:38%">
                  <col style="width:38%">
                  <col>
                </colgroup>
                <thead>
                  <tr class="bg_gray">
                    <th>상품정보</th>
                    <th>인원</th>
                    <th>할인금액</th>
                  </tr>
                </thead>
                <tbody id="prdtList">
                  <!-- 
                  <tr>
                  <td class="br1">권종 : 리프트_2시간_대인  / 인원 : 1명 <button class="del_btn ml10"></button></td>
                  <td class="br1">55,000원</td>
                  <td class="br1"><select name="" id="" class="select_wrap w220">
                    <option value="">50% 할인 쿠폰</option>
                  </select>
                  </td>
                  <td >
                  <p class="brown fw500">27,500원</p>
                  <p class="gray fw200">(-50%쿠폰 적용가)</p>
                  </td>
                  </tr>
                  <tr>
                  <td class="br1">2</td>
                  <td class="br1">권종 : 리프트_2시간_대인  / 인원 : 1명 <button class="del_btn ml10"></button></td>
                  <td class="br1">55,000원</td>
                  <td class="br1"><select name="" id="" class="select_wrap w220">
                    <option value="">50% 할인 쿠폰</option>
                  </select>
                  </td>
                  <td>
                  <p class="brown fw500">27,500원</p>
                  </td>
                  </tr>             -->
                </tbody>
              </table>
            </div>
          </div>
          <!-- <table class="basic_table txt_center fs18 bt0_table bb2_table">
          <caption>요금 및 결제 정보</caption>
          <colgroup>
          <col style="width:80%">
          <col style="width:auto">
          </colgroup>               
          <tbody>                  
          <tr class="bg_gray">
          <td colspan="4" class="txt_right"><p class="black fw500">총 결제 금액</p></td>
          <td>
          <p class="brown fw500 fs28">122,500원</p>
          </td>
          </tr>
          </tbody>
          </table> -->
          <!--여기 원래 주석 아닌데 주석처리했음 보증금관련내용이라서-->
          <!--<div class="fs16 info pl15 pt10 red">※ 리프트권 안내사항
          <p class="pl10">- 모든 권종의 판매 금액에는 보증금 1,000원이 포함 되어있습니다.</p>
          <p class="pl10">- 보증금은 리프트권 1장당 부여되는 금액으로 현장에서 RF카드 반환 시 보증금은 환불됩니다.</p>
          </div> -->
          <!--
          <h3 class="sub_tit mb24 pt90">결제 수단 선택</h3>
          <table class="basic_table">
          <caption>결제 수단 선택</caption>
          <colgroup>
          <col style="width:28%">
          <col style="width:72%">
          </colgroup>
          <tbody>
          <tr>
          <th class="br1">제휴사 카드 할인 (30%)</th>
          <td>
          <input type="radio" name="cd_chk" value="shcd" id="shcd"><label for="shcd" class="mr15">신한카드</label>
          <input type="radio" name="cd_chk" value="kbcd" id="kbcd"><label for="kbcd" class="mr15">KB 카드</label>
          <i class="mt_block"></i>
          <input type="radio" name="cd_chk" value="nhcd" id="nhcd"><label for="nhcd" class="mr15">농협NH 카드</label>
          <input type="radio" name="cd_chk" value="hncd" id="hncd"><label for="hncd">하나카드</label>
          </td>
          </tr>
          <tr>
          <th class="br1">비 제휴사 카드 할인 (20%)</th>
          <td><input type="radio" name="cd_chk" value="other_cd" id="other_cd"><label for="other_cd">그 외 결제 수단</label></td>
          </tr>         
          </tbody>
          </table>
          <p class="fs16 info pl15 pt10 gray">※ 제휴사 카드는 30% 할인, 비 제휴사 카드는 20% 할인됩니다.</p>
          -->
          <h3 class="sub_tit mb24 pt90">연락처 정보</h3>
          <table class="basic_table fs18">
            <caption>연락처 정보</caption>
            <colgroup>
              <col style="width:25%;">
              <col>
            </colgroup>
            <tbody>
              <tr>
                <td class="br1 txt_center">
                  <span class="red">*</span>휴대전화번호
                </td>
                <td>
                  <select name="tel1" id="tel1" class="ph select_wrap w100">
                    <option value="010" <% If userNum1=="010" Then %> selected <% End If %> >010</option>
                    <option value="011" <% If userNum1=="011" Then %> selected <% End If %> >011</option>
                    <option value="016" <% If userNum1=="016" Then %> selected <% End If %> >016</option>
                    <option value="017" <% If userNum1=="017" Then %> selected <% End If %> >017</option>
                    <option value="018" <% If userNum1=="018" Then %> selected <% End If %> >018</option>
                    <option value="019" <% If userNum1=="019" Then %> selected <% End If %> >019</option>
                  </select>
                  <i>-</i>
                  <input class="ph basic_input w100" type="text" maxlength="4" name="tel2" id="tel2"
                    value="<%= userNum2 %>" numberOnly="true" maxlength="4" data-valid="notnull" data-alert="연락처">
                  <i>-</i>
                  <input class="ph basic_input w100" type="text" maxlength="4" name="tel3" id="tel3"
                    value="<%= userNum3 %>" numberOnly="true" maxlength="4" data-valid="notnull" data-alert="연락처">
                </td>
              </tr>
            </tbody>
          </table>
          <p class="fs16 info pl15 pt10 red">* 리프트권 예매 후 고객님의 휴대폰으로 구매 예약번호가 발송되오니 반드시 최신 정보로 수정하시기 바랍니다.</p>
          <div class="txt_center mt40">
            <button type="button" class="brown_btn fs18 fw500 white" id="nextBtn">다음</button>
          </div>
        </div>
        <!-- #include file="incUseHtml.asp"-->
      </form>
    </div>
    <!-- //inner -->
    <!--popup-->
    <div class="popup_area" id="lift_popup_wrap">
      <!-- #include file="incPopupHtml.asp"-->
    </div>
    <!--//popup-->
  </div>
  <script>
    $(document).ready(function () {
      $(".sub .lift_view").click(function () {
        //alert('1');
        $('#lift_popup_wrap').css('display', 'block');
        $('.popup_modal').css('display', 'block');
        $('body').css({ 'overflow-y': 'hidden', 'padding-right': '17px', 'box-sizing': 'border-box' });
      });
      $("#lift_popup_wrap .popup_close, .popup_modal").click(function () {
        $('#lift_popup_wrap').css('display', 'none');
        $('.popup_modal').css('display', 'none');
        $('body').css({ 'overflow-y': 'visible', 'padding-right': '0', 'box-sizing': 'content-box' });
      });
    });
    $("#nextBtn").click(function () {
      var tel1 = $("#tel1").val();
      var tel2 = $("#tel2").val();
      var tel3 = $("#tel3").val();
      var tel = tel1 + "-" + tel2 + "-" + tel3;

      if (tel2 == "") {
        alert("연락처를 입력해주세요.");
        return false;
      }
      if (tel3 == "") {
        alert("연락처를 입력해주세요.");
        return false;
      }
    });
  </script>
  <!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
<script>
  var noUse_Qty = "<%=noUse_Qty%>";
  var Rent_NoUse_Qty = "<%=Rent_NoUse_Qty%>";
  var eventPriod = "<%=eventPriod%>";
  var agentChk = "<%=agentChk%>";
</script>
<script src="prdt.js?v=<%=getnowtime()%>"></script>
</html>