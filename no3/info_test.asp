<!--#include virtual="/conf/config.asp"-->
<!--#include virtual="/w2/reservation/ticket/func/setting.asp" -->
<!--#include virtual="/w2/reservation/ticket/func/ticket_login.asp" -->
<!--#include file="info_charge.asp"-->
<!doctype html>
<html lang="kr">
<head>
	<!-- #include virtual="/w2/asset/inc/head_reaction.asp"-->
</head>
<body data-number="subGnb03">
	<!-- #include virtual="/w2/asset/inc/header_reaction.asp"-->

	<div class="sub ticket info">
		<!-- #include virtual="/w2/reservation/ticket/ticket_top_test.asp"-->
		<div class="arrow_tap_wrap">
			<a href="javascript:void(0);" class="tit rel">시즌권안내</a>
			<ul>
				<li><a href="buy.asp">시즌권 구매</a></li>
				<li><a href="photo.asp">사진등록 및 수정</a></li>
				<li><a href="refund.asp">시즌권 환불 & 양도 신청서</a></li>
			</ul>
		</div>
		<div class="tab_bg">
			<ul class="tab_wrap w4">
				<li><a href="javascript: void(0)" class="on"><span>시즌권 안내</span></a></li>
				<li><a href="buy.asp"><span>시즌권 구매</span></a></li>
				<li><a href="photo.asp"><span>사진 등록 및 수정</span></a></li>
				<li><a href="refund.asp"><span>시즌권 환불 &amp;<i class="mt_block"></i> 양도 신청서</span></a></li>
			</ul>
		</div>
		<div class="inner pt100 pb190">
			<ul class="cont01 clearfix">
				<li class="dt">
					<a class="tc charge_btn" href="javascript:void(0)" >
						요금표
						<p class="view_btn">자세히보기</p>
					</a>	
				</li>
				<li class="dt">
					<a class="tc terms_btn" href="javascript:void(0)">
						이용약관
						<p class="view_btn">자세히보기</p>
					</a>	
				</li>
			</ul>

			<p class="sub_tit pb36 pt90">시즌권 권종 안내</p>
			<ul class="cont02 clearfix">
				<li class="dt">
					<p class="tc">청소년을 위한<br>모든 권종 할인!!</p>
				</li>
				<li class="dt">
					<p class="tc">요일/시간대별<br>다양한 권종!!</p>
				</li>
				<li class="dt">
					<p class="tc">아동반값!!<br>가족할인!!</p>
				</li>
			</ul>
			
			<p class="sub_tit pb36 pt90"><%=seasonYear%>시즌 시즌권 구매혜택 안내</p>
			<div class="cont03 clearfix">
				<div class="img_wrap">
					<img src="/w2/asset/images/sub/reservation/ticket01_img01.jpg" alt="">
				</div>
				<ul class="txt_wrap">
					<li>
						<p>개인락카 할인요금 적용</p>
						<span>2020년 11월 5일 인터파크 선착순 판매 예정</span>
					</li>
					<li>
						<p>지류 할인권 제공</p>
						<span>지류 할인권 제공</span>
					</li>
					<li>
						<p>셔틀버스 무료 이용</p>
						<span>서울, 수도권 6개 노선운영 예정 </span>
					</li>
					<li>
						<p>시즌권자 부대시설 현장 할인</p>
						<span>콘도식당 10%할인, 식후 아메리카노 무료제공<i class="m_block"></i> (중복할인 불가)</span>
					</li>
					<li>
						<p>시즌권 동반자 할인</p>
						<span>동반 3인까지(리프트, 렌탈 30%)</span>
					</li>
				</ul>
			</div>
			
			<p class="sub_tit pb36 pt90">이용안내</p>
			<ul class="cont04 clearfix">
				<li>
					<img src="/w2/asset/images/sub/reservation/ticket01_ico12.png" alt="">
					<p>시즌권 구매</p>
				</li>
				<li>
					<img src="/w2/asset/images/sub/reservation/ticket01_ico13.png" alt="">
					<p>실사용자 정보입력</p>
				</li>
				<li class="last">
					<img src="/w2/asset/images/sub/reservation/ticket01_ico14.png" alt="">
					<p>시즌권 수령(현장수령)</p>
					<span>스키장 개장 후 신분증 및 확인서류 지참 후 지산리조트 회원상담실로 방문수령</span>
				</li>
			</ul>
		
			<p class="sub_stit pb36 pt60">이용시간</p>
			<table class="basic_table">
				<caption>이용시간</caption>
				<colgroup>
					<col style="width:200px" class="w16">
					<col style="width:auto">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">전일권</th>
						<td>시즌기간 (全) 시간대 이용가능(스프링캠프 제외)</td>
					</tr>
					<tr>
						<th scope="row">평일권</th>
						<td>월~목 09:00 ~ 익일 02:00 / 금 09:00 ~ 익일 04:00 / 일 18:30 ~ 익일 02:00 / (토요일 이용 불가)</td>
					</tr>
					<tr>
						<th scope="row">주중주간권</th>
						<td>월요일 ~ 금요일 09:00 ~ 17:00 이용가능(토,일 사용 불가)</td>
					</tr>
					<tr>
						<th scope="row">뉴야간심야권</th>
						<td>주중 (일~목) 20:30 ~ 02:00 / 주말 (금~토) 20:30 ~ 04:00</td>
					</tr>
					<tr>
						<th scope="row">야간심야권</th>
						<td>주중 (일~목) 18:30 ~ 02:00 / 주말 (금~토) 18:30 ~ 04:00</td>
					</tr>
				</tbody>
			</table>
			<ul class="gray fs16 fw300 pt17">
				<li class="dot star">심야 운영 시기는 12월20일 전후 ~ 2월 중순경 예정 운영 (기후 여건에 따라 변경 가능)</li>
				<li class="dot star">새벽스키 운영하지 않으며, 주중 23시 ~ 24시 정설 타임 없이 익일 02까지 운영</li>
				<li class="dot star">일요일 09시 ~ 익일 02시까지 운영</li>
			</ul>

			<p class="sub_tit pb36 pt90">시즌권 관련 서류 양식 다운로드</p>
			<ul class="cont06 clearfix">
				<li class="dt">
					<a href="/w2/asset/file/시즌권환불신청서.doc" download="" class="tc">시즌권<br>환불신청서</a>
				</li>
				<li class="dt">
					<a href="/w2/asset/file/2021양도양수신청서.doc" download="" class="tc">시즌권<br>양도양수 신청서</a>
				</li>
				<li class="dt">
					<a href="/w2/asset/file/2021위임장(시즌권양도양수용).docx" download="" class="tc">시즌권<br>양도양수 위임장</a>
				</li>
				<li class="dt fourth">
					<a href="/w2/asset/file/개인정보수집이용동의서_2021시즌권오프라인용_또는_온라인첨부파일용.doc" download="" class="tc">개인정보<br>이용동의서</a>
				</li>
				<li class="dt last">
					<a href="/w2/asset/file/2021시즌권이용약관1.xlsx" download="" class="tc">시즌권 약관<br>다운로드</a>
				</li>
			</ul>
		</div>
	</div>





	<!--popup 시즌권약관-->
		<div class="popup_area" id="terms_popup_wrap">
		<div class="popup_modal"></div>
			<div class="popup_wrap" >				
				<div class="popup_close"><img src="/w2/asset/images/sub/reservation/pop_close.jpg" alt=""></div>
				<div class="popup_inner">
					<div class="pop02_html">
						<h2 class="normal_tit">23/24시즌 리프트 시즌권 약관<span class="bar"></span></h2><br><br>
								
							<h3>제1조(목적)</h3><br>
							<p>이 약관은 지산리조트㈜(이하 '사업자'로 합니다)가 판매하는 2023/2024시즌 리프트 시즌권을 구입하여 이용하는 자(이하 '이용자'라 합니다)의 권리 와 의무 및 이용절차 등 기타 필요 사항의 규정을 정함을 목적으로 합니다.</p><br><br>
							

							<h3>제2조 (정의)</h3><br>
							<p>가. 시즌권은 회원권이 아니며 스키 및 스노우보드 애호가를 위하여 대폭 할인된 가격으로 제공되는 리프트에 국한된 특별 할인상품입니다.<br><span  >나. 본 시즌권으로 눈썰매장 이용은 불가 합니다.</span><br>다. 시즌권은 기명식 이용권입니다.</p><br><br>
							
							
							<h3>제3조 (사용기간 및 적용)</h3><br>
							<ol>
								<li  ><span >가.</span> 시즌권의 사용기간은 하기(①,②)와 같이 구분되며 서비스 기간은 이용자에게 무상으로 제공되는 기간입니다.</li>
								<li  ><span >① 기본사용기간 -</span> 전일권, 야심권, 평일권 : 개장일로부터 60일   <br>   주말권, 주중주간권 : 개장일로부터 30일</li>
								<li  ><span >② 서비스기간 -</span> 전일권, 야심권, 평일권 : 60일 이후 ~ 폐장일   <br>  주말권, 주중주간권 : 30일 이후 ~ 폐장일</li>
							</ol>
							<p><span >나. </span> 이용자의 시즌 기간 중 이용횟수에는 제한이 없으나 천재지변, 기상여건(강풍 등으로 인한 안전문제 발생),
								리프트 정비,보강제설, 국내외 스키 관련 대회로 인한 슬로프 제한 등 사업자의 사정상 불가피한 사유로 일부 또는 모든 리프트의 운행 제한 및 변경 될 수 있으며, 리프트 검표 시 적극 협조 바랍니다.</p>
							 <p>다. 권종이용가능 시간</p><br>
							 <div class="table_wrap">
							 <div class="def_table_wrap touchParent">
							<div class="table_scroll">
							 <table width="100%" cellpadding="10" cellspacing="10" summary="권종이용가능시간" class=" terms_table" style="border-top:1px solid #000;">
								<caption>권종이용가능시간</caption>
									<colgroup>
										<col width="16.6%">
										<col width="16.6%">
										<col width="16.6%">
										<col width="16.6%">
										<col width="16.6%">
										<col width="16.6%">
									</colgroup>
									<thead>
										<tr>
											<th scope="row" style="border-left:0;">구분</th>
											<th scope="col">전일권</th>
											<th scope="col">야심권</th>
											<th scope="col">주말권</th>
											<th scope="col">평일권</th>
											<th scope="col">주중주간권</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" style="border-left:0;">적용</th>
											<td>시즌중</td>
											<td>야간<br> 및 심야</td>
											<td>뉴야간(20:30)<br>및 심야</td>
											<td>일(야간)~금(심야)</td>
											<td>토,일 제외한<br>주간권종 시간대<br>(공휴일 이용가능)</td>
										</tr>
										<tr>
											<th scope="row" style="border-left:0;">이용시간</th>
											<td>전체시간대</td>
											<td>
												주중 : (일~목)
												<br />18:30~02:00
												<br />주말 : (금~토)
												<br />18:30~04:00
											</td>
											<td >
												주중 :(일~목) 
												<br />20:30 ~ 02:00
												<br />주말 : (금~토)
												<br />20:30~04:00
											</td>
											<td >
												월~목 : 09:00<br />~익일 02:00<br />금요일 : 09:00<br />~익일02:00<br />일요일 : 18:30<br />~익일02:00
											
											</td>
											<td >09:00~17:00</td>
										</tr>													
									</tbody>
							 </table>
							 </div>
							 </div>
							 </div>
							<ol>
								<li>단, 기후여건에 따라 심야 운영시기는 변동될 수 있으며  정설시간 제외</li>
								<li>심야운영시기 : 12월20일 전후 ~ 2월중순경 예정 운영 (기후 여건에따라 변경 가능)	</li>
								<li>주중(일~목) 23:00 ~ 24:00시 정설타임 없이 운영합니다.</li>
							</ol>
							 <br><br>


							<h3>제4조 (이용자의 자격,의무 및 시즌권 관리,발급)</h3><br>
							<ol>
								<li>가. 이용자는 시즌권을 소지하였을 경우에만 이용자의 권리를 행사할 자격이 주어지며 리프트 탑승시 항시 지정위치(좌측 팔)에 착용하여야 합니다. 리프트 운영은 당사 사정에 따라 축소 운영 될 수 있습니다.</li>
								<li>나. 이용자는 사업자가 주기적으로 실시하는 검표 안내에 따라주셔야 하며, 사업자가 지정하는 검표원의 고글, 마스크, 헬멧 등 안전 보호장비 탈착 요구에 적극 협조하여야 합니다.</li>
								<li>다. 시즌권은 기명식 이용권으로 당사에 등록된 본인외 제3자의 이용은 불가하며 적발시 압수됨과 동시에 시즌권의 효력도 상실 됩니다 </li>
								<li>라. 시즌권은 임의로 대여,양도,매매 할수 없으며 이러한 사례가 적발될 경우 민, 형사상의 책임을져야 합니다.</li>
								<li>마. 시즌권의 분실 또는 도난으로 인하여 시즌권을 소지하지 못하게 된 경우 및 시즌권이 손상되어 본인 여부를 확인할 수 없는 경우에도 시즌권의 사용은 제한됩니다.</li>
								<li>바. 리프트 이용시 이용자 본인 부주의로 시즌권을 소지 못한 경우, 사업자는 재발급 및 리프트권 제공 또는 할인 등을 해주어야 할 의무가 없으며 이용자는 이를 사업자에게 요청할 수 없습니다.</li>
								<li>사. 시즌권 미소지시 리프트권은 별도로 구매하여 이용하여야 하며  필히 지참하여야 합니다.</li>
								<li><span >아.</span> 시즌권을 발급 받기 위해서는 반드시 사업자 소정의 가입신청서에 의한 실명 가입에 한하며, 상품 이용요금을 납부한 후 사업자의 시즌권 담당부서를 통한 정상적인 발급 절차에 의해서만 가능합니다.</li>
								<li><span class="marginbt50">자.</span> 상품 이용요금을 납부하신후 이미지파일(jpg)을 규격에 맞추어 1주일 이내에 등재시켜야 합니다.
									<ol>
										<li>- 이미지 규격 : 어깨이상이며,썬글라스,고글,모자 등을 탈의하여 본인식별이 가능한 이미지 (세로 5cm X 7cm, 200 dpi 이상, 300KB ~ 1MB이하 사진 )</li>
										<li>- 최근 3개월이내 정면으로 촬영한 사진을 등록해야 시즌권 발급이 됩니다.(눌림사진 및 스티커, 어플, 측면사진 불가)</li>
										<li>- 규정 미달 사진 제출시에는 시즌권 제작을 거부할수 있습니다.</li>
									</ol>
								</li>
								<li>차. 유효기간은 2020년 스키장 개장일로 부터 2021년 폐장일까지의 기간을 기준으로 하고 기간경과시 만료처리 됩니다.</li>
								<li>카. 소인권(2008/01/01 이후 출생자), 청소년권(2002/01/01 이후 출생자), 가족권은 수령시 학생증, 주민등록등본 등 확인서류를 지참하셔야 합니다.</li>
								<li>타. 본 시즌권은 기명식 유가증권이므로 등록된 본인만 사용이 가능하며 본인의 부주의로 시즌권을 소지하지 않을시 시즌권의 무료 재발급 및 무료 리프트권 또는 할인요청을 하실 수 없습니다.</li>
							</ol><br><br>


							<h3>제5조 (시즌권 부정사용 및 분실신고)</h3><br>
							<ol>
								<li>가. 본 약관을 위반하여 시즌권을 부정한 방법으로 사용하다 적발된 경우 모든 민형사상 책임은 귀책사유가 있는 이용자(구매자) 또는 부정 사용한 자에게 귀속됩니다.</li>
								<li><span >나.</span> 시즌권을 분실하거나 도난된 경우 이용자는 반드시 당사 시즌권 담당처에 지체없이 분실 신고를 하여야 하며, 분실 신고 이전에 부정사용으로 인하여 회수된 시즌권은 회수, 말소(폐기) 처리 됩니다.</li>
								<li>다. 기타 부정하게 사용되다 적발된 시즌권은 회수 및 폐기 처리될 뿐만 아니라 벌과금이 부과 됩니다.  </li>
								<li><span class="marginbt90"> 라.</span> 관련법률
									<ol>
										<li>1) &nbsp;도난및 분실된 시즌권을 이용한 경우 형법 제 329조와 형법 제 360조에 의거 절도죄 및 점유이탈물 횡령죄가 적용되어 사법처리를 받게 됩니다.</li>
										<li><span >2)</span> &nbsp;발급받은 시즌권의 위,변조 행위를 제공하거나, 위,변조된 시즌권을 부정사용하는 행위는 형법 제 217조에 의거 유가증권 위조등에 저촉되며, 적발된 경우 관할 경찰서로 인계되어, 민.형사상의 사법처리를 받게 됩니다.</li>
										<li><span >3)</span> &nbsp;고의 또는 과실로 인한 위법 행위나 법률상 원인없이 타인의 재산(시즌권)등으로 이익을 얻고 이로 인하여 타인에게 손해를 가한자는 민법 제741조, 민법 제750조에 의거 손해 배상 책임을 집니다.</li>
									</ol>
								</li>
							</ol><br><br>



							 <h3>제6조 (시즌권 부정사용시 처벌 규정)</h3><br>
							<ol>
								<li><span class="marginbt30">가.</span> 시즌권 구입자가 제 3자에게 당해 시즌권을 약관상 정상적인 양도양수 절차를 거치지 아니하고 임의로 제 3자에게 대여하거나 양도하여 그 제 3자로 하여금 사용하게 하는 행위시
									<ol>
										<li>1)시즌권 폐기</li>
										<li>2)이용자 - 이용한 해당 시즌권종의 정상요금 벌과금 부과</li>
									</ol>
								</li>
								<li><span >나.</span> 제 3자가 분실, 절취, 횡령, 강취, 사취 등을 통해 습득한 시즌권을 이용한 행위
									<ol>
										<li>1)시즌권 폐기</li>
										<li><span >2)</span>시즌권 구입자(기명인) - 분실, 도난 신고후 제 3자의 이용행위에  대해서는 책임이 없으나, 신고전에 제 3자가 이용하다가 적발 되었다면 미신고 행위에 대한 책임으로 시즌권 폐기에 대해 이의를 제기할 수 없습니다.</li>
										<li>3)이용자 - 이용한 해당 시즌권종의 정상요금 벌과금 부과, 시즌권 구입자와 합의</li>
									</ol>
								</li>
								<li>다. 시즌권의 재발급 받은후 기존 시즌권 사용시 부정사용으로 적발되면 신/구 시즌권 모두 회수,말소 처리 됩니다.</li>
								<li>라. 시즌권 위, 변조 적발시 관할 경찰서에 고소</li>
								<li>마. 위 처벌 규정에 대해 손해 배상을 인정 하지 못할 경우 관할 경찰서로 인계</li>
							</ol><br><br>


							 <h3>제7조 (시즌권 재발급)</h3><br>
							<ol>
								<li>가. 시즌권의 재발급은 훼손되어 본인 여부를 확인 할 수 없거나 분실 시에만 가능하며 재발급 허용은 2회로 한정하고 그 이외의 경우에는 재발급이 불가합니다.</li>
								<li><span >나.</span> 시즌권의 분실 또는 도난 시 이용자는 즉시 사업자에게 유선/현장 신고를 하여야하며 시즌권담당부서에서 서면 (소정양식)을 작성후 재발급 처리하게되며 수수료는 이용자 본인이 부담하여야 합니다.</li>
								<li><span class="marginbt10 color_bl">다.</span> <span  >훼손 또는 분실에 의한 재발급수수료는 20,000원이며 분실된 시즌권은 사용 정지되며, 추후 분실된 시즌권을 찾을 경우에도 해당 시즌권의 사용은 불가하며 재발급 수수료의 환불도 불가합니다.</span><br>
								※ 단,분실에 의한 재발급의 경우 분실 신고 24시간이 경과한 후에 재발급됩니다.</li>
								<li>라. 추후 분실된 시즌권을 찾을시에는 시즌권 담당부서에 반납하여 주시고, 회수된 시즌권에 대해서는 폐기합니다.</li>
							</ol><br><br>


							<h3 style="padding:0 3px;"><strong>제8조 (시즌권의 양도양수)</strong></h3><br>
							<div>
							<ol style="padding:5px;">
								<li><span >가.</span> 시즌권의 양도양수는 최초 구입자 기준 1회에 한하며 수수료 납입 및 발급된 시즌권을 반납하여야 합니다.
									<ol>
										<li>- 양도양수 신청서를 작성하고  양도양수자는 신분증 사본을 제출해야 합니다. ※ 시즌권 양도양수는 대리 신청 불가 합니다. ※</li>
									</ol>
								</li>
								<li  ><span >나.</span> 양도양수 수수료는 4만원이며, 양도양수 기간은 하기일내에만 가능합니다.(전일권,야심권,평일권 : 개장일로부터 60일 이내, 주말권,주중주간권 : 개장일로부터 30일 이내)
									<ol>
										<li>- 위 내용과 같이 기본 사용기간 이후에는 시즌권 양도양수는 일체 불가합니다.</li>
									</ol>
								</li>
								<li  >다. 양도양수자의 경우 차기 시즌권 구매시 연속 구매(년차)의 혜택을 받을수 없습니다. </li>
								<li  >라. 시즌권 상품 중 경품, 무료교환권, 판촌행사용(동호회,외부사이트,특가상품등)이나 이월 된 시즌권은 양도양수 불가 합니다.
									<ol>
										<li>단 해외 이민, 임신, 유학, 군 입대, 신체장애(3주이상)등 사유로 인한 이용이 불 가능 할 경우에 예외로 양도/양수 가능하며, 시즌권 자는 반드시 양도와 관련된 증빙 서류를 당사에 제출 해야 하며, 서류 미 제출시 불가 합니다.<br/ >※ 위(나) 기간 하기 일 내에만 가능합니다.※</li>
									</ol>								
								</li>
								<li>마. 시즌권의 분실시에는 양도 불가합니다. (재발 급 후 양도양수 신청 가능) </li>
								<li>바. 사업자(지산리조트)를 통해서만 양도양수가 가능하며, 개인간 임의로 행해지는 양도양수로인해 야기되는 불이익에 대해서 사업자는 일체 책임을 지지 않습니다.</li>
								<li>사. 온라인 특가 시즌권은 특별할인 상품으로 3주이상의 부상 및 이주, 이민, 입대 등 정당한 사유를 제외하고 양도불가 합니다.</li>
								<!-- <li>아. 할인상품 구매후 양도할 경우 정상요금 또는 개인상품과의 차액을 지불해야 가능합니다.</li> -->
							</ol>
							</div><br><br>


							<h3 style="padding:0 3px;"><strong>제9조 (시즌권의 환불)</strong></h3><br>
							<div>
							<ol style="padding:5px;">
								<li>가. 시즌권의 환불은 가능하며 개장전후의 환불기준은 차이가 있습니다.</li>
								<li>나. 시즌권 환불 시 시즌권 이용자격이 상실되며, 반드시 발급받은 시즌권을 반납 또는 폐기 해주셔야 합니다.<br />(불법 사용 적발 시 벌과금이 부과 됩니다.)</li>
								<li  ><span class="marginbt130">다.</span> 환불 기준은 다음과 같습니다.
									<ol>
										<li>1)개장전 환불 : 위약금(시즌권 구매가격의 10%) 공제후 환불</li>
										<li><span >2)</span>개장후 환불 : (전일권, 야심권, 평일권 : 개장일~60일이내  주말권, 주중주간권 : 개장일~30일이내)에만 가능합니다<br>
												환불금 = 구매가 - 위약금(시즌권 구매가격의 10% ) - 사용금액(시즌 일할 계산액 * 개장후 영업일수)<br>
												※ 환불 기간중 개장후로부터 10일이내 환불의 경우 사용금액은 영업일수의 리프트 주간정상요금<br>
												※ 일할계산 = (전일권, 야심권, 평일권 : 해당종권 정상금액 / 60일   주말권, 주중주간권 : 해당종권 정상금액 / 30일)<br>
												※ 개장후 영업일수 = 시즌 개장일 ~ 청구일
										</li>
										<li>3)개장후 미수령자 환불 : 위약금(시즌권 구매가격의 10%)공제후 환불</li>
									</ol>
								</li>
								<li  >라. 시즌권 구입후 수령하지 않은 시즌권은 다음해 판매되는 시즌권 판매가와의 차액을 지불 후 사용이 가능합니다.<br>※ 시즌권 연장 기간은 다음해까지이며 이후 환불,이월 되지 않습니다.</li>
								<li>마. 2인이상의 공동구매 기획상품의 경우 개별 환불이 되지 않습니다. 단, 구성원의 차액지불시 가능합니다.<br />※ 환불 입금 기간 : 신청 접수 날 부터 7~14일 소요 됩니다. ※</li>
							</ol>
							</div><br><br>


							<h3>제10조 (변경승인)</h3><br>
							<p>사업자는 서비스 및 약관의 변경이 있을시 그 내용을 사업자의 홈페이지 게재나 e-mail 발송 등을 통해 적용 예정일 10일 전까지 이용자에게 공지하며, 이용자의 특별한 이의가 없을시에는 승인한 것으로 간주합니다.
							</p><br><br>


							<h3>제11조 (면책)</h3><br>
							<p>천재지변 또는 기타 불가항력적인 사유로 이용자에게 손해가 발생한 때에는 사업자는 이에 대한 책임을 지지 아니합니다.
							</p><br><br>


							<h3>제12조 (가입 거부)</h3><br>
							<p>시즌권 구매 신청후라도 신청자의 결격사유(과거 시즌권 또는, 리프트권 및 회원권의 불법매매, 양도, 대여, 회사의 명예 손상 및 업무방해 등)의 경우 시즌권의 발급은 거부 될 수 있습니다.</p><br><br>
							<h3>제13조 (기타)</h3><br>
							<ol>
								<li>가. 이 약관에 명시되지 아니한 사항 또는 이 약관의 해석상 이의가 있는 사항에 대해서는 관계법령 및 일반관행에 따릅니다.</li>
								<li>나. 이 약관과 관련된 소송의 관할법원은 사업자의 관할 지역 법원으로 정한다.</li>
								<li>다. 본 시즌권 구입시 당사에 제출된 개인 정보에 대하여 당사가 필요시 홍보자료(e-mail,sms등)로  사용할 수 있는것에 동의 한것으로 간주합니다. </li>
								<li>라. 본 약관은 판매개시일로부터 그 효력이 발생됩니다.</li>
							</ol>
						</div>
					</div>
				</div>		
			</div>
		</div>
		<!--//popup-->


		<!--popup 가격표-->
		<div class="popup_area" id="charge_popup_wrap">
		<div class="popup_modal"></div>
			<div class="popup_wrap" >				
				<div class="popup_close"><img src="/w2/asset/images/sub/reservation/pop_close.jpg" alt=""></div>
				<div class="popup_inner">
					<div class="pop_html">
						<h4 class="charge_tit"><%=seasonYear%>&nbsp;&nbsp;<%=chaname%> 시즌패스 요금표</h4>
						<h4 class="charge_sub_tit"></h4>
						<div class="charge_tab">
							<!-- 전일권 -->
							 <div class="def_table_wrap touchParent">
							<div class="table_scroll">
								<table summary="전일권 시즌요금표입니다." class="charge_table">
									<caption>전일권 시즌요금표</caption>
									<colgroup>

									</colgroup>
									<tr>
										<th scope="row" colspan="3" class="bdnone">구 분</th>
										<th scope="row" style="width:25%">정상가</th>
										<th scope="row" style="width:25%">판매가</th>						
									</tr>
									<tr>
										<td rowspan="4" class="bdnone">전일권</td>
										<td>대인</td>
										<td>2001/12/31일 이전 출생자</td>
										<td class="no"><%=FormatNumber(pricep1(1, 4),0)%></td>
										<td><%=FormatNumber(pricep1(1, charge_cnt),0)%></td>						
									</tr>									
									<tr>
										<td>청소년</td>
										<td>2002/01/01 이후 출생자</td>
										<td class="no"><%=FormatNumber(pricep1(2, 4),0)%></td>
										<td><%=FormatNumber(pricep1(2, charge_cnt),0)%></td>
										
									</tr>
									<tr>
										<td>소인</td>
										<td>2008/01/01 이후 출생자</td>
										<td class="no"><%=FormatNumber(pricep1(3, 4),0)%></td>
										<td><%=FormatNumber(pricep1(3, charge_cnt),0)%></td>
										
									</tr>
									<tr>
										<td>가족권</td>
										<td>대인2+소인1</td>
										<td class="no"><%=charge_family(4)%></td>
										<td><%=charge_family(charge_cnt)%></td>
									</tr>	
									<tr>
										<td rowspan="3">야심권</td>
										<td colspan="2">대인</td>
										<td class="no"><%=FormatNumber(pricep1(4, 4),0)%></td>
										<td><%=FormatNumber(pricep1(4, charge_cnt),0)%></td>									
									</tr>
									<tr>
										<td colspan="2">청소년</td>
										<td class="no"><%=FormatNumber(pricep1(5, 4),0)%></td>
										<td><%=FormatNumber(pricep1(5, charge_cnt),0)%></td>									
									</tr>
									<tr>
										<td colspan="2">소인</td>
										<td class="no"><%=FormatNumber(pricep1(6, 4),0)%></td>
										<td><%=FormatNumber(pricep1(6, charge_cnt),0)%></td>									
									</tr>

									<tr>
										<td rowspan="3">주말권</td>
										<td  colspan="2">대인</td>
										<td class="no"><%=FormatNumber(pricep1(7, 4),0)%></td>
										<td><%=FormatNumber(pricep1(7, charge_cnt),0)%></td>				
									</tr>
									<tr>
										<td colspan="2">청소년</td>
										<td class="no"><%=FormatNumber(pricep1(8, 4),0)%></td>
										<td><%=FormatNumber(pricep1(8, charge_cnt),0)%></td>				
									</tr>
									<tr>
										<td colspan="2">소인</td>
										<td class="no"><%=FormatNumber(pricep1(9, 4),0)%></td>
										<td><%=FormatNumber(pricep1(9, charge_cnt),0)%></td>				
									</tr>

									<tr>
										<td rowspan="3">평일권</td>
										<td colspan="2">대인</td>
										<td class="no"><%=FormatNumber(pricep1(10, 4),0)%></td>
										<td><%=FormatNumber(pricep1(10, charge_cnt),0)%></td>					
									</tr>
									<tr>
										<td colspan="2">청소년</td>
										<td class="no"><%=FormatNumber(pricep1(11, 4),0)%></td>
										<td><%=FormatNumber(pricep1(11, charge_cnt),0)%></td>					
									</tr>
									<tr>
										<td colspan="2">소인</td>
										<td class="no"><%=FormatNumber(pricep1(12, 4),0)%></td>
										<td><%=FormatNumber(pricep1(12, charge_cnt),0)%></td>			
									</tr>

									<tr>
										<td rowspan="3" class="bdnone">주중주간권</td>
										<td colspan="2">대인</td>
										<td class="no"><%=FormatNumber(pricep1(13, 4),0)%></td>
										<td><%=FormatNumber(pricep1(13, charge_cnt),0)%></td>
									</tr>
									<tr>
										<td colspan="2">청소년</td>
										<td class="no"><%=FormatNumber(pricep1(14, 4),0)%></td>
										<td><%=FormatNumber(pricep1(14, charge_cnt),0)%></td>
									</tr>
									<tr>
										<td colspan="2">소인</td>
										<td class="no"><%=FormatNumber(pricep1(15, 4),0)%></td>
										<td><%=FormatNumber(pricep1(15, charge_cnt),0)%></td>
									</tr>					
								</table>
								</div>
								</div>
						</div><!-- charge_tab -->
						<div class="charge_desc">
							<h4 class="charge_tit">알려드립니다.</h4>
							<ul>
								<div class="check_txt margintopnone fs16">					
									<%=price_notice2%>
								</div>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--//popup-->

		<script>
			$(document).ready(function(){
				$(".sub .terms_btn").click(function(){ 
					$('#terms_popup_wrap').css('display','block');
					$('.popup_modal').css('display','block');
					$('body').css({'overflow-y': 'hidden', 'padding-right': '17px', 'box-sizing': 'border-box'});
				});
				$("#terms_popup_wrap .popup_close").click(function(){ 
					$('#terms_popup_wrap').css('display','none');
					$('.popup_modal').css('display','none');
					$('body').css({'overflow-y': 'visible', 'padding-right': '0', 'box-sizing': 'content-box'});
				});	
				
				$(".sub .charge_btn").click(function(){ 
					$('#charge_popup_wrap').css('display','block');
					$('.popup_modal').css('display','block');
					$('body').css({'overflow-y': 'hidden', 'padding-right': '17px', 'box-sizing': 'border-box'});
				});
				$("#charge_popup_wrap .popup_close").click(function(){ 
					$('#charge_popup_wrap').css('display','none');
					$('.popup_modal').css('display','none');
					$('body').css({'overflow-y': 'visible', 'padding-right': '0', 'box-sizing': 'content-box'});
				});	
				
			});
	</script>


	<!-- #include virtual="/w2/asset/inc/footer.asp"-->
</body>
</html>