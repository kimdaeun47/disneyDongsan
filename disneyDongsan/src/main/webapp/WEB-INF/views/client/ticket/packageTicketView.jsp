<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/ticket/ticket.css" />

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
	crossorigin="anonymous"></script>

<script type="text/javascript">
	$(function() {

		$("#modalBtn").click(function() {
			if ($("#totalPrice").text() == 0) {
				alert("인원을 선택해주세요");
				location.href = "/ticket/packageTicketView";
			}
		});

		/* 예약하기 버튼 클릭 시 처리 이벤트 */
		$("#ticketInsertBtn").click(
				function() {

					$("#visit_date").val($("#input_date").text());
					$("#t_multi").val(package_num);
					$("#t_category").val("2/3/4인권");
					$("#total_price").val($("#totalPrice").text());
					console.log($("#input_date").text());
					console.log(package_num);
					console.log(totalPrice);

					// 필요한 약관 동의 여부 확인
					if ($("#check_1").is(":checked")
							&& $("#check_2").is(":checked")
							&& $("#check_3").is(":checked")) {

						// 모든 약관에 동의한 경우 visitInfoView 페이지로 이동
						$("#packageTicket_data").attr({
							"method" : "post",
							"action" : "/ticket/visitInfoView"
						});

						$("#packageTicket_data").submit();
					} else {
						alert("모든 약관에 동의해주세요.");
						return;
					}

				});

		/* totalPrice 계산하기 위한 변수 */
		let totalPrice = 0;
		let package_num = 0;

		/* 인원 선택 시 이벤트 */
		$(".packageSelect")
				.click(
						function() {
							package_num = $(
									"select[name=packageTicket] option:selected")
									.val();

							if (package_num == 2) {
								totalPrice = 70000;
							} else if (package_num == 3) {
								totalPrice = 102000;
							} else if (package_num == 4) {
								totalPrice = 136000;
							} else if (package_num == 1) {
								totalPrice = 0;
							}
							$("#totalPrice").text(totalPrice);
						})

	});
</script>

</head>
<body>
	<h1>패키지 예매하기</h1>
	<div class="container">
		<div class="row">
			<div class="div_left col-md-7">
				<input type="image" id="dongsanimg" src="/resources/images/234.jpg" alt="놀이공원"/>
				<div id="ticket_sub">
					<h4>함께 즐기는 특별한 우대 혜택!</h4>
				</div>
				<table class="pricetable">
					<tr>
						<th>상품명</th>
						<th>구성</th>
						<th>가격</th>
					</tr>
					<tr>
						<td>2인권</td>
						<td>종일권 2매</td>
						<td>70,000원</td>
					</tr>
					<tr>
						<td>3인권</td>
						<td>종일권 3매</td>
						<td>102,000원</td>
					</tr>
					<tr>
						<td>4인권</td>
						<td>종일권 4매</td>
						<td>136,000원</td>
					</tr>
				</table>
			</div>

			<div class="div_right col-md-5">
			<div class="div_right_inner">
			
				<h5>예약옵션을 선택해주세요.</h5>
				<hr />
				<!-- ------------------------------------ -->
				<div id="div_calendar">
						<div id="div_calendar_year">
							<input type="hidden" onclick="changeMonth(-1);" id="fa1" value="" />
							<input type="text" id="year" value="2020"
								style="width: 50px; display: initial;" class="form-control"
								readonly="readonly" />
							<input type="text" id="month" value="changeMonth(0);" style="width: 35px; display: initial;" class="form-control"
								readonly="readonly">
							<input type="button" onclick="changeMonth(1);" id="fa2" value="" />
						</div>
						<table id="calendar">
							<thead>
								<tr>
									<th>일</th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
									<th>토</th>
								</tr>
							</thead>
							<tbody id="tb_body"></tbody>
						</table>
					</div>

				<!-- ------------------------------------ -->
				<!-- 예약옵션 테이블 -->
					<form name="packageTicket_data" id="packageTicket_data" method="post">
						<input type="hidden" name="visit_date" id="visit_date" value="" />
						<input type="hidden" name="t_multi" id="t_multi" value="" /> <input
							type="hidden" name="total_price" id="total_price" value="" /> <input
							type="hidden" name="t_category" id="t_category" value="" />
					</form>
					<table id="ticket_table">
						<tr>
							<td class="ticket_td">방문예정일</td>
							<td id="input_date"></td>
						</tr>
						<tr>
							<td class="ticket_td">상품선택</td>
							<td><select name="packageTicket" class="packageSelect">
									<option value="1">인원 선택</option>
									<option value="2">2인</option>
									<option value="3">3인</option>
									<option value="4">4인</option>
							</select></td>
						</tr>
						<tr>
							<td class="ticket_td">총가격</td>
							<td><span id="totalPrice">0</span>원</td>
						</tr>
					</table>
				</div>
					<jsp:include page="../../modal/modal.jsp" />
					<input type="button" id="modalBtn" class="modalBtn" data-bs-toggle="modal" data-bs-target="#myModal" value="예약하기" />
					
				</div>
			</div>
		</div>
	<script>

			let date = new Date();
			let y = date.getFullYear();
			let m = ('0' + (date.getMonth() + 1)).slice(-2);
			let d = ('0' + date.getDate()).slice(-2);
			let today = document.getElementById("input_date");
			today.innerHTML = y + '-' + m + '-' + d;
			
			// 날짜 선택을 제한할 최소 날짜 설정 (오늘 이후)++
		    let minDate = new Date(y, m - 1, d);

		    // 이전 날짜 비활성화 함수++
		    function disablePastDates(date) {
		        return date >= minDate;
		    }
			
			$("#fa1").val((Number(m) - 1) + "월");
			$("#fa2").val((Number(m) + 1) + "월");
	
			function checkLeapYear(year) {//윤년 계산
				if (year % 400 == 0) {
					return true;
				} else if (year % 100 == 0) {
					return false;
				} else if (year % 4 == 0) {
					return true;
				} else {
					return false;
				}
			}
	
			function getFirstDayOfWeek(year, month) {//선택한 달의 1일 요일 구하기
				if (month < 10)
					month = "0" + month;//month가 10보다 작으면 month앞에 "0"
	
				return (new Date(year + "-" + month + "-01")).getDay(); //getDay () 메소드는 일주 (0-6), 하루 수를 반환
			}
	
			function changeYearMonth(year, month) {//버튼 클릭시 월별 날짜 구하기
				let month_day = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];//월별 마지막 날짜
	
				if (month == 2) {
					if (checkLeapYear(year))
						month_day[1] = 29;//2월이면 년도 나누기 4 했을 때 0이면 2월29일(윤년이면)
				}
	
				let first_day_of_week = getFirstDayOfWeek(year, month);//일요일이면 0, 월요일이면 1....
				let arr_calendar = [];
				for (let i = 0; i < first_day_of_week; i++) {
					arr_calendar.push("");//
				}
	
				for (let i = 1; i <= month_day[month - 1]; i++) {
					arr_calendar.push(String(i));//arr_calendar에 월에 마지막 날짜까지 1,2,3... 넣음 
				}
	
				let remain_day = 7 - (arr_calendar.length % 7);//빈공간
				if (remain_day < 7) {
					for (let i = 0; i < remain_day; i++) {
						arr_calendar.push("");
					}
				}
	
				renderCalendar(arr_calendar);
			}
			
			function renderCalendar(data) {
				let h = [];
				for (let i = 0; i < data.length; i++) {
					if (i == 0) {//첫주
						h.push('<tr>');
					} else if (i % 7 == 0) {
						h.push('</tr>');
						h.push('<tr>');//다음주..
					}
	
					if (data[i] === "") {
						h.push('<td></td>');
					} else {
						let day = Number(data[i]);
		                let selectedDate = new Date(current_year, current_month - 1, day);

		                if (disablePastDates(selectedDate)) {
		                    h.push('<td class="t_day" id="day' + data[i] + '" onclick="setDate(' + data[i] + ');" style="cursor:pointer;">' + data[i] + '</td>');
		                } else {
		                    h.push('<td class="t_day" id="day' + data[i] + '" style="cursor:not-allowed; color:lightgray;">' + data[i] + '</td>');
		                }
					}
	
				}
	
				h.push('</tr>');
	
				$("#tb_body").html(h.join(""));
				for (let i = 1; i <= $(".t_day").text().length; i++) {
					if (d == i && m == current_month && y == current_year) {
						$("#day" + i).css({
							"backgroundColor": "rgb(211, 211, 237)", 
							"border-radius": "25px"
						});
					}
	
				}
			}
			
	
			function setDate(day) {//선택할 날짜 가져가기
				/* $(".t_day").css("backgroundColor", "white"); */
				$(".t_day").css({
					"backgroundColor": "white", 
					"border-radius": "30px"
				});
				$("#day" + day).css({
					"backgroundColor": "rgb(211, 211, 237)", 
					"border-radius": "25px"
				});
				let text_month = current_month;
				if (day < 10) day = "0" + day;
				if (current_month < 10) text_month = "0" + text_month;
				
				$("#date_text").text(current_year + "-" + text_month + "-" + day);
	
				$("#input_date").html(current_year + "-" + text_month + "-" + day);
			}
	
			function changeMonth(diff) {
				if (diff == undefined) {
					current_month = parseInt($("#month").val());
				} else {
					current_month = current_month + diff;
	
					if (current_month == 0) {//전년도로 바뀜
						current_year = current_year - 1;
						current_month = 12;
					} else if (current_month == 13) {//다음년로 바뀜
						current_year = current_year + 1;
						current_month = 1;
					}
				}
	
				loadCalendar();
				if ((current_month) == Number(m)) {
					$("#fa1").prop("type", "hidden");
				} else {
					$("#fa1").prop("type", "button");
				}
				if ((current_month) == (Number(m) + 1)) {
					$("#fa2").prop("type", "hidden");
				} else {
					$("#fa2").prop("type", "button");
				}
			}
	
			function loadCalendar() {
				$("#year").val(current_year+"년");
				$("#month").val(current_month+"월");
				changeYearMonth(current_year, current_month);
	
				let previous_month = current_month - 1
				let next_month = current_month + 1
				if (previous_month === 0) {
					$("#fa1").val(12 + "월");
				} else {
					$("#fa1").val(previous_month + "월");
				}
	
				if (next_month === 13) {
					$("#fa2").val(1 + "월");
				} else {
					$("#fa2").val(next_month + "월");
				}
	
			}
	
			let current_year = (new Date()).getFullYear();
			let current_month = (new Date()).getMonth() + 1;
	
			$("#year").val(current_year+"년");
			$("#month").val(current_month+"월");
	
			changeYearMonth(current_year, current_month);
		</script>


</body>
</html>