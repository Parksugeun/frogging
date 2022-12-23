
// 마이페이지 - 탭 메뉴 변환
$(function(){
	// ------------- 주 ----------------
	$('.k_a_select_w').click(function(){
		//탭 변환
		$('.k_a_select_w').addClass("active");
		$('.k_a_select_m').removeClass("active");
		$('.k_a_select_y').removeClass("active");
		$('.k_a_select_t').removeClass("active");

		// 내용변환
		$('.k_weekly').css("display", "block");
		$('.k_monthly').css("display", "none");
		$('.k_yearly').css("display", "none");
		$('.k_totally').css("display", "none");

		//차트 변환
		$('#k_weekly_chart').css("display", "block");
		$('#k_monthly_chart').css("display", "none");
		$('#k_yearly_chart').css("display", "none");
		$('#k_totally_chart').css("display", "none");
	})

	// ------------- 월 ----------------
	$('.k_a_select_m').click(function(){
		//탭 변환
		$('.k_a_select_w').removeClass("active");
		$('.k_a_select_m').addClass("active");
		$('.k_a_select_y').removeClass("active");
		$('.k_a_select_t').removeClass("active");

		// 내용변환
		$('.k_weekly').css("display", "none");
		$('.k_monthly').css("display", "block");
		$('.k_yearly').css("display", "none");
		$('.k_totally').css("display", "none");

		//차트 변환
		$('#k_weekly_chart').css("display", "none");
		$('#k_monthly_chart').css("display", "block");
		$('#k_yearly_chart').css("display", "none");
		$('#k_totally_chart').css("display", "none");
	})

	// ------------- 년 ----------------
	$('.k_a_select_y').click(function(){
		//탭 변환
		$('.k_a_select_w').removeClass("active");
		$('.k_a_select_m').removeClass("active");
		$('.k_a_select_y').addClass("active");
		$('.k_a_select_t').removeClass("active");

		// 내용변환
		$('.k_weekly').css("display", "none");
		$('.k_monthly').css("display", "none");
		$('.k_yearly').css("display", "block");
		$('.k_totally').css("display", "none");

		//차트 변환
		$('#k_weekly_chart').css("display", "none");
		$('#k_monthly_chart').css("display", "none");
		$('#k_yearly_chart').css("display", "block");
		$('#k_totally_chart').css("display", "none");
	})

	// ------------- 총 ----------------
	$('.k_a_select_t').click(function(){
		//탭 변환
		$('.k_a_select_w').removeClass("active");
		$('.k_a_select_m').removeClass("active");
		$('.k_a_select_y').removeClass("active");
		$('.k_a_select_t').addClass("active");

		// 내용변환
		$('.k_weekly').css("display", "none");
		$('.k_monthly').css("display", "none");
		$('.k_yearly').css("display", "none");
		$('.k_totally').css("display", "block");

		//차트 변환
		$('#k_weekly_chart').css("display", "none");
		$('#k_monthly_chart').css("display", "none");
		$('#k_yearly_chart').css("display", "none");
		$('#k_totally_chart').css("display", "block");
	})

	
})

// ---------------------- 마이페이지 > 페이지 그리기---------
function draw_myplog() {
//	alert("표그리기");
	const ctx_w = document.getElementById('myChart_w').getContext('2d');
	const ctx_m = document.getElementById('myChart_m').getContext('2d');
	const ctx_y = document.getElementById('myChart_y').getContext('2d');
	const ctx_t = document.getElementById('myChart_t').getContext('2d');
	
	var w_data =[];
	var m_data =[];
	var y_data =[];
	var t_data =[];

	var w_label =[];
	var m_label =[];
	var y_label =[];
	var t_label =[];


	// 데이터 받아오기 
	$(function(){
		
		$.ajax({
			url: "/mypage/getUserRecord_w",
			success: function(result){
				//console.log(result);
				for (let index = (result.length-1); index >=0 ; index--) {
					//console.log(result[index].total_distance);
					//console.log(result[index].week.slice(-2, result[index].week.length)+"번째 주");
					w_data.push(result[index].total_distance);
					w_label.push(result[index].week.slice(-2, result[index].week.length)+"번째 주");
				}
				// ---------------------------------------- 주 그래프 ---------------------------
				const myChart_w = new Chart(ctx_w, {
					type: 'bar',
					data: {
							labels: w_label,
							datasets: [{
									label: 'km of Total',
									data: w_data,
									backgroundColor: 'rgba(0, 46, 20, 0.7)',
									borderColor: 'rgba(1, 121, 53, 1)',
									borderWidth: 1
							}]
					},
					options: {
							scales: {
									y: {
											beginAtZero: true
									}
							}
					}
				});

			}, error:function(e){
				console.log(e.responseText);
			}
		});

		$.ajax({
			url: "/mypage/getUserRecord_m",
			success: function(result){
				//console.log(result);
				for (let index = 0; index < result.length; index++) {
					//console.log(result[index].total_distance);
					//console.log(result[index].month+"월");
					m_data.push(result[index].total_distance);
					m_label.push(result[index].month+"월");
				}
			}, error:function(e){
				console.log(e.responseText);
			}
		});

		$.ajax({
			url: "/mypage/getUserRecord_y",
			success: function(result){
				//console.log(result);
				for (let index = 0; index < result.length; index++) {
					//console.log(result[index].total_distance);
					//console.log(result[index].month+"년");
					y_data.push(result[index].total_distance);
					y_label.push(result[index].year+"년");
				}
			}, error:function(e){
				console.log(e.responseText);
			}
		});
		$.ajax({
			url: "/mypage/getUserRecord_t",
			success: function(result){
				for (let index = 0; index < result.length; index++) {
					//console.log(result[index].total_distance);
					//console.log(result[index].month+"년");
					t_data.push(result[index].total_distance);
					t_label.push(result[index].date);
				}
			}, error:function(e){
				console.log(e.responseText);
			}
		});

	})

	
	


	// ---------------------------------------- 월 그래프 ---------------------------
	//console.log(m_data);
	const myChart_m= new Chart(ctx_m, {
    type: 'bar',
    data: {
        labels: m_label,
        datasets: [{
            label: 'km of Total',
            data: m_data,
            backgroundColor: 'rgba(0, 46, 20, 0.7)',
            borderColor: 'rgba(1, 121, 53, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
	});



	// ---------------------------------------- 연 그래프 ---------------------------
	const myChart_y= new Chart(ctx_y, {
    type: 'bar',
    data: {
        labels: y_label,
        datasets: [{
            label: 'km of Total',
            data: y_data,
            backgroundColor: 'rgba(0, 46, 20, 0.7)',
            borderColor: 'rgba(1, 121, 53, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
	});


	// ---------------------------------------- 총 그래프 ---------------------------
	const myChart_t= new Chart(ctx_t, {
    type: 'bar',
    data: {
        labels: t_label,
        datasets: [{
            label: 'km of Total',
            data: t_data,
            backgroundColor: 'rgba(0, 46, 20, 0.7)',
            borderColor: 'rgba(1, 121, 53, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
	});


}

// ---------------------- 관리자페이지 > 전체 통계 ---------
function draw_adminplog() {
	const ctx_p = document.getElementById('myChart_p').getContext('2d');
	const ctx_u_1 = document.getElementById('myChart_u_1').getContext('2d');
	const ctx_u_2 = document.getElementById('myChart_u_2').getContext('2d');
	const ctx_t = document.getElementById('myChart_t').getContext('2d');

	
	var p_data_k =[];
	var p_data_s =[];
	var p_data_c =[];
	var p_data_t =[];
	var p_label =[];

	var t_data =[];
	var t_label =[];


	// 데이터 받아오기 
	$(function(){
		

		$.ajax({
			url: "/admin/getPlogData",
			success: function(result){
				//console.log(result);
				p_data_k, p_data_s, p_data_c , p_data_t , p_label  =[];

				// console.log("--"+p_data_c);
				for (let index = (result.length-1); index >=0 ; index--) {
					//console.log(result[index].total_distance);
					//console.log(result[index].month);
					p_data_k.push(result[index].total_distance);
					p_data_s.push(result[index].total_step/1000);
					p_data_c.push(result[index].plog_count);
					p_data_t.push(result[index].total_time/60);
					p_label.push(result[index].month+"월");
				}
				//console.log(p_data_c);		
				//console.log(p_data_k);
				// -------------------------플로깅 그래프: 횟수/걸음-거리 ---------------------------
								
				const myChart_p = new Chart(ctx_p,{
					type: 'line',
					data: {
						labels: p_label,
						datasets: [{ 
							data: p_data_k,
							label: "거리(KM)",
							borderColor: "#3e95cd",
							fill: false
						}, { 
							data:  p_data_c,
							label: "플로깅 횟수",
							borderColor: "#8e5ea2",
							fill: false
						}, { 
							data:  p_data_s,
							label: "걸음수(1/1000step)",
							borderColor: "#3cba9f",
							fill: false
						},{ 
							data: p_data_t,
							label: "시간(hours)",
							borderColor: "#e8c3b9",
							fill: false
						}]
					},options: {
						title: {
							display: true,
							text: 'Plog Datas per Months'
						}
					}
				}); 
			}, error:function(e){
				console.log(e.responseText);
			}
		});



		$.ajax({
			url: "/admin/getUserData",
			success: function(result){
				console.log(result);
				// ----------------- 유저 그래프 (일반/불량유저 활성/비활성 유저)---------------------------
				const myChart_u_1= new Chart(ctx_u_1, {
					type: 'doughnut',
					data: {
						labels: ["불량" ,"일반"],
						datasets: [
							{
								label: "Population (millions)",
								backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
								data: [result[0], result[1]]
							}
						]
					},
					options: {
						title: {
							display: true,
							text: '일반/불량 유저 비율'
						}
					}
				});

				const myChart_u_2= new Chart(ctx_u_2, {
					type: 'doughnut',
					data: {
						labels: ["비활성", "활성"],
						datasets: [
							{
								label: "Population (millions)",
								backgroundColor: ["#3cba9f","#e8c3b9","#c45850"],
								data: [result[2], result[3]]
							}
						]
					},
					options: {
						title: {
							display: true,
							text: '활성/비활성 유저 비율'
						}
					}
			});
			}, error:function(e){
				console.log(e.responseText);
			}
		});
	})



	$.ajax({
		url: "/admin/getTrashData",
		success: function(result){
			for (let index = 0; index <result.length ; index++) {
				t_data.push(result[index].trash_sum);
				t_label.push(result[index].month+"월");
			}
			// --------------------- 모은 쓰레기 그래프 ---------------------------
			const myChart_t= new Chart(ctx_t, {
				type: 'bar',
				data: {
					labels: t_label,
					datasets: [
						{
							label: "주운 쓰레기(Liter)",
							backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
							data: t_data
						}
					]
				},
				options: {
					legend: { display: false },
					title: {
						display: true,
						text: 'Collecte Trashes per Months'
					}
				}
		});

				}, error:function(e){
					console.log(e.responseText);
				}
			});
			


	
}





