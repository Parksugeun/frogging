var x = document.getElementById("demo");
var map;
var total_count = 0;

function initTmap() {
		alert("initTmap");
		// 1. 지도 띄우기
		// 현재 위치 HTML Geolocaiton 을 통해 확인 GPS 아님
		map = new Tmapv2.Map("map_div", {
		center : new Tmapv2.LatLng(37.56520450, 126.98702028),
			width : "100%",
			height : "600px",
			zoom : 17,
			zoomControl : true,
			scrollwheel : true,
			httpsMode : true
		});
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
                    //alert("test3");
					map.setCenter(new Tmapv2.LatLng(lat,lon));
					map.setZoom(15);
					console.log(new Tmapv2.LatLng(lat,lon));
					console.log(map.getCenter());
					
				}, showError);
			}
		}

function setGeolocation(){
	//alert("setGeolocation");
	//alert("test2");
	 if (navigator.geolocation) {
            //위치 정보를 정기적으로 얻기
            var total_lat;
			var total_lon;
			var lat;
			var lon;
			var local_count = 0;
            var id = navigator.geolocation.watchPosition(
                    function(pos) {
						//alert("watchPosition");
						total_count++;
						local_count++;
						total_lat = pos.coords.latitude + "";
						total_lon = pos.coords.longitude + "";
						lat = total_lat.substring(0, 9);
						lon = total_lon.substring(0, 10);
						
                        $('#latitude').html(lat);     // 위도 
                        $('#longitude').html(lon); // 경도 
                        $('#accuracy').html(pos.coords.accuracy);
                        $('#total_count').html(total_count);
                        $('#local_count').html(local_count);
                        if(total_count > 3){
                       		map.setCenter(new Tmapv2.LatLng(pos.coords.latitude,pos.coords.longitude));
                       	}
                    }, showError);
            
            // 버튼 클릭으로 감시를 중지
            $('#btnStop').click(function() {
				alert("멈춤");
                navigator.geolocation.clearWatch(id);
            });
        } else {
            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
        }
        
        window.setTimeout(function () {
	            window.navigator.geolocation.clearWatch( id ) 
	        }, 
	        5000 //stop checking after 5 seconds
	    );
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

setGeolocation();

window.setTimeout(function () {
        setGeolocation();
    }, 
    30000 //check every 30 seconds
);