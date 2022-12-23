
// 모달 띄우기: 클럽세부
function modal_club() {
	const body = document.querySelector('body');
	const modal = document.querySelector('.modal');
	const openPopup = document.querySelectorAll('.open_modal');
	const closePopup = document.querySelector('.k_close_popup');
	
	//클릭 시: 열기
	for (var i = 0; i < openPopup.length; i++) {
		openPopup[i].addEventListener("click", () =>{

			//openPopup[i].style.color = 'blue';
			//모달 위치 설정 
			//console.log(window.scrollY);
			modal.style.top =  window.scrollY+'px';
			modal.classList.toggle('show');
			//console.log("check",i,"th");
		
			//스크롤 금지
			if (modal.classList.contains('show')) {
				body.style.overflow = 'hidden';
				}
		})
		//console.log(i);
		//index 값 저장할것
	}

	//회색영역 클릭 - 돌아가기
	modal.addEventListener('click', (event) => {
		if (event.target === modal) {
			modal.classList.toggle('show');
			if (!modal.classList.contains('show')) {
				body.style.overflow = 'auto';
				map[0].destroy();
			}
		}
	});

	//돌아가기 버튼 클릭 - 돌아가기
	closePopup.addEventListener('click', (event) => {
		modal.classList.toggle('show');
			if (!modal.classList.contains('show')) {
				body.style.overflow = 'auto';
				map[0].destroy();
			}
	});
};


// 모달 띄우기: 경로 세부 + 파티 신청 세부
function modal_more() {
	const body = document.querySelector('body');
	const modal = document.querySelector('.modal');
	const openPopup = document.querySelectorAll('.open_modal');
	const closePopup = document.querySelector('.k_close_popup');
	
	//클릭 시: 열기
	for (var i = 0; i < openPopup.length; i++) {
		openPopup[i].addEventListener("click", () =>{

			//openPopup[i].style.color = 'blue';
			//모달 위치 설정 
		//	console.log(window.scrollY);
			modal.style.top = window.scrollY+'px';
			modal.classList.toggle('show');
			//console.log("check",i,"th");
		
			//스크롤 금지
			if (modal.classList.contains('show')) {
				body.style.overflow = 'hidden';
				}
		})
		//console.log(i);
		//index 값 저장할것
	}

	//회색영역 클릭 - 돌아가기
	modal.addEventListener('click', (event) => {
		if (event.target === modal) {
			modal.classList.toggle('show');
			if (!modal.classList.contains('show')) {
				body.style.overflow = 'auto';
				map[0].destroy();
			}
		}
	});

	//돌아가기 버튼 클릭 - 돌아가기
	closePopup.addEventListener('click', (event) => {
		modal.classList.toggle('show');
			if (!modal.classList.contains('show')) {
				body.style.overflow = 'auto';
				map[0].destroy();
			}
	});
};



$(function(){
	//------------------------ 마우스 이벤트 css 처리 ------------------------ 
	//파티 박스
	$(".k_one_box").on({
		mouseenter: function() {
			$(this).css('border-color', '#FFD500');
		}, mouseleave: function() {
			$(this).css('border-color', '#fafafa');
		}
	})

	//추천 경로 박스
	$('.k_rec_path_list_view>li').on({
		mouseenter: function() {
			$(this).css('border-color', '#FFD500');
		}, mouseleave: function() {
			$(this).css('border-color', '#017935');
		}
	})

	//일반버튼
	$('.click-btn').on({
		mouseenter: function() {
			$(this).css('border-color', '#FFD500');
		}, mouseleave: function() {
			$(this).css('border-color', $(this).css("background-color"));
		}
	})

	//일반버튼 - white border
	$('.click-btn-w').on({
		mouseenter: function() {
			$(this).css('border-color', '#FFD500');
		}, mouseleave: function() {
			$(this).css('border-color', '#fafafa');
		}
	})

	//클릭버튼-배경
	$('.click-btn-l').on({
		mouseenter: function() {
			$(this).css('background-color', '#c7e5cb');
		}, mouseleave: function() {
			$(this).css('background-color', '#2fb86a');
		}
	})

	//클릭버튼-색
	$('.click-btn-c').on({
		mouseenter: function() {
			$(this).css('color', '#c7e5cb');
		}, mouseleave: function() {
			$(this).css('color', '#2fb86a');
		}
	})
})