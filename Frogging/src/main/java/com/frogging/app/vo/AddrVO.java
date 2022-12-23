package com.frogging.app.vo;

public class AddrVO {
	private int no;
	private String addr_section_1; // 시, 도
	private String addr_section_2; // 시, 군, 구

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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

}
