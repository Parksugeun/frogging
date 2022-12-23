<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lmvzp9q6q8"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lmvzp9q6q8&submodules=geocoder"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
</style>
<script>
	$(function(){
		var lat = new Array();
		var log = new Array();
		
		$("#courseForm").submit(function(){

			event.preventDefault();
			
			for(var i = 0; i < path._array.length; i++){
					lat[i] = path._array[i].y;
					log[i] = path._array[i].x;
					
					//alert(lat[i] + " " + log[i]);
			}
			
			var course_name = $("#course_name").val();
			var course_info = $("#course_info").val();
			
			$.ajax({
				type : 'POST',
				url : '/maps/mapsEditOk/${course.course_no}',
				data : {"lat": lat, "log": log, "distance" : distance, "time" : time, "course_name" : course_name, "course_info" : course_info, "address" : address},
				success: function(result){
					console.log(result);
				}, error: function(e){
					console.log(e);
				}
			});
		});
	});
</script>
</head>
<body>
	<div id="map" style="width:100%;height:400px;">dd</div>
	<form method = "post" id = "courseForm">
		코스명 : <input type = "text" id = "course_name" name = "course_name" value = "${course.course_name }">
		코스에 대한 메모 : <textarea id = "course_info" name = "course_info">${course.course_info }</textarea>
		<input type = "submit" id = "course" name = "course" value = "코스 만들기">
	</form>
</body>

	<script>
	var path;
	var distance;
	var time;
	var marker = new Array();
	var address = new Array();
	var count = 0;
	
	var course_detail = JSON.parse('${course_detail}'); // 코스에 있는 위도, 경도 data를 JSON으로 저장
	//console.log(course_detail);
	
	var map = new naver.maps.Map('map', {
		center: new naver.maps.LatLng(37.5666805, 126.9784147),
		zoom: 10
	});
	
	var infowindow = new naver.maps.InfoWindow();
	
	function onSuccessGeolocation(position) {
	    var location = new naver.maps.LatLng(course_detail[0].lat, course_detail[0].log);

	    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
	    map.setZoom(17); // 지도의 줌 레벨을 변경합니다.

	    infowindow.setContent('<div style="padding:20px;">' + course_detail[0].addr + '</div>');

	    //infowindow.open(map, location);
	    console.log('Coordinates: ' + location.toString());
	    
		// 기존 코스 불러오는 부분 ////////////////////////////////////////////////////
		for(i = 0; i < course_detail.length; i++){
		 	marker[i] = new naver.maps.Marker({
		        map: map,
		        position: new naver.maps.LatLng(course_detail[i].lat, course_detail[i].log)
		    });
		 	
		 	//console.log("count : " + count);
		 	path = polyline.getPath();
		 	
		 	var point = marker[i].getPosition();
		 	path.push(point);
		 	//searchCoordinateToAddress(point);
		 	address[i] = course_detail[i].addr;
		 	//console.log("count4 : " + count);
		 	//console.log(marker[0]);
		 	count++;
		}
		//console.log("count2 : " + count);
		distance = polyline.getDistance();
		time = distance / 4.02 / 1000 * 60;
		//console.log(distance);
		//console.log(path);
		//////////////////////////////////////////////////////////////////////////
	}
	//console.log("count3 : " + count);
	function onErrorGeolocation() {
	    var center = map.getCenter();

	    infowindow.setContent('<div style="padding:20px;">' +
	        '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');

	    infowindow.open(map, center);
	}
	
	$(window).on("load", function() {
	    if (navigator.geolocation) {
	        /**
	         * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
	         * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
	         * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
	         */
	        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	      	
	    } else {
	        var center = map.getCenter();
	        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
	        infowindow.open(map, center);
	    }
	});
	
	var polyline = new naver.maps.Polyline({
	    map: map,
	    path: [],
	    strokeColor: '#5347AA',
	    strokeWeight: 2,
	    strokeLineJoin : "miter"
	});
	
	naver.maps.Event.addListener(map, 'click', function(e) {

	    var point = e.coord;
	 	//console.log(e.coord);
	    path = polyline.getPath();
	    
	    path.push(point);
	    //console.log(path);
 		distance = polyline.getDistance();
 		time = distance / 4.02 / 1000 * 60;
	    console.log(distance);

	    marker[count] = new naver.maps.Marker({
	        map: map,
	        position: point
	    });
	    //console.log(marker[count].getPosition());
	    searchCoordinateToAddress(point);
	    //console.log(marker);
	    //count++;
	    console.log(count);
	});
	
	naver.maps.Event.addListener(map, 'rightclick', function(e){
		path.pop();
		console.log(marker[3]);
		marker[count-1].setMap(null);
		marker.pop();
		count--;
		//console.log(marker);
	});
	
	function searchCoordinateToAddress(latlng){
		
		naver.maps.Service.reverseGeocode({
			coords: latlng,
			orders:[
				naver.maps.Service.OrderType.ADDR,
			    naver.maps.Service.OrderType.ROAD_ADDR
			].join(',')
		}, function(Status, response){
			if (status === naver.maps.Service.Status.ERROR) {
			      if (!latlng) {
			        return alert('ReverseGeocode Error, Please check latlng');
			      }
			      if (latlng.toString) {
			        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
			      }
			      if (latlng.x && latlng.y) {
			        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
			      }
			      return alert('ReverseGeocode Error, Please check latlng');
			    }
			var tempaddr = response.v2.address;
			
			address[count] = tempaddr.jibunAddress;
			console.log(address[count] + "  askldgj;asdg " + count);
			count++;
		});
	}
	//console.log("count4 : " + count);
	
	</script>
</html>