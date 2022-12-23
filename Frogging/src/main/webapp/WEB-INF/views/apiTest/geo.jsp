
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>simpleMap</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=	l7xxc6985a9bef1d438f939779b9bf5e79d8"></script>
<script type="text/javascript">
	var map;
	var vector_layer;
	var resultPolygon = [];
	function initTmap() {
		// 1. 지도 띄우기
		map = new Tmapv2.Map("map_div", {
			center : new Tmapv2.LatLng(37.56520450, 126.98702028),
			width : "70%",
			height : "400px",
			zoom : 17,
			zoomControl : true,
			scrollwheel : true
		});

		// 2. 공간 API 사용요청

		$("#btn_select")
				.click(
						function() {

							var searchKeyword = $('#searchKeyword').val();

							var searchOption = $("#selectLevel").val();
							$
									.ajax({
										method : "GET",
										url : "https://apis.openapi.sk.com/tmap/geofencing/regions?version=1&format=json&callback=result",
										async : false,
										crossDomain : true,
										data : {
											"count" : "20",
											"categories" : searchOption,//categories,
											"searchType" : "KEYWORD",
											"searchKeyword" : searchKeyword,
											"appKey" : "l7xxc6985a9bef1d438f939779b9bf5e79d8",
										},
										success : function(response) {

											console.log(response);
											if(response){
												// 3. regionId 얻기
												var resultRegionsInfo = response.searchRegionsInfo;
	
												console.log(resultRegionsInfo);
	
												var innerHtml = "";
	
												for ( var i in resultRegionsInfo) {
													var description = resultRegionsInfo[i].regionInfo.description;
													var regionId = resultRegionsInfo[i].regionInfo.regionId;
	
													innerHtml += "<div>"
															+ description
															+ ""
															+ "<button type='button' name='sendBtn' onClick='geofencingRegions("
															+ regionId
															+ ");'>상세보기</button><\div>";
												}
	
												$("#searchResult").html(innerHtml);
											}
											else{
												alert("잘못된 검색입니다.");
												$("#searchResult").html("");
											}
										},
										error : function(request, status, error) {
											console.log("code:"
													+ request.status + "\n"
													+ "message:"
													+ request.responseText
													+ "\n" + "error:" + error);
										}
									});
						});
	}

	// 4. 영역API 사용요청
	function geofencingRegions(regionId) {
		console.log("area");

		$.ajax({
					method : "GET",
					url : "https://apis.openapi.sk.com/tmap/geofencing/regions/"
							+ regionId
							+ "?version=1&format=json&callback=result",
					async : false,
					data : {
						"resCoordType" : "EPSG3857",
						"appKey" : "l7xxc6985a9bef1d438f939779b9bf5e79d8",
					},
					success : function(response) {
						console.log(response);
						var resultGeometry = response.features[0].geometry;
						var resultArea = resultGeometry.coordinates[0];

						var drawInfoArr = [];
						var polyline_;

						var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성

						if (resultPolygon.length > 0) {
							for(var i in resultPolygon){
								resultPolygon[i].setMap(null);
							}
							resultPolygon = [];
						}

						if(resultGeometry.type == "MultiPolygon"){
							for(var i in resultGeometry.coordinates){
								drawInfoArr = [];
								resultArea = resultGeometry.coordinates[i];
								var resultArea_array = resultArea[0];
								for(var j in resultArea_array){
									
									// 경로들의 결과값(구간)들을 포인트 객체로 변환 
									var latlng = new Tmapv2.Point(resultArea_array[j][0], resultArea_array[j][1]);
									// 포인트 객체를 받아 좌표값으로 변환
									var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
									// 포인트객체의 정보로 좌표값 변환 객체로 저장
									var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
									//console.log(convertPoint);
									console.log("--");
									drawInfoArr.push(latlng);
									positionBounds.extend(convertChange);
								}
								var polygon = new Tmapv2.Polygon({
									paths: drawInfoArr,
									strokeColor : "red",
									fillColor:"pink", // 다각형 내부 색상
									map: map // 지도 객체
								});
								resultPolygon.push(polygon);
								
							}
						}
						
						else{
							for(var i in resultArea){
								// 경로들의 결과값(구간)들을 포인트 객체로 변환 
								var latlng = new Tmapv2.Point(resultArea[i][0], resultArea[i][1]);
								// 포인트 객체를 받아 좌표값으로 변환
								var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
								// 포인트객체의 정보로 좌표값 변환 객체로 저장
								var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
								//console.log("--");
								console.log(convertPoint);
								drawInfoArr.push(latlng);
								positionBounds.extend(convertChange);
							}
							var polygon = new Tmapv2.Polygon({
								paths: drawInfoArr,
								strokeColor : "red",
								fillColor:"pink", // 다각형 내부 색상
								map: map // 지도 객체
							});
							resultPolygon.push(polygon);
						}
						
						map.panToBounds(positionBounds);	// 확장된 bounds의 중심으로 이동시키기
						map.zoomOut();

					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});

	}
</script>

<body onload="initTmap();" class="k_body">
	<section>
		<select id="selectLevel">
			<option value="city_do" selected="selected">시,도</option>
			<option value="gu_gun">시,군,구</option>
			<option value="legalDong">법정동</option>
			<option value="adminDong">행정동</option>
		</select> <input type="text" class="text_custom" id="searchKeyword" name="searchKeyword" value="서울">
		<button id="btn_select">적용하기</button>
	</section>
		
	<section class="search_rst" style="width: 30%; float:left;">
		<div class="title"><strong>Search</strong> Results</div>
			<div class="rst_wrap">
				<div class="rst mCustomScrollbar">
					<ul id="searchResult" name="searchResult">
						<li>검색결과</li>
					</ul>
				</div>
			</div>
		</section>
	</div>
	<section id="map_div" class="map_wrap"></section>

</body>
</html>
