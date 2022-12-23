var x = document.getElementById("demo");
var map;
var total_count = 0;
var watchId = -1;
var locationList = [];
var polyline;
var total_distance = 0;
var start_time, end_time, total_time = 0;
var saved_course = [];

var drawInfoArr = [];
var resultdrawArr = [];
var sync = false;

$(function(){
	$("#checkCourseForm").submit(function(){
		event.preventDefault();
		
		let course_no = detail_arr[0].course_no;
		let amount_trash = $("#amount_trash").val();
		let tDistance = parseFloat(total_distance.toFixed(4)) / 1000;
		let tTime = parseFloat(total_time.toFixed(4));
		//let dnt = [tDistance, tTime];
		let sort = $("#sort").val();
		if(sort == ""){
			alert(sort);
			sort = 0;
		}
		
		if(sync == true){
			var check = checkCourse(locationList, saved_course, tDistance * 1000);
		} else {
			check == false;
		}
		
		//alert(check);
		var lat = new Array();
		var lon = new Array();
		
		for(var i = 0; i < locationList.length; i++){
			if(i == 0){
				lat[i] = locationList[i].lat();
				lon[i] = locationList[i].lng();
			}else if(i == 1){
				lat[i] = locationList[locationList.length - 1].lat();
				lon[i] = locationList[locationList.length - 1].lng();
			}else{
				lat[i] = locationList[i-1].lat();
				lon[i] = locationList[i-1].lng();
			}
		}
		
		$.ajax({
			type : 'POST',
			url : '/mobile/activityOk/'+ course_no,
			data : {"lat" : lat, "log" : lon, "distance" : tDistance, "time" : tTime, "amount_trash" : amount_trash, "sort" : sort},
			success : function(result){
				if(sync == true){
					if(check == true){
						alert("지정하신 코스로 이동하셨습니다. 이동하신 경로는 마이페이지에서 확인하실 수 있습니다.");
					} else {
						alert("지정하신 코스를 이용하지는 않으셨습니다. 이동하신 경로는 마이페이지에서 확인하실 수 있습니다.");
					}
				} else {
					alert("출발지 동기화를 하지 않으셨습니다. 이동하신 경로는 마이페이지에서 확인하실 수 있습니다.");
				}
				window.location.href = '/mypage/activity';
			}, error : function(e) {
				alert(e.responseText);
				console.log(e.responseText);
				alert("실제 이동 경로 및 확인에 실패하였습니다.");
			}
		});
	});
});
function initTmap() {
		//alert("initTmap");
		
		// 1. 지도 띄우기
		// 현재 위치 HTML Geolocaiton 을 통해 확인 GPS 아님
		map = new Tmapv2.Map("map_div", {
			center : new Tmapv2.LatLng(37.56520450, 126.98702028),
			width : "100%",
			height : "1200px",
			zoom : 17,
			zoomControl : true,
			scrollwheel : true,
			httpsMode : true
		});
		loadCourse(detail_arr, courseType);
		//alert("test1");
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				function(position) {
					//alert("getCurrentPosition");
					var lat = position.coords.latitude;
					var lon = position.coords.longitude;

					marker = new Tmapv2.Marker({
						position : new Tmapv2.LatLng(lat,lon),
						map : map
					});

					$('#latitude').html(lat);     // 위도 
                    $('#longitude').html(lon);
                    $('#accuracy').html(position.coords.accuracy);
                    //alert("test3");
					map.setCenter(new Tmapv2.LatLng(lat,lon));
					map.setZoom(15);
					//console.log(new Tmapv2.LatLng(lat,lon));
					//console.log(map.getCenter());
					
				}, showError);
			}
			
			polyline = new Tmapv2.Polyline({
				path: [],
				strockColor:"blue",
				strokeOpacity:1,
				strokeWeight: 4,
				directionColor:"blue",
				map: map
			});
		}

function startChecking(){
	alert("경로 확인을 시작합니다.");
	//alert("test2");
	 if (navigator.geolocation) {
			let count = 0;
			let update_count = 0;
			$('#count').html(count);
            //위치 정보를 정기적으로 얻기
            let before_location = null;
            let new_location = null;
            
            start_time = new Date();
            
            let id = navigator.geolocation.watchPosition(
                    function(position) {
						count++;
						$('#count').html(count);
						
						let updateFlag = true;
						new_location = new Tmapv2.LatLng(position.coords.latitude,position.coords.longitude);

						if(before_location != null){
							const section_distance = before_location.distanceTo(new_location) / 1000;
							if(section_distance < 0.01){
								updateFlag = false;
							}
							
						}
						
						if(updateFlag){
							update_count++;
							$('#update_count').html(update_count);
							
							locationList.push(new_location);
							if(update_count != 1){
								total_distance += before_location.distanceTo(new_location);
							}
							
							before_location = new_location;
							$('#distance').html(total_distance);
							
							polyline.setPath(locationList);
							
							$('#latitude').html(new_location.lat());     // 위도 
	                        $('#longitude').html(new_location.lng()); // 경도 
	                        $('#accuracy').html(position.coords.accuracy);
						}
                    }, showError);
                    watchId = id;
        } else {
            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
        }
	}

function endChecking(){
	
	alert("경로 확인을 마칩니다.");
	
	end_time = new Date();
	total_time = (end_time.getTime() - start_time.getTime()) / (1000 * 60);
	$('#time').html(total_time);
	
	if(watchId != -1){
		
		navigator.geolocation.getCurrentPosition(function(position){
			locationList.push(new Tmapv2.LatLng(position.coords.latitude,position.coords.longitude));
			total_distance += locationList[locationList.length - 2].distanceTo(locationList[locationList.length - 1]);
			$('#distance').html(total_distance);
		}, showError);
		
		let string = "";
		for(let i = 0; i < locationList.length; i++){
			if(i != locationList.length - 1){
				string += locationList[i].toString() + ", ";
			}else{
				string += locationList[i].toString()
			}
		}
		$('#locationList_count').html(locationList.length);
		alert(string);
		
		navigator.geolocation.clearWatch(watchId);
		watchId = -1;
		let distance_check = locationList[0].distanceTo(locationList[locationList.length - 1]);
		if(distance_check < 0.2 || locationList.length < 3){
			alert(distance_check);
			//alert("200m이내를 이동하셨습니다.");
		}
	} else {
		alert('위치 확인을 시작해주십시오.');
	}
}
function showError(error) {
	  switch(error.code) {
	    case error.PERMISSION_DENIED:
	    alert("User denied the request for Geolocation.");
	      x.innerHTML = "User denied the request for Geolocation.";
	      break;
	    case error.POSITION_UNAVAILABLE:
	    alert("Location information is unavailable.");
	      x.innerHTML = "Location information is unavailable.";
	      break;
	    case error.TIMEOUT:
	    alert("The request to get user location timed out.");
	      x.innerHTML = "The request to get user location timed out.";
	      break;
	    case error.UNKNOWN_ERROR:
	    alert("An unknown error occurred.");
	      x.innerHTML = "An unknown error occurred.";
	      break;
	  	}
	}

function verticalLength(point1, point2, point3){
	var length12 = point1.distanceTo(point2);
	var length23 = point2.distanceTo(point3);
	var length31 = point3.distanceTo(point1);
	
	var cosValue = (Math.pow(length12,2) + Math.pow(length23,2) - Math.pow(length31,2)) / (2 * (length12 * length23));

	return length12 * Math.sqrt(1 - Math.pow(cosValue, 2));
}

function checkCourse(user_course, saved_course, distance){
	let courseIn = false;
	let flag = 0;
	let vertical_length1 = 0;
	let vertical_length2 = 0;
	let checker = 0;
	let index = 0;
	let areaIn = false;
	let limit = 0;
	
	if(distance < 600){
		limit = 3;
	} else {
		limit = parseInt(distance / 200);
	}
	
	for(let i = 0; i < user_course.length; i++){
		if(index < saved_course.length - 1){
			vertical_length1 = verticalLength(user_course[i], saved_course[index], saved_course[index+1]);
			if(index < saved_course.length - 2){
				vertical_length2 = verticalLength(user_course[i], saved_course[index+1], saved_course[index+2]);
				if(vertical_length1 <= vertical_length2){
					checker = vertical_length1;
				} else {
					checker = vertical_length2;
					index++; 
				}
			} else {
				checker = vertical_length1;
			}
		} else {
			vertical_length1 = verticalLength(user_course[i], saved_course[saved_course.length-2], saved_course[saved_course.length-1]);
		}
		
		if(checker < 10){
			flag++;
		}
		//alert(checker);
	}
	
	if(flag >= limit){
		courseIn = true;
	}
	
	return courseIn;
}

function checkArea(point_user, point_saved){
	var distance = point_user.distanceTo(point_saved);
	var areaIn = false;
	
	if(distance < 10){
		areaIn = true;	
	}
	return areaIn;
}
function loadCourse(loaded_course, type){
	if(type == 1){
		//alert("loadcourse!");
		var waypoint = "";
		for (let i = 2; i < loaded_course.length; i++){
			waypoint += loaded_course[i].log + ",";
			waypoint += loaded_course[i].lat;
			if(i == loaded_course.length - 1){
				break;
			}
			waypoint += "_";
		}
		
		$.ajax({
					method : "POST",
					url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",
					async : false,
					data : {
						"appKey" : "l7xxc6985a9bef1d438f939779b9bf5e79d8",
						"startX" : loaded_course[0].log,
						"startY" : loaded_course[0].lat,
						"endX" : loaded_course[1].log,
						"endY" : loaded_course[1].lat,
						"passList" : waypoint,
						"reqCoordType" : "WGS84GEO",
						"resCoordType" : "EPSG3857",
						"startName" : "출발지",
						"endName" : "도착지"
					},
					success : function(response) {
						console.log(response);
						saved_course = checkPoint(response);
						var resultData = response.features;
						
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
									markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
									pType = "S";
									size = new Tmapv2.Size(24, 38);
								} else if (properties.pointType == "E") { //도착지 마커
									markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
									pType = "E";
									size = new Tmapv2.Size(24, 38);
								} else { //각 포인트 마커
									markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
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
						console.log(saved_course);
						for(let z = 0; z < saved_course.length; z++){
							var point = new Tmapv2.LatLng(saved_course[z].lat(), saved_course[z].lng());
							boundary.extend(point);
						}
						//map.fitBounds(boundary);
						console.log(drawInfoArr);
						drawLine(drawInfoArr);
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});
	} else {
		var temp_position;
		var end_point;
		for(let i = 0; i < loaded_course.length; i++){
			temp_position = new Tmapv2.LatLng(loaded_course[i].lat, loaded_course[i].log);
			if(loaded_course[i].waypoint != 1){
				saved_course.push(temp_position);
			} else {
				end_point = new Tmapv2.LatLng(loaded_course[i].lat, loaded_course[i].log);
			}
		}
		saved_course.push(end_point);
		drawLine(saved_course);
	}
}


function checkPoint(course){
		var pointArray = [];
		for(let i = 0; i < course.features.length; i++){
			if(course.features[i].geometry.type == "Point"){
				var epsg3857 = new Tmapv2.Point(course.features[i].geometry.coordinates[0],course.features[i].geometry.coordinates[1]);
				var wgs84 = Tmapv2.Projection.convertEPSG3857ToWGS84GEO(epsg3857);
				pointArray.push(wgs84);
			}
		}
		return pointArray;
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

function synchronizeStart(){
	if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				function(position) {
					//alert("getCurrentPosition");
					var lat = position.coords.latitude;
					var lon = position.coords.longitude;
					var start = new Tmapv2.LatLng(lat, lon);
					
					let distance = saved_course[0].distanceTo(start);
					//alert(distance);
					if(distance < 100){
						sync = true;
					}
					
					if(sync == true){
						alert("출발지 동기화가 완료되었습니다. 경로를 확인하여 종료시 알려드립니다.");
					} else {
						alert("출발지 동기화에 실패하였습니다. 실제 이동 경로는 마이페이지에서 확인하실 수 있습니다만, 기존 경로에 대한 확인은 이루어지지 않습니다.");
					}
				}, showError);
			}
}