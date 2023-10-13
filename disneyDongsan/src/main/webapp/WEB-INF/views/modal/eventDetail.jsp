<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style type="text/css">
    	.bi-calendar4-week{
		    font-size: 50px;
		    line-height: 22px;
		}
		.bi-clock{
		    font-size: 50px;
		    line-height: 22px;
		}
		.icon{
			margin: 30px;
		}
		 
		.event_title{
			margint: 20px;
		}
		
		.carousel {
		    max-height: 400px; 
		    margin: 10px auto; 
		}
		
		
		
		.event_content {
			margin: 15px;
			margin-bottom: 100px;
		}
		
		
		.event_timeInfo {
		    display: flex;
		    justify-content: space-between;
		    padding: 10px;
		    margin-top: 20px;
		}
		
		.event_time {
		    flex-basis: 48%;
		    text-align: center;
		    border: 2px solid #000;
		    box-sizing: border-box; 
		    border-radius: 5%;
		}
		.event_period {
		    margin-top: 0;
		    flex-basis: 48%;
		    text-align: center;
		    border: 2px solid #000;
		    box-sizing: border-box; 
		    height: 250px; 
		    border-radius: 5%;
		}
		
		
    </style>
		 <div class="event_title"><h3>${detail.e_title }</h3></div> <br/>
		
   		<div>
            <div class="event_image">
	            <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="/dongsanStorage/event/${detail.e_img1 }" class="d-block w-100" alt="..." style="max-width: 100%; max-height: 100%; display: block; margin: 0 auto;">
				    </div>
				    <div class="carousel-item">
				      <img src="/dongsanStorage/event/${detail.e_img2 }" class="d-block w-100" alt="..." style="max-width: 100%; max-height: 100%; display: block; margin: 0 auto;">
				    </div>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
            </div>
            
           
            <div class="event_content">${detail.e_content }</div>
            
            <div class="event_timeInfo">
            	<div class="event_period">
            		<div class="icon">
			          <i class="bi bi-calendar4-week"></i>
			        </div>
            		<h5>이벤트 기간</h5>
            		<br/>
            		${detail.e_start }<br/>${detail.e_end }
            	</div>
            	
            	<div class="event_time">
            		<div class="icon">
			          <i class="bi bi-clock"></i>
			        </div>
            		<h5>이벤트 시간</h5>
            		<br/>
            		${detail.e_time }
            	</div>
            </div>
        </div>
