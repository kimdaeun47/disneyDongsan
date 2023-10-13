<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!--         <style>
            /* 마우스 한번클릭후 */
            .sidebar-nav .nav-item a:visited{
                color: black;
            }
        </style> -->
	<script>
	$(function() {
	    // 클릭한 항목의 클래스 정보를 로컬 스토리지에 저장
	    $('.sidebar-nav .nav-item a').click(function() {
	        let clickedItem = $(this).attr('href'); // 혹은 다른 식별자를 사용할 수 있음
	        localStorage.setItem('clickedItem', clickedItem);
	        
	        $(this).parent().parent().parent().children('a').removeClass('collapsed');
	    });


	    // 페이지 로드 시 로컬 스토리지에서 클래스 정보를 가져와 적용
	    let savedItem = localStorage.getItem('clickedItem');
	    $('.sidebar-nav .nav-item a[href="/admin/adminPage"]').addClass('collapsed');
	    if (savedItem) {
	    	if(savedItem == '/admin/adminPage') {
	            $('.sidebar-nav .nav-item a[href="' + savedItem + '"]').removeClass('collapsed');
	            
	    	}
	        // 자신을 클릭한 경우에만 addClass를 수행하도록 조건을 추가
	        if (savedItem !== '/admin/adminPage') {
	            $('.sidebar-nav .nav-item a[href="' + savedItem + '"]').removeClass('collapsed');
	            $('.sidebar-nav .nav-item a[href="' + savedItem + '"]').parent().parent().parent().children('a').removeClass('collapsed');
	            $('.sidebar-nav .nav-item a[href="' + savedItem + '"]').parent().parent().addClass('show');
	            $('.sidebar-nav .nav-item a[href="' + savedItem + '"]').parent().parent().parent().children('a').attr('aria-expanded','true');
	        }
	    } 
	});
	</script>


<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

	<ul class="sidebar-nav" id="sidebar-nav">

		<li class="nav-item"><a class="nav-link " href="/admin/adminPage">
				<i class="bi bi-grid"></i> <span>Dashboard</span>
		</a></li>
		<!-- End Dashboard Nav -->
		
		
		<!-- 회원 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/member/memberList"> <i class="bi bi-menu-button-wide"></i> <span>회원 관리</span>
		</a></li>
		
		
		<!-- 회원 티켓 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/ticketOrderList"> <i class="bi bi-menu-button-wide"></i> <span>회원 티켓 관리</span>
		</a></li>
		

		<!-- 굿즈 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
		data-bs-target="#goodsList" data-bs-toggle="collapse" href="#">
				<i class="bi bi-menu-button-wide"></i><span>굿즈 관리</span> <i
				class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="goodsList" class="nav-content collapse "
				data-bs-parent="#sidebar-nav">
				<li><a href="/admin/goodsList"><i
						class="bi bi-circle"></i> <span>굿즈 리스트</span></a></li>
				<li><a href="/admin/deliveryList"><i
						class="bi bi-circle"></i> <span>배송 관리</span></a></li>
			</ul>
<!-- 			<ul id="goodsList" class="nav-content collapse "
				data-bs-parent="#sidebar-nav">
				<li><a href="/admin/deliveryList"><i
						class="bi bi-circle"></i> <span>배송 관리</span></a></li>
			</ul> -->
		</li>
		

		<!-- 운영 시간 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/operatingHours"> <i class="bi bi-menu-button-wide"></i> <span>운영 시간 관리</span>
		</a></li>
		

		<!-- 즐길거리 관리(추천동선, 어트랙션, 레스토랑) -->
		<li class="nav-item"><a class="nav-link collapsed"
			data-bs-target="#joyList" data-bs-toggle="collapse" href="#">
				<i class="bi bi-menu-button-wide"></i><span>즐길거리 관리</span> <i
				class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="joyList" class="nav-content collapse "
				data-bs-parent="#sidebar-nav">
				<li><a href="/admin/routeList"><i
						class="bi bi-circle"></i> <span>추천동선 관리</span></a></li>
				<li><a href="/admin/rideList"><i
						class="bi bi-circle"></i> <span>어트랙션 관리</span></a></li>
				<li><a href="/admin/restaurantList"><i
						class="bi bi-circle"></i> <span>레스토랑 관리</span></a></li>
			</ul>
<!-- 			<ul id="joyList" class="nav-content collapse "
				data-bs-parent="#sidebar-nav">
				<li><a href="/admin/rideList"><i
						class="bi bi-circle"></i> <span>어트랙션 관리</span></a></li>
			</ul>
			<ul id="joyList" class="nav-content collapse "
				data-bs-parent="#sidebar-nav">
				<li><a href="/admin/restaurantList"><i
						class="bi bi-circle"></i> <span>레스토랑 관리</span></a></li>
			</ul> -->
		</li>
		
			
		<!-- 1:1문의 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/answerList"> <i class="bi bi-menu-button-wide"></i> <span>1:1문의 관리</span>
		</a></li>
		
			
		<!-- 메인화면 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/mainList"> <i class="bi bi-menu-button-wide"></i> <span>메인 페이지 관리</span>
		</a></li>
		
			
		<!-- 이벤트 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/event/eventList"> <i class="bi bi-menu-button-wide"></i> <span>이벤트 관리</span>
		</a></li>
		
			
		<!-- 공지사항 관리 -->
		<li class="nav-item"><a class="nav-link collapsed"
			href="/admin/notice/noticeList"> <i class="bi bi-menu-button-wide"></i> <span>공지 사항 관리</span>
		</a></li>
			
	</ul>	
		

</aside>
<!-- End Sidebar-->