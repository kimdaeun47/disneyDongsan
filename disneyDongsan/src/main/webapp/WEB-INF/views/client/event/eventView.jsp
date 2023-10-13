<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

    <title>이벤트</title>

    <link rel="shortcut icon" href="/resources/image/icon.png" />
    <link rel="apple-touch-icon" href="/resources/image/icon.png" />

    <!--[if lt IE 9]>
    <script src="../js/html5shiv.js"></script>
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" src="/resources/include/js/common.js"></script>
    <script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>

    <style type="text/css">
    	h2 {margin: 50px;}
    
    
        .thumbnail > img { width: 320px; height: 200px; }
        .image > img { width: 100px; height: 100px; }



        /* 달력 css */
        .day{font-size: 35px; text-align:center;}
        .saturday {color: gray;}
        .sunday {color: red; }
        
        .calendar{text-align:center;}
        #calendar {margin:50px auto;}
        #calendar td{
        	text-align:center;
        	padding: 10px 20px;
        	border-radius: 50%;
    		overflow: hidden;
    	}
    	
    	.month {margin: 70px;}
        
        .week_calendar {
		    margin: 0 auto; 
		}
		
		.calendar, .calendar-header {
		    text-align: center !important; 
		}
   
/*         #prevWeekButton, #nextWeekButton { */
/* 	        margin: 0 auto; */
/* 	        display: block; /* 중앙 정렬을 위해 블록 요소로 변경 */ */
/* 	    } */
	    

		.calendar {
		    display: flex;
		    flex-direction: row;  
		    justify-content: space-between;  
		    align-items: center;  
		}
		
		#prevWeekButton,
		#nextWeekButton {
			margin: 0 20px;
			padding: 0;
		    background: none; 
		    border: none; 
		    cursor: pointer; 
		}
		
		#prevWeekButton img,
		#nextWeekButton img {
		    width: 30px;
		    height: 30px;
		    margin: 0;
		}
				
		#calendar-container {
		    display: flex;
		    flex-direction: row; 
		    justify-content: center;
		    align-items: center; 
		}  
		
		#calendar{margin: 0; margin-bottm: 50px;}
		
		#eventTableContainer{margin: 0 50px; padding: 50px;}
		
		
		 
        

        
        image {width: 100px; height: 100px;}
        
        .container {
	        box-sizing: border-box;
	        margin-left: 130px;
	    }
	
	    .clear {
	        clear: both;
	    }
	
	    .event_period {
	        margin-top: 50px;
	    }
	
	    .event_image {
	        margin-bottom: 50px;
	        text-align: center;
	        max-width: 100%; 
	        height: auto; 
	    }
	
 	    .modal-content { 
 	        margin: 0 auto; 
 	        text-align: left; 
	    } 
	
	    .carousel-inner > .carousel-item > img {
		    width: 100%; 
		    height: 400px; 
		}
	
	    /* 모달 창 크기 조정 */
 	    .modal-dialog { 
 		    max-width: 800px; 
	    	margin: 10px auto; 
		} 
		
		.modal-header {
	        background-color: #6A5ACD;
	        color: white;
	    }
		
		

		.text-center{text-align:center;}
		
		/* 선택된 날짜에 배경색을 적용 */
		.selected {
		    background-color: #6A5ACD; /
		    color: #FFFFFF; 
		}

		.calendar-yearmonth{
			font-size: 30px;
		}		
		
		
		/* 목록 css */
		.event-title {
			font-size: 30px;
			font-weight: 525;
			
		}
		
		

		
		
    </style>

    <script type="text/javascript">
        $(function(){
            /* 달력 함수 */
            var currentDate = new Date(); // 현재 날짜

            var options = {
                showDay: true,
                showFullDayName: true,
                showToday: true
            };
            
            // 페이지 로드 시 오늘 날짜 이벤트 로딩
            var today = new Date();
            getEventsForDate(today);

            function updateCalendar(date) {
                var currentDate = new Date(date);
                var html = "<table class='week_calendar'><tbody><tr>";

                for (var i = 0; i < 7; i++) {
                    var cellDate = currentDate.getDate();
                    var cellClass = "";

                    if (currentDate.getDay() === 0) {
                        cellClass = "sunday";
                    } else if (currentDate.getDay() === 6) {
                        cellClass = "saturday";
                    }

                    html += "<td data-date=\"" + currentDate.toISOString().substring(0, 10) + "\" class=\"day " + cellClass + "\">";

                    html += currentDate.toISOString().substring(8, 10);

                    html += "</td>";
                    currentDate.setDate(currentDate.getDate() + 1); // 다음 날짜로 이동
                }

                html += "</tr></tbody></table>";
                return html;
            }


            function setButtonsState() {
                var today = new Date();

                $("#prevWeekButton").prop("disabled", currentDate <= today);
            }

            var html = updateCalendar(currentDate);
            
            $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월 " +(currentDate.getDate()) + "일");
            $("#calendar").html(html);
            setButtonsState();

            $("#nextWeekButton").click(function() {
                currentDate.setDate(currentDate.getDate() + 7);
                var html = updateCalendar(currentDate);
                $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월");
                $("#calendar").html(html);
                setButtonsState();
            });

            $("#prevWeekButton").click(function() {
                if ($(this).prop("disabled")) {
                    return; 
                }

                currentDate.setDate(currentDate.getDate() - 7); // 이전 주로 이동
                var html = updateCalendar(currentDate);
                $(".calendar-yearmonth").html(currentDate.getFullYear() + "년 " + (currentDate.getMonth() + 1) + "월");
                $("#calendar").html(html);
                setButtonsState();
            });
            
            function getEventsForDate(date) {
                var clickedDate = date.toISOString().substring(0, 10);

                $.ajax({
            	    url: '/event/getEvents?selectedDate=' + clickedDate, 
            	    method: 'GET',
            	    success: function(data) {
            	        displayEvents(data);
            	    },
            	    error: function() {
            	        console.error('이벤트를 가져오는 중에 오류가 발생했습니다.');
            	    }
            	});
            }

            // 이벤트 목록 표시 함수
            function displayEvents(events) {
			    var eventTable = $('#eventTable tbody');
			    eventTable.empty(); 
			
			    if (events.length === 0) {
			        eventTable.append('<tr><td colspan="3">이 날짜에 이벤트가 없습니다.</td></tr>');
			    } else {
			        for (var i = 0; i < events.length; i++) {
			            var event = events[i];
			            eventTable.append('<tr><td class="col-md-3 event-thum"><img src="/dongsanStorage/event/' + event.e_thum +
			            		'" style="width:380px; height:240px;"></td><td class="event-content" data-event-id="' + event.e_no + '">'
			            		+ '<br/></br><br/><div class="event-time"><i class="bi bi-clock-fill"></i> ' +event.e_time + '</div>' +'<div class="event-title">' + event.e_title + '</div>' + '</td></tr>');
			        }
			    }
			}


            $('#calendar').on('click', 'td', function() {
                var clickedDate = $(this).data('date');
                if (clickedDate) {
                    $(this).addClass('selected');

                    $(this).siblings().removeClass('selected');
 
                    getEventsForDate(new Date(clickedDate));

                    var clickedDateObj = new Date(clickedDate);
                    var year = clickedDateObj.getFullYear();
                    var month = (clickedDateObj.getMonth() + 1); 
                    var day = clickedDateObj.getDate();

                    if (day < 10) {
                        day = '0' + day;
                    }

                    $('.calendar-yearmonth').text(year + '년 ' + month + '월 ' + day +'일');
                }
            });


		
            
            
          // 동적으로 생성된 요소 이벤트
          // 모달
          
          // 모달 열기
		    function openModal() {
		        var modalElement = document.getElementById('detailModal');
		        var modal = new bootstrap.Modal(modalElement);
		        modal.show();
		    }
		
		    // 모달 닫기
		    function closeModal() {
		        var modalElement = document.getElementById('detailModal');
		        var modal = new bootstrap.Modal(modalElement);
		        modal.hide();
		    }
		    
		    
		    //
           $('#eventTable').on('click', '.event-content, .event-thum', function() {
			    var eventId = $(this).closest('tr').find('.event-content').data('event-id'); // 수정된 부분
			    $.ajax({
			        url: '/event/eventDetail?e_no=' + eventId,
			        method: 'GET',
			        success: function (data) {
			            var modal = $('#detailModal');
			            modal.find('.modal-body').html(data);
			            console.log(data);
			            var modalFooter = modal.find('.modal-footer');
			            modalFooter.empty();
			            modalFooter.append('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>');
			            openModal(); // 모달 열기
			        },
			        error: function () {
			            console.error('이벤트 상세 정보를 가져오는 중에 오류가 발생했습니다.');
			        }
			    });
			});


            
         
           
            $(".event_time").each(function() {
		        let e_time = $(this).text();
		        if (e_time === "on") {
		            $(this).text("상시");
		        }
		    });

         
        }); // $ 종료
       
        

    </script>
</head>
<body>
	<div id="container">
	<div class="Row">
<!-- 	    <div class="text-center"><h2>이벤트</h2></div> -->
	    
	    <div class="calendar month">
	    	<h6>원하는 날짜를 선택해 주세요</h6>
	    	<hr/>
		    <div id="calendar-container">
		        <button id="prevWeekButton" disabled><img src="/resources/images/prevBtn.png" class="btnImg" style="width:30px; height: 30px;" /></button>
		        <div id="calendar"></div>
		        <button id="nextWeekButton"><img src="/resources/images/nextBtn.png" class="btnImg" style="width:30px; height: 30px;" /></button>
		    </div>
		    <hr/>
		</div>
		<div class="calendar-header">
	        <strong><span class="calendar-yearmonth"></span></strong>
	    </div>
	    <!-- 이벤트 목록 출력 테이블 -->
	    <div id="eventTableContainer">
	        <table id="eventTable" class="table">
	            <tbody>
	               
	            </tbody>
	        </table>
	    </div>
	    
	    <div id="detailModal" class="modal" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">이벤트 상세</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <jsp:include page="../../modal/eventDetail.jsp"></jsp:include>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>	
	</div>
</body>
</html>
