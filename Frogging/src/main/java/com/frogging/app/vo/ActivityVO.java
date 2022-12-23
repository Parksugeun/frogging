package com.frogging.app.vo;

public class ActivityVO {

	// !!!!!!!!!!!!! db 변경사항 반영할 것 !!!!!!!!!!!!!
	private String id;
	private int course_no;
	private String course_name;
	private double distance;
	private int step;
	private double time;
	private double amount_trash;
	private String before_image;
	private String after_image;
	private String date;
	private int sort;
	private int no;

	// user+total info
	private String nickname;
	private double total_distance;
	private int total_step;
	private int plog_count;
	private double trash_sum;
	private double total_time;

	private int rownum;

	// date
	private String year;
	private String month;
	private String week;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public double getTime() {
		return time;
	}

	public void setTime(double time) {
		this.time = time;
	}

	public double getAmount_trash() {
		return amount_trash;
	}

	public void setAmount_trash(double amount_trash) {
		this.amount_trash = amount_trash;
	}

	public String getBefore_image() {
		return before_image;
	}

	public void setBefore_image(String before_image) {
		this.before_image = before_image;
	}

	public String getAfter_image() {
		return after_image;
	}

	public void setAfter_image(String after_image) {
		this.after_image = after_image;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public double getTotal_distance() {
		return total_distance;
	}

	public void setTotal_distance(double total_distance) {
		this.total_distance = total_distance;
	}

	public int getPlog_count() {
		return plog_count;
	}

	public void setPlog_count(int plog_count) {
		this.plog_count = plog_count;
	}

	public double getTrash_sum() {
		return trash_sum;
	}

	public void setTrash_sum(double trash_sum) {
		this.trash_sum = trash_sum;
	}

	public int getTotal_step() {
		return total_step;
	}

	public void setTotal_step(int total_step) {
		this.total_step = total_step;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public double getTotal_time() {
		return total_time;
	}

	public void setTotal_time(double total_time) {
		this.total_time = total_time;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	
}