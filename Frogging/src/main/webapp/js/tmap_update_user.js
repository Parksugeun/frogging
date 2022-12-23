var map;
var marker;
var markers = [];
var point = [];
var polyline;
var address = [];
var markerArr = [];
var distance = 0;

	$(function(){
		var lat = new Array();
		var lon = new Array();
		
		$(".saveEditedCourse").click(function(){
			if(confirm("수정된 코스를 저장하시겠습니까?")){
				var temp_add;
				var tDistance = 0;
				var tTime = 0;
				
				for(var i = 0; i < markers.length; i++){
					if(i == 0){
						lat[i] = markers[i].getPosition().lat();
						lon[i] = markers[i].getPosition().lng();
					}else if(i == 1){
						lat[i] = markers[markers.length-1].getPosition().lat();
						lon[i] = markers[markers.length-1].getPosition().lng();
						temp_add = address[i];
						address[i] = address[address.length-1];
					}else{
						lat[i] = markers[i-1].getPosition().lat();
						lon[i] = markers[i-1].getPosition().lng();
						address[i] = temp_add;
						if(i != markers.length - 1){
							temp_add = address[i+1];
						}
					}
					console.log("lat : " + lat[i]);
					console.log("lon : " + lon[i]);
					console.log("address : " + address[i]);
				}
				
				var course_name = $("#coursename").val();
				var course_info = $("#course_info").val();
				var course_no = detail_arr[0].course_no;
				
				tDistance = parseInt(distance) / 1000;
				tTime = parseInt(tDistance / 4.02  * 60);
				
				console.log("distance : " + tDistance + " time : " + tTime);
				
				$.ajax({
					type : 'POST',
					url : '/maps/tmapsEditOk/'+course_no,
					data : {"lat": lat, "log": lon, "distance" : tDistance, "time" : tTime, "course_name" : course_name, "course_info" : course_info, "address" : address, "type": 2},
					success: function(result){
						window.location.href = '/mypage/myCourseView?no='+course_no;
					}, error: function(e){
						console.log(e.responseText);
						alert("코스 등록에 실패하였습니다.");
					}
				});
			}
		});
		
	});
	
	// 페이지가 로딩이 된 후 호출하는 함수입니다.
	function initTmap(){
		
		// map 생성
		// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
		 map = new Tmapv2.Map("map_div", {
			center : new Tmapv2.LatLng(37.56520450, 126.98702028), // 지도 초기 좌표
			width : "100%", // 지도의 넓이
			height : "400px", // 지도의 높이
			zoom : 17	// 지도의 줌레벨
		});
		
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				function(position) {
					var lat = position.coords.latitude;
					var lon = position.coords.longitude;

					marker = new Tmapv2.Marker({
						position : new Tmapv2.LatLng(lat,lon),
						map : map
					});
					
					map.setCenter(new Tmapv2.LatLng(lat,lon));
					map.setZoom(15);
				});
		}

		polyline = new Tmapv2.Polyline({
			path: [],
			strockColor:"blue",
			strokeOpacity:1,
			strokeWeight: 4,
			directionColor:"blue",
			map: map,
			httpsMode : true
		});
		mapload();
		map.addListener("click", onClick); //map 클릭 이벤트를 등록합니다.
		map.addListener("contextmenu", onrightClick);
	};
	
	function mapload(){
		if(courseType == 2){
			var temp_position;
			var end_point;
			for(let i = 0; i < detail_arr.length; i++){
				temp_position = new Tmapv2.LatLng(detail_arr[i].lat, detail_arr[i].log);
				if(detail_arr[i].waypoint != 1){
					point.push(temp_position);
					reverseGeo(detail_arr[i].log, detail_arr[i].lat);
				} else {
					end_point = new Tmapv2.LatLng(detail_arr[i].lat, detail_arr[i].log);
				}
			}
	
			point.push(end_point);
			reverseGeo(end_point._lng, end_point._lat);
			
			for(var k = 0; k < point.length; k++){
				marker = new Tmapv2.Marker({
						position: new Tmapv2.LatLng(point[k]._lat, point[k]._lng), //Marker의 중심좌표 설정.
						icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+(k+1)+".png",
						iconSize : new Tmapv2.Size(24, 38),
						map: map, //Marker가 표시될 Map 설정.
						zIndex : 99999
					});
				markers.push(marker);
			}
			
			polyline.setPath(point);
			
			distance = 0;
			for(var i = 1; i < point.length; i++){
				distance += point[i].distanceTo(point[i-1]);
			}
			setBoundary(point, map);
		} else {
			alert("코스 작성 방식을 바꾸었습니다. 코스를 새로 작성하셔야 합니다.");
		}
	}
	
	var drawingObject = null;
	function getDrawingObject() {
		if (drawingObject == null) {
			// 도형을 그리는 객체 생성
			drawingObject = new Tmapv2.extension.Drawing(
				{
					map:map, // 지도 객체
					strokeWeight: 4, // 테두리 두께
					strokeColor:"blue", // 테두리 색상
					strokeOpacity:1, // 테두리 투명도
					fillColor:"red", // 도형 내부 색상
					fillOpacity:0.2 // 도형 내부 투명도
				}
			); 
        }
        // 객체 반환
        return drawingObject;
    }
	
	function drawPolyline() {
		// 도형 객체의 선을 그리는 함수
		getDrawingObject().drawPolyline();
    }
    
	function clearDrawing() {
		// 도형 객체의 도형을 삭제하는 함수
		getDrawingObject().clear();
		var marker_num = markers.length - 1;
		for(let i = 0; i < marker_num + 1; i++){
			markers[marker_num-i].setMap(null);
			markers.pop();
		}
	}
	
	function onClick(e){
		lonlat = e.latLng;
		console.log(lonlat.lat(),lonlat.lng());
		
		point.push(new Tmapv2.LatLng(lonlat.lat(),lonlat.lng()));

		polyline.setPath(point);
		marker = new Tmapv2.Marker(
					{
						position : point[point.length-1],
						icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_"+point.length+".png",
						iconSize : new Tmapv2.Size(24, 38),
						map : map
					});
		markers.push(marker);
		reverseGeo(lonlat.lng(), lonlat.lat());
		
		distance = 0;
		for(var i = 1; i < point.length; i++){
			distance += point[i].distanceTo(point[i-1]);
		}
		console.log(distance);
		time = parseInt(distance / 4.02  * 60 / 1000);
		$('#result_distance').html((distance / 1000).toFixed(3) + "km");
		$('#result_time').html(time+"분");
	}
	
	function onrightClick(e){
		if(point.length > 0){
			point.pop();
			polyline.setPath(point);
			markers[markers.length - 1].setMap(null);
			markers.pop();
			address.pop();
		}
		if(point.length == 0){
			document.getElementById("searchStart").value = "";
		}
		console.log(address[address.length-1]);
		
		distance = 0;
		for(var i = 1; i < point.length; i++){
			distance += point[i].distanceTo(point[i-1]);
		}
		console.log(distance);
		time = parseInt(distance / 4.02  * 60 / 1000);
		$('#result_distance').html((distance / 1000).toFixed(3) + "km");
		$('#result_time').html(time+"분");
	}
	
	function reverseGeo(lon, lat) {
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
						
						address.push(newRoadAddr);
						console.log(address[address.length-1]);
						if(address.length == 1){
							document.getElementById("searchStart").value = address[0];
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
				
				// 기존 생성된 경로 삭제
				if(markers.length > 0){
					for(var i in markers){
						point.pop();
						markers[markers.length - 1].setMap(null);
						markers.pop();
						address.pop();
					}
				}
				polyline.setPath(point);
				
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
				 		//icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
				 		icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
						iconSize : new Tmapv2.Size(24, 38),
						title : name,
						map:map,
						zIndex : 99999
				 	});

					innerHtml += "<li onclick = 'setPointbyli("+ markerPosition +")'><img src='http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>"+name+"</span></li>";
					
					markerArr.push(marker);
					positionBounds.extend(markerPosition);	// LatLngBounds의 객체 확장
				}
				
				for(let k = 0; k < resultNumber; k++){
					var temp_position = markerArr[k].getPosition();
					
					markerArr[k].addListener("click", function(evt) {
						setPoint(markerArr[k].getPosition());
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
	
	function setPoint(position){
		if(markers.length > 0){
					for(var i in markers){
						point.pop();
						markers[markers.length - 1].setMap(null);
						markers.pop();
						address.pop();
					}
				}
		polyline.setPath(point);
		
		console.log(position);
		point.push(position);

		polyline.setPath(point);
		
		markers[0] = new Tmapv2.Marker(
				{
					position : position,
					icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
					iconSize : new Tmapv2.Size(24, 38),
					map : map,
					zIndex : 99999
				});
		if(markerArr.length > 0){
			for(var i in markerArr){
				markerArr[i].setMap(null);
			}
		}
		reverseGeo(position._lng, position._lat);
	}
	
	// 검색 결과를 클릭해서 경로 설정
	function setPointbyli(lat, lon){
		if(markers.length > 0){
					for(var i in markers){
						point.pop();
						markers[markers.length - 1].setMap(null);
						markers.pop();
						address.pop();
					}
				}
		polyline.setPath(point);
		
		var markerPosition = new Tmapv2.LatLng(lat, lon);
		
		console.log(markerPosition);
		point.push(markerPosition);
		
		polyline.setPath(point);
		
		markers[0] = new Tmapv2.Marker(
				{
					position : markerPosition,
					icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
					iconSize : new Tmapv2.Size(24, 38),
					map : map,
					zIndex : 99999
				});
		if(markerArr.length > 0){
			for(var i in markerArr){
				markerArr[i].setMap(null);
			}
		}
		reverseGeo(lon, lat);
	}
	
	function setBoundary(point, map){
		
		var boundary = new Tmapv2.LatLngBounds();
		
		for(let i = 0; i < point.length; i++){
			var point_b = new Tmapv2.LatLng(point[i]._lat, point[i]._lng);
			boundary.extend(point_b);
		}
		map.fitBounds(boundary);
	}
	
	function nameCheck(){
		var course_name = document.getElementById('coursename').value;
		//alert(course_name);
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
					nameChecker = true;
				}else{
					alert("중복된 코스명입니다.");
				}
			}, error: function(e){
					console.log(e.responseText);
					alert("중복 검사 실패");
				}
		})
	}