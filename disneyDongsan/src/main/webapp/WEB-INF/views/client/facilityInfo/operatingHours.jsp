<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>	
			.hours{text-align: center;}
			.h_time img{ width: 80px; height: 80px;margin-bottom: 25px;}
			#hoursTime{font-size: 60px;}
			.container{ margin-left:auto;margin-right:auto; width: 900px;}
			.container #title {font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;padding: 50px;}
			
			#t_body {
				border-collapse: separate;
				font-size: 30px;
				font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
				width: 900px;
				height: 500px;
				border-spacing:5px; 
			}
			
			#t_body thead tr:first-child {background: #A4C3FF;}
			thead tr th{
				text-align: center;	
				border-radius: 10px;
				margin: auto;
				color: white;		
			}
			
			#t_body tr td{
				background: #EBF5FF;
				border-radius: 10px;
				font-weight: 400;
				vertical-align : top;
				padding:5px;

			}
					
			#t_body td:nth-child(7n+1) {color: red;}
			#t_body td:nth-child(7n) {color: blue;}
			td span{text-align: center;	color: black;}
			.date_text span{font-size: 30px;}
			.date_text span{color: #6495ED;}
			.poo{width: 30px;margin-left: 10px;margin-right: 0;}
			.btnS{display: inline-block;
			   height: 40px;
			   width: 70px;
			   font-weight: 500;
			   font-size: 20px;
			   line-height: 20px;
			   margin-bottom:10px;
			   margin-left: 10px;
			   color:white;
			   background-color: #6495ED;  }	
			.btnS:hover{
					  border: 2px solid #c3daf7;
					  background-color: white;
					  color:black;
					}
			.ac{
  display: inline-block;
  transform-origin: center;
  padding: 0 0.5rem;
  animation: animate 3s infinite;
}
@keyframes animate{
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.10);
  }
  100% {
    transform: scale(1);
  }
}
	
	</style>
	</head>
	<body>
	  <div class="container">
	  	<div>
			<div class='hours'>
				<h1 id="title">디즈니 동산 운영 시간</h1>
 
				<h1 class="selectDate" id="date_text">2023.08.23</h1>
				<div class="h_time">
					<h1 class="ac">
						<img src="/resources/images/facilityInfo/open.PNG" alt="/" />
						<span id="hoursTime">10:00~20:00</span>
						<img src="/resources/images/facilityInfo/close.PNG" alt="/" />
					</h1>
				</div>
			</div>
			

		    <div id="div_calendar">
		      <div>
		      	

		        <div class="date_text">
		        	<span id="year"  >2020</span><span>-</span>
		        	<span id="month"  onchange="changeMonth(); ">01</span>
		        	<input type="hidden" onclick="changeMonth(-1);" id="fa1" value="" class="btn btnS" />
		        	<input type="button" onclick="changeMonth(1);" id="fa2" value="" class="btn btnS" />
		        </div>
		      </div>
		      <table id="t_body">
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
		  </div>
	  </div>
	 
	  <script>
	    let date = new Date();
	    //Date 객체를 사용하여 현재 날짜를 가져옵니다.
	    let y = date.getFullYear();
	    //getFullYear() 메서드로 현재 연도를 가져옵니다.
	    let m = ('0' + (date.getMonth() + 1)).slice(-2);
	    //getMonth() 메서드로 현재 월을 가져오는데, 월은 0부터 시작하므로 1을 더하고 두 자리로 표시하도록 조정합니다.
	    let d = ('0' + date.getDate()).slice(-2);
	    let today1 = document.getElementById("date_text");
	  	//getDate() 메서드로 현재 일을 가져오는데, 마찬가지로 두 자리로 표시하도록 조정합니다.	
	    today1.innerHTML = y + '-' + m  + '-' + d;
	    

		$("#fa1").val((Number(m) - 1) + "월");
		$("#fa2").val((Number(m) + 1) + "월");
		//해당 아이디에  이전 월과 다음 월 정보를 설정 합니다.
		//Number(m)를 사용하여 현재 월을 숫자로 변환하고 1을 더하거나 빼서 이전 월과 다음 월을 표시합니다.
		
		let current_year = (new Date()).getFullYear();
		let current_month = (new Date()).getMonth() + 1;
		
		loadData();
		
			    
	    function checkLeapYear(year) {//윤년 계산
	      if(year%400 == 0) {
	        return true;
	      }else if(year%100 == 0) {
	        return false;
	      }else if(year%4 == 0) {
	        return true;
	      }else {
	        return false;
	      }
	    }

	    function getFirstDayOfWeek(year, month) {//선택한 달의 1일 요일 구하기
	      if(month < 10) month = "0" + month;//month가 10보다 작으면 month앞에 "0"
	
	      return (new Date(year+"-"+month+"-01")).getDay(); //getDay () 메소드는 일주 (0-6), 하루 수를 반환
	    }
	
	    function changeYearMonth(year, month) {//버튼 클릭시 월별 날짜 구하기
	      let month_day = [31,28,31,30,31,30,31,31,30,31,30,31];//월별 마지막 날짜
	
	      if(month == 2) {
	        if(checkLeapYear(year)) month_day[1] = 29;//2월이면 윤년에 29일 표시
	      }
	
	      let first_day_of_week = getFirstDayOfWeek(year, month);
	      let arr_calendar = [];
	      for(let i=0 ; i<first_day_of_week ; i++){
	        arr_calendar.push("");
	      }
	      //연도)와 월에 해당하는 첫 번째 날의 요일을 계산하고, 빈 날짜를 (arr_calendar)에 추가하는 부분입니다. 
	      //월별 달력을 만들 때 1일 이전에 나오는 빈 칸을 만듭니다.
	
	      for(let i=1 ; i<=month_day[month-1] ; i++) {
	        arr_calendar.push(String(i));
	      }
	
	      let remain_day = 7 - (arr_calendar.length%7);//빈공간
	      if(remain_day < 7) {
	        for(let i=0 ; i<remain_day ; i++) {
	          arr_calendar.push("");
	        }
	      }
	     //for 루프를 사용하여 현재 월의 마지막 날짜까지 날짜를 arr_calendar 배열에 추가합니다.
		//month_day[month-1]은 현재 월의 마지막 날짜를 나타냅니다. month는 1부터 시작하므로 실제 배열 month_day에서는 인덱스가 0부터 시작합니다. 
		//month-1을 사용하여 현재 월의 마지막 날짜를 가져옵니다.
		//남은 빈 공간을 계산하고 필요한 만큼 빈 문자열을 배열에 추가합니다.
		//월별 달력은 7일씩 표시되므로, 날짜를 7로 나눈 나머지를 계산하여 빈 공간의 개수를 알아냅니다.
		//만약 remain_day가 7보다 작다면, 남은 빈 공간을 채우기 위해 for 루프를 사용하여 빈 문자열을 arr_calendar 배열에 추가합니다.
	
	      renderCalendar(arr_calendar);//renderCalendar() 메서드 실행하여 달력 생성
	    }
	
	    function renderCalendar(data) {
	      let h = [];

	      for(let i =0 ; i<data.length ; i++) {
	        if(i==0) {//첫주
	          h.push('<tr>');
	        }else if(i%7 == 0) {
	          h.push('</tr>');
	          h.push('<tr>');//다음주..
	        }
			
	        let dayValue = current_year + "-" +('0' + current_month).slice(-2);
	        console.log(dayValue);
	        
	        if(data[i] === ""){
		        h.push('<td style="background-color:#F7F5F5;"></td>');
	        } else {
	        	h.push('<td class="t_day" id="day' + data[i] + '" onclick="setDate(' + data[i] + ');" style="cursor:pointer;">' +
	        		    data[i] + '<span class="pooImg"></span>' +'<br />' +
	        		    '<input type="hidden" class="dateValue" value="' + dayValue + '-' + ('0' + data[i]).slice(-2) + '">' +
	        		    '<span class="time" id='+dayValue + '-' + ('0' + data[i]).slice(-2)+' style="font-size: 15px;"></span>' +
	        		    '</td>'); 
	        }
	        
	         
	      }
	
	      h.push('</tr>');
		//renderCalendar 함수 내에서 주어진 data 배열을 사용하여 월별 달력의 HTML을 동적으로 생성하는 부분입니다.
	
	      $("#tb_body").html(h.join(""));
		  for(let i=1 ; i<= $(".t_day").text().length; i++) {
			if(d == i && m == current_month && y == current_year){
				$("#day"+i).css("backgroundColor","#6495ED");
				$("#day" + i + " > span.pooImg").append('<img class="poo" src="/resources/images/facilityInfo/poo.PNG" alt="/" />');
				}
			
			}
		  
	    }//오늘날짜에 CSS를 추가
	    
	    
	    function setDate(day) {//선택할 날짜 가져가기
	    	$(".t_day").css("backgroundColor", "#EBF5FF"); 
	    	$(".poo").remove();
	    	$("#day"+day).css("backgroundColor","#6495ED");
	    	
	    	$("#day" + day + " > span.pooImg").append('<img class="poo" src="/resources/images/facilityInfo/poo.PNG" alt="/" />');
			
			let text_month = current_month;
			
	      	if(day<10) day = "0" + day;
	      	if(current_month<10) text_month = "0" +text_month;
			
	      	let dateText = current_year + "-" + text_month + "-" + day; 
	      	
	      	
	      	$("#date_text").text(dateText);
	      	$("#input_date").val(dateText);
	      	$("#hoursTime").text($("#"+dateText).text());
	      	
	    }//선택한 날짜에 CSS추가하고 나머지 부분 삭제.
	    //선택한 날짜와 운영시간을 해당 태그에서 보여줍니다.

	    
	    function changeMonth(diff) {
	      if(diff == undefined) {
	        current_month = parseInt($("#month").val());
	      }else {
	        current_month = current_month + diff;
	
	        if(current_month == 0) {//전년도로 바뀜
	          current_year = current_year - 1;
	          current_month = 12;
	        }else if(current_month == 13) {//다음년로 바뀜
	          current_year = current_year + 1;
	          current_month = 1;
	        }
	      }
	
	      loadCalendar();//다음달 버튼이 생기고 다음달 버튼을 눌렀을 경우 현재 달 버튼 생선
		    if((current_month) == Number(m)){
		    	$("#fa1").prop("type", "hidden");		    	
		    }else{
		    	$("#fa1").prop("type", "button");		    	
		    }
		    if((current_month) == (Number(m)+1)){
		    	$("#fa2").prop("type", "hidden");		    	
		    }else{
		    	$("#fa2").prop("type", "button");		    	
		    }
	    }
		
	    
	  
	    function loadCalendar() {
	      $("#year").text(current_year);
	      $("#month").text(("0" + current_month).slice(-2));
	    //연도와 월을 표시하는 HTML 요소의 내용을 current_year와 current_month 변수에 저장된 값으로 업데이트합니다
	      changeYearMonth(current_year,current_month);//현재 연도와 월에 맞게 달력을 변경
	    
	      	//이전 월과 다음 월을 계산
		    let previous_month = current_month -1
		    let next_month =current_month +1
		    if(previous_month === 0){
		    	$("#fa1").val(12 + "월");
		    }else{
		    	$("#fa1").val(previous_month + "월");
		    }
		    
		    if(next_month === 13){
		    	$("#fa2").val(1 + "월");	
		    }else{
		    	$("#fa2").val(next_month + "월");
		    }
		    loadData();
		    
	    }
		
	    function loadData(){
		    $("#year").text(current_year);
			$("#month").text(("0" + current_month).slice(-2));
		    changeYearMonth(current_year,current_month);//년 월 표시
			
		    
			$.ajax({//AJAX를 사용하여 서버로부터 운영 시간 데이터를 가져오는 부분입니다
			    url: '${pageContext.request.contextPath}/facilityInfo/operatingHours', // Spring 컨트롤러 엔드포인트 URL
			    type: 'POST',
			    data: { data : current_year+"-"+("0" + current_month).slice(-2)},//년 월 데이터
			    dataType: 'json', // 응답 데이터 형식이 JSON임을 지정
			    success: function(data) {
			        // 서버에서 받은 JSON 데이터를 JavaScript 배열로 파싱
			        let hoursList = data;
			        
			        for(let i=0;i<hoursList.length;i++){
			        	$("#"+hoursList[i].hoursDate).text(hoursList[i].hoursTime);
			        	//서버에서 가져온 운영 시간을 해당 날짜의 HTML 요소에 업데이트
			        	if(hoursList[i].hoursDate == $("#date_text").text()){
			        		$("#hoursTime").text(hoursList[i].hoursTime);
			        	}
			        }//현재 선택된 날짜와 가져온 운영 시간 데이터의 날짜를 비교하여, 
			        //현재 선택된 날짜와 동일한 경우 해당 날짜의 운영 시간을 표시
			        
			        
			    },
			    error: function() {
			        // 오류 처리
			        alert('데이터를 가져오는 데 실패했습니다.');
			    }
			}); 
	    }
	  </script>
	</body>
</html>