	var map = new Array();
	var marker_s, marker_e, marker_p1, marker_p2;
	var marker;
	var markerArr = [];
	var markers = [];
	var lonlat;
	var totalMarkerArr = [];
	var drawInfoArr = [];
	var resultdrawArr = [];
	var infoWindow;
	var count = 0;
	var address = new Array();
	var tDistance;
	var tTime;
	
	function mapLoad(map_arr, detail_arr){
		for(let i = 0; i < map_arr.length; i++){
			setTimeout(() => {
				if(map_arr[i].type == 1){
					var lat = new Array();
					var log = new Array();
					console.log(i);
					map[i] = new Tmapv2.Map("map_div_"+map_arr[i].activity_no, {
						center : new Tmapv2.LatLng(37.56520450, 126.98702028),
							width : "100%",
							height : "100%",
							zoom : 15,
							zoomControl : false,
							scrollwheel : false,
							httpsMode : true
						});
					if(map_arr[i].activity_no == 99999){
						$('#map_div_99999').css('width', '500px');
						$('#map_div_99999').css('height', '400px');
						map[i].resize();
					}
					for(var j = 0; j < detail_arr.length; j++){
						if(map_arr[i].activity_no == detail_arr[j].activity_no){
							if(detail_arr[j].waypoint == 0){
								map[i].setCenter(new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log));
							}
							lat.push(detail_arr[j].lat);
							log.push(detail_arr[j].log);
							
							if(detail_arr[j].waypoint == 0){
								//console.log("start marker");
								marker_s = new Tmapv2.Marker({
										position : new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log),
										icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map[i],
										zIndex : 99999
									});
								//markers.push(marker_s);
							} else if (detail_arr[j].waypoint == 1){
								//console.log("end marker");
								marker_e = new Tmapv2.Marker({
										position : new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log),
										icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map[i],
										zIndex : 99999
									});
								//markers.push(marker_e);
							} else {
								//console.log("waypoint marker");
								marker = new Tmapv2.Marker({
										position: new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log), //Marker의 중심좌표 설정.
										icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+(detail_arr[j].waypoint-1)+".png",
										iconSize : new Tmapv2.Size(24, 38),
										map: map[i], //Marker가 표시될 Map 설정.
										zIndex : 99999
									});
								//markers.push(marker);
							}
						}	
					}
					//console.log(markers);
					searchRoute(lat, log, map[i]);
					setBoundary(lat, log, map[i]);
					//setTimeout(searchRoute, 1500, lat, log, map[i]);
				} else if(map_arr[i].type == 2){
					//console.log("type : 2");
					var lat = new Array();
					var log = new Array();
					var point = [];
					var end_point;
					var start_point;
					
					//console.log(i);
					map[i] = new Tmapv2.Map("map_div_"+map_arr[i].activity_no, {
						center : new Tmapv2.LatLng(37.56520450, 126.98702028),
							width : "100%",
							height : "100%",
							zoom : 15,
							zoomControl : false,
							scrollwheel : false
						});
					if(map_arr[i].activity_no == 99999){
						$('#map_div_99999').css('width', '500px');
						$('#map_div_99999').css('height', '400px');
						map[i].resize();
					}
						for(var j = 0; j < detail_arr.length; j++){
							if(map_arr[i].activity_no == detail_arr[j].activity_no){
								if(detail_arr[j].waypoint == 0){
									start_point = new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log)
									map[i].setCenter(start_point);
									marker_s = new Tmapv2.Marker({
										position : new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log),
										icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map[i],
										zIndex : 99999
									});
									point.push(start_point);
								}
								if(detail_arr[j].waypoint != 1){
									point.push(new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log));
								}else{
									end_point = new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log);
									marker_e = new Tmapv2.Marker({
										position : new Tmapv2.LatLng(detail_arr[j].lat, detail_arr[j].log),
										icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map[i],
										zIndex : 99999
									});
								}
							}
						}
						point.push(end_point);
						
						drawLine(point, map[i]);
						setBoundary(point, map[i]);
				}
			}, i * 500)
		}
	}
	//----------------------------------------------------------------------
	function addComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	function drawLine(arrPoint, maplist) {
		var polyline_;

		polyline_ = new Tmapv2.Polyline({
			path : arrPoint,
			strokeColor : "#DD0000",
			strokeWeight : 6,
			map : maplist
		});
		resultdrawArr.push(polyline_);
	}
	
	function clearLine(){
		if (resultdrawArr.length > 0) {
			for ( var i in resultdrawArr) {
				resultdrawArr[i]
						.setMap(null);
			}
			resultdrawArr = [];
		}
		
		drawInfoArr = [];
	}

	
	function removeMarkers() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}
	
	function selectMarker(location){
		infoWindow = new Tmapv2.InfoWindow();
		console.log(location);
		infoWindow.setMap(map);
		infoWindow.setPosition(location);
		infoWindow.setContent(
				'<div style = "width : 200px;">'+
					'<div>start</div>'+
					'<div>end<div>'+
					'<div>waypoint</div>'+
				'</div>'
				);
		infoWindow.draw();
	}
	
	function setBoundary(point, map){
		
		var boundary = new Tmapv2.LatLngBounds();
		
		for(let i = 0; i < point.length; i++){
			boundary.extend(point[i]);
		}
		map.fitBounds(boundary);
	}
	
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
	}
	
	function modal_data(no) {
		$(function(){
			for(let i = 0; i < map_arr.length; i++){
				if(map_arr[i].activity_no == no){
					let map_arr_view = [];
					let user_arr_view = [];
					
					map_arr_view.push({
						activity_no : 99999,
						course_name : map_arr[i].course_name,
						course_no : map_arr[i].course_no,
						distance : map_arr[i].distance,
						time : map_arr[i].time,
						step : map_arr[i].step,
						amount_trash : map_arr[i].amount_trash,
						date : map_arr[i].date,
						sort : map_arr[i].sort,
						type : 2 
					});
					
					for(let j = 0; j < detail_arr.length; j++){
						if(map_arr[i].activity_no == detail_arr[j].activity_no){
							user_arr_view.push({
								activity_no : 99999,
								course_no : detail_arr[j].course_no,
								lat : detail_arr[j].lat,
								log : detail_arr[j].log,
								waypoint : detail_arr[j].waypoint
							})
						}
					}
					
					$('#k_coursename>span').html(map_arr_view[0].course_name);
					$('#k_time>span').html(map_arr_view[0].time+" 분");
					$('#k_distance>span').html(map_arr_view[0].distance+" km");
					$('#k_step>span').html(map_arr_view[0].step+" 걸음");
					$('#k_date>span').html(map_arr_view[0].date);
					$('#k_trash>span').html(map_arr_view[0].amount_trash+" L");
					$('.k_path_map').attr('id', 'map_div_'+99999);
					mapLoad(map_arr_view, user_arr_view);
				}
			}
		})
	}