package com.frogging.app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.frogging.app.service.DataService;
import com.frogging.app.vo.AddrVO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/data/*")
public class DataController {

	@Inject
	DataService service;

	ModelAndView mav = new ModelAndView();

	// 주소지 대분류->소분류 변경
	@GetMapping(value = "getAddr_2")
	public JSONObject getAddr_2(String addr_1) {
		JSONObject voList = new JSONObject();

		try {
			// System.out.println(addr_1);
			ObjectMapper mapper = new ObjectMapper();
			int idx = 0;

			List<AddrVO> addr_2_list = service.getAddr_2(addr_1);
			for (AddrVO vo : addr_2_list) {
				String jsonString = mapper.writeValueAsString(vo);
				// System.out.println(jsonString);

				JSONParser jsonParser = new JSONParser();
				JSONObject jObj_addr_2 = (JSONObject) jsonParser.parse(jsonString);
				voList.put(idx, jObj_addr_2);
				idx += 1;
			}
			voList.put("idx", idx);
			// System.out.println(addr_2_list.get(0).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return voList;
	}

	@GetMapping(value = "/api_1")
	public ModelAndView getKakao() {
		mav = new ModelAndView();
		mav.setViewName("/apiTest/kakao");
		return mav;
	}

	@GetMapping(value = "/api_2")
	public ModelAndView getTmap() {
		mav = new ModelAndView();
		mav.setViewName("/apiTest/tmap");
		return mav;
	}

	@GetMapping(value = "/geo")
	public ModelAndView getGeo() {
		mav = new ModelAndView();
		mav.setViewName("/apiTest/geo");
		return mav;
	}

	@GetMapping(value = "/fit")
	public ModelAndView getGoogleFit() {
		mav = new ModelAndView();
		mav.setViewName("/apiTest/googleFit");
		return mav;
	}

	@GetMapping("/getCourse")
	public static void getCourse() throws IOException {
		System.out.println("----- course -----");

		// 1. URL을 만들기 위한 StringBuilder.
		StringBuilder urlBuilder = new StringBuilder(
				" http://api.vworld.kr/req/data");
		// ?service=data&request=GetFeature&data=LT_L_TRKROAD&key=C413699C-CB3F-3016-B15A-B1274D293E55&domain=http://localhost:8010");
		// */

		// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
		urlBuilder.append("?" + URLEncoder.encode("service", "UTF-8")
				+ "=data");
		urlBuilder.append("&" + URLEncoder.encode("request", "UTF-8")
				+ "=GetFeature");
		urlBuilder.append("&" + URLEncoder.encode("data", "UTF-8")
				+ "=LT_L_TRKROAD");
		urlBuilder.append("&" + URLEncoder.encode("key", "UTF-8")
				+ "=C413699C-CB3F-3016-B15A-B1274D293E55");// 인증키
		urlBuilder.append("&" + URLEncoder.encode("domain", "UTF-8")
				+ "=http://localhost:8010");
		urlBuilder.append("&" + URLEncoder.encode("geomFilter", "UTF-8")
				+ "=box(125.06666667, 33.10000000, 131.87222222, 38.45000000)");
		// urlBuilder.append("&" + URLEncoder.encode("format", "UTF-8") + "=" +
		// 37.56602641666906, 126.98709722138048
		// URLEncoder.encode("JSON", "UTF-8")); // 반환타입
		// urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" +
		// URLEncoder.encode("10", "UTF-8")); // 한 페이지 // 결과 수
		// urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" +
		// URLEncoder.encode("1", "UTF-8")); /* 페이지 번호 */
		// urlBuilder.append(
		// "&" + URLEncoder.encode("cond[country_nm::EQ]", "UTF-8") + "=" +
		// URLEncoder.encode("가나", "UTF-8")); /* 한글 국가명 */
		// urlBuilder.append("&" + URLEncoder.encode("cond[country_iso_alp2::EQ]",
		// "UTF-8") + "="
		// + URLEncoder.encode("GH", "UTF-8")); /* ISO 2자리코드 */

		// 3. URL 객체 생성.
		URL url = new URL(urlBuilder.toString());
		System.out.println(urlBuilder);
		// 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		// 5. 통신을 위한 메소드 SET.
		conn.setRequestMethod("GET");

		// 6. 통신을 위한 Content-type SET.
		conn.setRequestProperty("Content-type", "application/json");

		// 7. 통신 응답 코드 확인.
		System.out.println("Response code: " + conn.getResponseCode());

		// 8. 전달받은 데이터를 BufferedReader 객체로 저장.
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		// 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		// 10. 객체 해제.
		rd.close();
		conn.disconnect();
		// 11. 전달받은 데이터 확인.
		System.out.println(sb.toString());
	}

	// ====== 서울 두드림길 =======
	@GetMapping("/getSeoul")
	public static void Seoul() throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /* URL */
		// http://openAPI.seoul.go.kr:8088/(인증키)/xml/SeoulGilWalkCourse/1/5
		urlBuilder.append("/" + URLEncoder.encode("", "UTF-8")); /* 인증키 (sample사용시에는 호출시 제한됩니다.) */
		urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8")); /* 요청파일타입 (xml,xmlf,xls,json) */
		urlBuilder.append("/" + URLEncoder.encode("SeoulGilWalkCourse", "UTF-8")); /* 서비스명 (대소문자 구분 필수입니다.) */
		urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8")); /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
		urlBuilder.append("/" + URLEncoder.encode("5", "UTF-8")); /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
		// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.

		// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에 자세히 나와 있습니다.
		urlBuilder.append("/" + URLEncoder.encode("20220301", "UTF-8")); /* 서비스별 추가 요청인자들 */

		// 3. URL 객체 생성.
		URL url = new URL(urlBuilder.toString());
		System.out.println(urlBuilder);
		// 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		// 5. 통신을 위한 메소드 SET.
		conn.setRequestMethod("GET");

		// 6. 통신을 위한 Content-type SET.
		conn.setRequestProperty("Content-type", "application/json");

		// 7. 통신 응답 코드 확인.
		System.out.println("Response code: " + conn.getResponseCode());

		// 8. 전달받은 데이터를 BufferedReader 객체로 저장.
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		// 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		// 10. 객체 해제.
		rd.close();
		conn.disconnect();
		// 11. 전달받은 데이터 확인.
		System.out.println(sb.toString());
	}
}
