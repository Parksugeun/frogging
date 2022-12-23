package com.frogging.app.vo;

import java.util.List;

public class PartyVO {
	private int no;
	private String partyname;
	private int number; // 총 참여인원
	private int current_number; // 총 참여인원
	private int course_no;
	private String id; // 파티장 아이디
	private String content;
	private String meeting_place;
	private String meeting_time;

	// course data
	private String course_name;
	private String time;
	private String distance;

	// p_detail data
	private int join_status;

	// c_detail data
	private String addr;

	// p_request data
	private int reason;

	private List<Integer> noList;

	@Override
	public String toString() {
		return "PartyVO [addr=" + addr + ", content=" + content + ", course_name=" + course_name + ", course_no="
				+ course_no + ", current_number=" + current_number + ", distance=" + distance + ", id=" + id + ", join_status="
				+ join_status + ", meeting_place=" + meeting_place + ", meeting_time=" + meeting_time + ", no=" + no
				+ ", number=" + number + ", partyname=" + partyname + ", time=" + time + "]";
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getPartyname() {
		return partyname;
	}

	public void setPartyname(String partyname) {
		this.partyname = partyname;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public int getCurrent_number() {
		return current_number;
	}

	public void setCurrent_number(int current_number) {
		this.current_number = current_number;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMeeting_place() {
		return meeting_place;
	}

	public void setMeeting_place(String meeting_place) {
		this.meeting_place = meeting_place;
	}

	public String getMeeting_time() {
		return meeting_time;
	}

	public void setMeeting_time(String meeting_time) {
		this.meeting_time = meeting_time;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public int getJoin_status() {
		return join_status;
	}

	public void setJoin_status(int join_status) {
		this.join_status = join_status;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public int getReason() {
		return reason;
	}

	public void setReason(int reason) {
		this.reason = reason;
	}

	public List<Integer> getNoList() {
		return noList;
	}

	public void setNoList(List<Integer> noList) {
		this.noList = noList;
	}

}
