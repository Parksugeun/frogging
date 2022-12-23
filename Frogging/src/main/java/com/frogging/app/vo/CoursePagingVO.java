package com.frogging.app.vo;

public class CoursePagingVO {
	
	private int nowPage = 1; // 현재 page
	private int onePageRecord = 6; // 한 page에 출력한 record 수
	private int totalRecord; // 총 record 수
	private int totalPage; // 총 page 수
	private int offsetPoint; // page record 선택할 위치
	
	// page 번호
	private int onePageCount = 5; // 한 번에 표시할 page 수
	private int startPage = 1 ; // 표시할 page의 시작 번호
	
	// 검색
	private String searchLoc; // 위치 검색
	private String addr_section_1;
	private String addr_section_2;
	private String searchDate; // 날짜 검색
	
	private String searchKey;
	private String searchWord;
	
	
	@Override
	public String toString() {
		return "CoursePagingVO [nowPage=" + nowPage + ", onePageRecord=" + onePageRecord + ", totalRecord="
				+ totalRecord + ", totalPage=" + totalPage + ", offsetPoint=" + offsetPoint + ", onePageCount="
				+ onePageCount + ", startPage=" + startPage + ", searchLoc=" + searchLoc + ", addr_section_1="
				+ addr_section_1 + ", addr_section_2=" + addr_section_2 + ", searchDate=" + searchDate + ", searchKey="
				+ searchKey + ", searchWord=" + searchWord + "]";
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		// 선택 record 시작위치
		offsetPoint = (nowPage - 1) * onePageRecord;
		// 표시할 page의 시작번호
		startPage = (nowPage - 1) / onePageCount * onePageCount + 1;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		// 총 page수 구하기
		totalPage = totalRecord / onePageRecord;
		if(totalRecord % onePageRecord != 0) {
			totalPage++;
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getOffsetPoint() {
		return offsetPoint;
	}
	public void setOffsetPoint(int offsetPoint) {
		this.offsetPoint = offsetPoint;
	}
	public int getOnePageCount() {
		return onePageCount;
	}
	public void setOnePageCount(int onePageCount) {
		this.onePageCount = onePageCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public String getSearchLoc() {
		return searchLoc;
	}

	public void setSearchLoc(String searchLoc) {
		this.searchLoc = searchLoc;
	}

	public String getAddr_section_1() {
		return addr_section_1;
	}

	public void setAddr_section_1(String addr_section_1) {
		this.addr_section_1 = addr_section_1;
	}

	public String getAddr_section_2() {
		return addr_section_2;
	}

	public void setAddr_section_2(String addr_section_2) {
		this.addr_section_2 = addr_section_2;
	}

	public String getSearchDate() {
		return searchDate;
	}

	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	
}
