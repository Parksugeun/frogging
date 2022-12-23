	var map;
	var marker_s, marker_e;
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
	

	$(function(){
		var lat = new Array();
		var lon = new Array();
		
		$("#courseForm").submit(function(){
			
			event.preventDefault();
			
			for(var i = 0; i < markers.length; i++){
				lat[i] = markers[i].getPosition().lat();
				lon[i] = markers[i].getPosition().lng();
				console.log("lat : " + markers[i].getPosition().lat());
				console.log("lon : " + markers[i].getPosition().lng());
				console.log("address : " + address[i]);
			}
			
			var course_name = $("#course_name").val();
			var course_info = $("#course_info").val();
			
			$.ajax({
				type : 'POST',
				url : '/maps/mapsOk',
				data : {"lat": lat, "log": lon, "distance" : tDistance, "time" : tTime, "course_name" : course_name, "course_info" : course_info, "address" : address, "type": 1},
				success: function(result){
					window.location.href = '/maps/tmap02';
				}, error: function(e){
					console.log(e.responseText);
					alert("코스 등록에 실패하였습니다.");
				}
			});
		});
	});
	window.onload = function initTmap() {
		// 1. 지도 띄우기
		map = new Tmapv2.Map("map_div", {
		center : new Tmapv2.LatLng(37.56520450, 126.98702028),
			width : "100%",
			height : "400px",
			zoom : 17,
			zoomControl : true,
			scrollwheel : true
		});
		
		// 현재 위치 HTML Geolocaiton 을 통해 확인 GPS 아님
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				(position) => {
					var lat = position.coords.latitude;
					var lon = position.coords.longitude;

					marker = new Tmapv2.Marker({
						position : new Tmapv2.LatLng(lat,lon),
						map : map
					});

					map.setCenter(new Tmapv2.LatLng(lat,lon));
					map.setZoom(15);
					map.MousePosition(true);
					console.log(new Tmapv2.LatLng(lat,lon));
					console.log(map.getCenter());
				}, showError);
		}
		map.addListener("click", onClick); //map 클릭 이벤트를 등록합니다.
		map.addListener("contextmenu", onrightClick);

	}

function showError(error) {
	  switch(error.code) {
	    case error.PERMISSION_DENIED:
	    alert("User denied the request for Geolocation.");
	      break;
	    case error.POSITION_UNAVAILABLE:
	    alert("Location information is unavailable.");
	      break;
	    case error.TIMEOUT:
	    alert("The request to get user location timed out.");
	      break;
	    case error.UNKNOWN_ERROR:
	    alert("An unknown error occurred.");
	      break;
	  	}
	}

	function addComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	function drawLine(arrPoint) {
		var polyline_;

		polyline_ = new Tmapv2.Polyline({
			path : arrPoint,
			strokeColor : "#DD0000",
			strokeWeight : 6,
			map : map
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
	function onClick(e){
		// 클릭한 위치에 새로 마커를 찍기 위해 이전에 있던 마커들을 제거
		//removeMarkers();
		
		lonlat = e.latLng;
		console.log(lonlat.lat(),lonlat.lng());
		//selectMarker(location);
		//Marker 객체 생성.
		if(count == 0){
			marker_s = new Tmapv2.Marker(
					{
						position : new Tmapv2.LatLng(lonlat.lat(),lonlat.lng()),
						icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
						iconSize : new Tmapv2.Size(24, 38),
						map : map
					});
			count++;
			markers.push(marker_s);
			reverseGeo(lonlat.lng(), lonlat.lat(), 0);
		} else if(count == 1){
			marker_e = new Tmapv2.Marker(
					{
						position : new Tmapv2.LatLng(lonlat.lat(),lonlat.lng()),
						icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
						iconSize : new Tmapv2.Size(24, 38),
						map : map
					});
			count++;
			markers.push(marker_e);
			reverseGeo(lonlat.lng(), lonlat.lat(), 1);
		} else {
			if(markers[0] == null){
				marker_s = new Tmapv2.Marker(
						{
							position : new Tmapv2.LatLng(lonlat.lat(),lonlat.lng()),
							icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map
						});
				markers[0] = marker_s;
				reverseGeo(lonlat.lng(), lonlat.lat(), 0);
			} else {
				if(count >= 7){
					alert("경유지는 최대 5개까지 가능합니다.");
					return false;
				}
				marker = new Tmapv2.Marker({
					position: new Tmapv2.LatLng(lonlat.lat(),lonlat.lng()), //Marker의 중심좌표 설정.
					icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+(count-1)+".png",
					iconSize : new Tmapv2.Size(24, 38),
					map: map //Marker가 표시될 Map 설정.
				});
				count++;
				markers.push(marker);
				add_textbox();
				reverseGeo(lonlat.lng(), lonlat.lat(), 2);
			}
		}
		
		if(count > 1){
			searchRoute();
		}
		console.log(map.getDiv());
		//console.log(markers[markers.length-1].getPosition()._lat);
	}
	
	function onrightClick(e){
		if(count > 0){
			markers[markers.length - 1].setMap(null);
			markers.pop();
			address.pop();
			$('.searchWaypoint').last().remove();
			$('.waypoint_button').last().remove();
			if(waypoint_number > 0) {
				waypoint_number--;
			}
			if(count > 0){
				if(count == 1){
					document.getElementById("searchStart").value = "";
				}else if(count == 2){
					document.getElementById("searchEnd").value = "";
				}
				count--;
			}
			
			if(count > 1){
				searchRoute();
			}else{
				clearLine();
			}
		}
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
	
	// 경로 찾기
	function searchRoute(){
		// 3. 경로탐색 API 사용요청
		if(markers[0] == null){
			alert("출발지 미정");
			return false;
		}
		console.log(markers[0].getPosition()._lat + " " + markers[0].getPosition()._lng);
		console.log(markers[1].getPosition()._lat + " " + markers[1].getPosition()._lng);
		var waypoint = "";
		for (var i = 2; i < markers.length; i++){
			waypoint += markers[i].getPosition()._lng + ",";
			waypoint += markers[i].getPosition()._lat;
			if(i == markers.length - 1){
				break;
			}
			waypoint += "_";
		}
		$.ajax({
					method : "POST",
					url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",
					async : false,
					data : {
						"appKey" : "l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2",
						"startX" : markers[0].getPosition()._lng,
						"startY" : markers[0].getPosition()._lat,
						"endX" : markers[1].getPosition()._lng,
						"endY" : markers[1].getPosition()._lat,
						"passList" : waypoint,
						"reqCoordType" : "WGS84GEO",
						"resCoordType" : "EPSG3857",
						"startName" : "출발지",
						"endName" : "도착지"
					},
					success : function(response) {
						console.log(response);
						var resultData = response.features;

						//결과 출력
						tDistance = ((resultData[0].properties.totalDistance) / 1000)
										.toFixed(1);
						tTime = ((resultData[0].properties.totalTime) / 60)
										.toFixed(0);

						$("#result").text("예상 거리 : " + tDistance +"km / 예상 소요 시간 : "+ tTime + "분");
						
						//기존 그려진 라인 & 마커가 있다면 초기화
						if (resultdrawArr.length > 0) {
							for ( var i in resultdrawArr) {
								resultdrawArr[i]
										.setMap(null);
							}
							resultdrawArr = [];
						}
						
						drawInfoArr = [];

						for ( var i in resultData) { //for문 [S]
							var geometry = resultData[i].geometry;
							var properties = resultData[i].properties;
							var polyline_;


							if (geometry.type == "LineString") {
								for ( var j in geometry.coordinates) {
									// 경로들의 결과값(구간)들을 포인트 객체로 변환 
									var latlng = new Tmapv2.Point(
											geometry.coordinates[j][0],
											geometry.coordinates[j][1]);
									// 포인트 객체를 받아 좌표값으로 변환
									var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
											latlng);
									// 포인트객체의 정보로 좌표값 변환 객체로 저장
									var convertChange = new Tmapv2.LatLng(
											convertPoint._lat,
											convertPoint._lng);
									// 배열에 담기
									drawInfoArr.push(convertChange);
								}
							} else {
								var markerImg = "";
								var pType = "";
								var size;

								if (properties.pointType == "S") { //출발지 마커
									markerImg = "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
									pType = "S";
									size = new Tmapv2.Size(24, 38);
								} else if (properties.pointType == "E") { //도착지 마커
									markerImg = "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
									pType = "E";
									size = new Tmapv2.Size(24, 38);
								} else { //각 포인트 마커
									markerImg = "https://topopen.tmap.co.kr/imgs/point.png";
									pType = "P";
									size = new Tmapv2.Size(8, 8);
								}

								// 경로들의 결과값들을 포인트 객체로 변환 
								var latlon = new Tmapv2.Point(
										geometry.coordinates[0],
										geometry.coordinates[1]);

								// 포인트 객체를 받아 좌표값으로 다시 변환
								var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
										latlon);

								var routeInfoObj = {
									markerImage : markerImg,
									lng : convertPoint._lng,
									lat : convertPoint._lat,
									pointType : pType
								};
								/*
								// Marker 추가
								marker_p = new Tmapv2.Marker(
										{
											position : new Tmapv2.LatLng(
													routeInfoObj.lat,
													routeInfoObj.lng),
											icon : routeInfoObj.markerImage,
											iconSize : size,
											map : map,
											zIndex : 99999
										});
								*/
							}
						}//for문 [E]
						
						var boundary = new Tmapv2.LatLngBounds();
						
						for(let z = 0; z < markers.length; z++){
							var point = new Tmapv2.LatLng(markers[z].getPosition()._lat, markers[z].getPosition()._lng);
							boundary.extend(point);
						}
						map.fitBounds(boundary);
						drawLine(drawInfoArr);
						
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});
	}
	
	// 장소 검색
	function searchPlace(word, number){
		var searchKeyword = word;
		var resultNumber = 0;
		$.ajax({
			method:"GET",
			url:"https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
			async:false,
			data:{
				"appKey" : "l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2",
				"searchKeyword" : searchKeyword,
				"resCoordType" : "EPSG3857",
				"reqCoordType" : "WGS84GEO",
				"count" : 10
			},
			success:function(response){
				var resultpoisData = response.searchPoiInfo.pois.poi;
				
				// 기존 마커, 팝업 제거
				if(markerArr.length > 0){
					for(var i in markerArr){
						markerArr[i].setMap(null);
					}
				}
				var innerHtml ="";	// Search Reulsts 결과값 노출 위한 변수
				var positionBounds = new Tmapv2.LatLngBounds();		//맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
				
				for(var k in resultpoisData){
					resultNumber = k;
					var noorLat = Number(resultpoisData[k].noorLat);
					var noorLon = Number(resultpoisData[k].noorLon);
					var name = resultpoisData[k].name;
					
					var pointCng = new Tmapv2.Point(noorLon, noorLat);
					var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
					
					var lat = projectionCng._lat;
					var lon = projectionCng._lng;
					
					var markerPosition = new Tmapv2.LatLng(lat, lon);
					
					marker = new Tmapv2.Marker({
				 		position : markerPosition,
				 		//icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
				 		icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
						iconSize : new Tmapv2.Size(24, 38),
						title : name,
						map:map,
						zIndex : 99999
				 	});

					innerHtml += "<li onclick = 'setPointbyli("+ markerPosition +"," + number +")'><img src='https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>"+name+"</span></li>";
					
					markerArr.push(marker);
					positionBounds.extend(markerPosition);	// LatLngBounds의 객체 확장
				}
				
				for(let k = 0; k < resultNumber; k++){
					var temp_position = markerArr[k].getPosition();
					
					markerArr[k].addListener("click", function(evt) {
						setPoint(markerArr[k].getPosition(), number);
					});
				}
				$("#searchResult").html(innerHtml);	//searchResult 결과값 노출
				map.panToBounds(positionBounds);	// 확장된 bounds의 중심으로 이동시키기
				map.zoomOut();
				
			},
			error:function(request,status,error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	// marker를 클릭해서 위치 경로 설정
	function setPoint(position, number){
		if(number == 0){
			if(count == 0 || markers[0] == null){
				marker_s = new Tmapv2.Marker(
						{
							position : position,
							icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map,
							zIndex : 99999
						});
				count = 1;
				if(markers[1] != null){
					count = 2;
				}
				markers[0] = marker_s;
			} else {
				marker_s.setPosition(position);
			}
			if(count > 1){
				searchRoute();
			}
		}else if(number == 1){
			if(count < 2){
				marker_e = new Tmapv2.Marker(
						{
							position : position,
							icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map,
							zIndex : 99999
						});
				count = 2;
				markers[1] = marker_e;
			} else {
				marker_e.setPosition(position);
			}
			if(count > 1 && markers[0] != null){
				searchRoute();
			}
		}else if(number == 2){
			if(count < 2){
				alert('출발지, 도착지부터 선택해주세요.');
				return false;
			} else {
				marker = new Tmapv2.Marker({
					position: position, //Marker의 중심좌표 설정.
					icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+(count-1)+".png",
					iconSize : new Tmapv2.Size(24, 38),
					map: map, //Marker가 표시될 Map 설정.
					zIndex : 99999
				});
				count++;
				markers.push(marker);
			}
			searchRoute();
		}
	}
	
	// 검색 결과를 클릭해서 경로 설정
	function setPointbyli(lat, lon, number){
		var markerPosition = new Tmapv2.LatLng(lat, lon);
		if(number == 0){
			if(count == 0 || markers[0] == null){
				marker_s = new Tmapv2.Marker(
						{
							position : markerPosition,
							icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map,
							zIndex : 99999
						});
				count = 1;
				if(markers[1] != null){
					count = 2;
				}
				markers[0] = marker_s;
			} else {
				marker_s.setPosition(markerPosition);
			}
			if(count > 1){
				searchRoute();
			}
			console.log(count);
		}
		else if(number == 1){
			if(count < 2){
				marker_e = new Tmapv2.Marker(
						{
							position : markerPosition,
							icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map,
							zIndex : 99999
						});
				count = 2;
				markers[1] = marker_e;
			} else {
				marker_e.setPosition(markerPosition);
			}
			if(count > 1 && markers[0] != null){
				searchRoute();
			}
		}
		else if(number == 2){
			if(count < 2){
				alert('출발지, 도착지부터 선택해주세요.');
				return false;
			} else {
				marker = new Tmapv2.Marker({
					position: markerPosition, //Marker의 중심좌표 설정.
					icon : "https://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+(count-1)+".png",
					iconSize : new Tmapv2.Size(24, 38),
					map: map, //Marker가 표시될 Map 설정.
					zIndex : 99999
				});
				count++;
				markers.push(marker);
			}
			searchRoute();
		}
	}
	
	// 좌표를 주소로(도로명, 지번 가능)
	function reverseGeo(lon, lat, number) {
		$
				.ajax({
					method : "GET",
					url : "https://apis.openapi.sk.com/tmap/geo/reversegeocoding?version=1&format=json&callback=result",
					async : false,
					data : {
						"appKey" : "l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2",
						"coordType" : "WGS84GEO",
						"addressType" : "A10",
						"lon" : lon,
						"lat" : lat
					},
					success : function(response) {
						// 3. json에서 주소 파싱
						var arrResult = response.addressInfo;

						//법정동 마지막 문자 
						var lastLegal = arrResult.legalDong
								.charAt(arrResult.legalDong.length - 1);

						// 새주소
						newRoadAddr = arrResult.city_do + ' '
								+ arrResult.gu_gun + ' ';

						if (arrResult.eup_myun == ''
								&& (lastLegal == "읍" || lastLegal == "면")) {//읍면
							newRoadAddr += arrResult.legalDong;
						} else {
							newRoadAddr += arrResult.eup_myun;
						}
						newRoadAddr += ' ' + arrResult.roadName + ' '
								+ arrResult.buildingIndex;

						// 새주소 법정동& 건물명 체크
						if (arrResult.legalDong != ''
								&& (lastLegal != "읍" && lastLegal != "면")) {//법정동과 읍면이 같은 경우

							if (arrResult.buildingName != '') {//빌딩명 존재하는 경우
								newRoadAddr += (' (' + arrResult.legalDong
										+ ', ' + arrResult.buildingName + ') ');
							} else {
								newRoadAddr += (' (' + arrResult.legalDong + ')');
							}
						} else if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
							newRoadAddr += (' (' + arrResult.buildingName + ') ');
						}

						// 구주소
						jibunAddr = arrResult.city_do + ' '
								+ arrResult.gu_gun + ' '
								+ arrResult.legalDong + ' ' + arrResult.ri
								+ ' ' + arrResult.bunji;
						//구주소 빌딩명 존재
						if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
							jibunAddr += (' ' + arrResult.buildingName);
						}
						
						if(number == 0){
							document.getElementById("searchStart").value = newRoadAddr;
							address[0] = newRoadAddr;
						}else if(number == 1){
							document.getElementById("searchEnd").value = newRoadAddr;
							address[1] = newRoadAddr;
						}else if(number == 2){
							/*
							switch(count){
							case 3:document.getElementById("searchWaypoint0").value = newRoadAddr; break;
							case 4:document.getElementById("searchWaypoint1").value = newRoadAddr; break;
							case 5:document.getElementById("searchWaypoint2").value = newRoadAddr; break;
							case 6:document.getElementById("searchWaypoint3").value = newRoadAddr; break;
							case 7:document.getElementById("searchWaypoint4").value = newRoadAddr; break;
							}
							*/
							if(count == 3 && waypoint_number > 0){
								document.getElementById("searchWaypoint0").value = newRoadAddr;
								address[2] = newRoadAddr;
							}else if(count == 4 && waypoint_number > 1){
								document.getElementById("searchWaypoint1").value = newRoadAddr;
								address[3] = newRoadAddr;
							}else if(count == 5 && waypoint_number > 2){
								document.getElementById("searchWaypoint2").value = newRoadAddr;
								address[4] = newRoadAddr;
							}else if(count == 6 && waypoint_number > 3){
								document.getElementById("searchWaypoint3").value = newRoadAddr;
								address[5] = newRoadAddr;
							}else if(count == 7 && waypoint_number > 4){
								document.getElementById("searchWaypoint4").value = newRoadAddr;
								address[6] = newRoadAddr;
							}
							
						}
						
						/*
						result = "새주소 : " + newRoadAddr + "</br>";
						result += "지번주소 : " + jibunAddr + "</br>";
						result += "위경도좌표 : " + lat + ", " + lon;

						var resultDiv = document.getElementById("result");
						resultDiv.innerHTML = result;
						*/

					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});

	}
	// 경유치 검색 input box 추가
	var waypoint_number = 0;
	const add_textbox = () => {
		if(waypoint_number > 4){
			alert("경유지는 최대 5개까지 가능합니다.");
			return false;
		}
		const box = document.getElementById("waypoint");
		const newSpan = document.createElement('span');
		newSpan.innerHTML = "<input type = 'text' class = 'searchWaypoint' id = 'searchWaypoint"+waypoint_number+"' onKeypress = 'javascript:if(event.keyCode==13){searchPlace(this.value, 2)}'><input type = 'button' class = 'waypoint_button' value = '삭제' onclick = 'remove_textbox(this)'>";
		box.appendChild(newSpan);
		waypoint_number++;
		
	}
	const remove_textbox = (obj) => {
		document.getElementById('waypoint').removeChild(obj.parentNode);
		if(count > 0){
			markers[markers.length - 1].setMap(null);
			markers.pop();
			if(count > 0){
				count--;
			}
			
			if(count > 1){
				searchRoute();
			}else{
				clearLine();
			}
		}
	}
	
	function setBoundary(lat, log, map){
		
		var boundary = new Tmapv2.LatLngBounds();
		
		for(let i = 0; i < lat.length; i++){
			var point = new Tmapv2.LatLng(lat[i], log[i]);
			boundary.extend(point);
		}
		map.fitBounds(boundary);
	}
	
	function nameCheck(){
		var course_name = $('#course_name').val();
		if(course_name == ""){
			alert("코스명을 입력하세요");
			return false;
		}
		$.ajax({
			type : 'post',
			url : "/maps/nameCheck",
			data : {"course_name" : course_name},
			success : function(result){
				if(result < 1){
					alert("사용가능한 코스명입니다.");
				}else{
					alert("중복된 코스명입니다.");
				}
			}, error: function(e){
					console.log(e.responseText);
					alert("중복 검사 실패");
				}
		})
	}