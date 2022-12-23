<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<title>simpleMap</title>
    <%-- <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=	l7xxc6985a9bef1d438f939779b9bf5e79d8"></script> --%>
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		
</head>
<body class="k_body" onload="initTmap();">
	
	
	<div id="map_wrap" class="map_wrap3">
		<div id="map_div"></div>
	</div>

	<div class="map_act_btn_wrap clear_box"></div>
		<p id="result">---</p>
	<br />

	<div>
		<input type="text" class="text_custom" id="searchKeyword" name="searchKeyword" value="서울시">	
		<button id="btn_select">적용하기</button>
	</div>

	<div>
		<div style="width: 30%; float:left;">
			<div class="title"><strong>Search</strong> Results</div>
			<div class="rst_wrap">
				<div class="rst mCustomScrollbar">
					<ul id="searchResult" name="searchResult">
						<li>검색결과</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxc6985a9bef1d438f939779b9bf5e79d8"></script>
	<script src="/js/k_tmap.js"></script>
</body>
</html>	

