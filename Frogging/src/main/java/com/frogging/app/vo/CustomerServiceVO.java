package com.frogging.app.vo;

import java.util.List;

public class CustomerServiceVO {
	private int no;  
	private int reply_group;
	private int depth;
	private String subject;
	private String content;
	private String id;
	private int hit;
	private String writedate;
	private String name;
	
	private List<Integer> customerServiceList;



	@Override
	public String toString() {
		return "CustomerServiceVO [no=" + no + ", reply_group=" + reply_group + ", depth=" + depth + ", subject="
				+ subject + ", content=" + content + ", id=" + id + ", hit=" + hit + ", writedate=" + writedate
				+ ", customerServiceList=" + customerServiceList + "]";
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getReply_group() {
		return reply_group;
	}


	public void setReply_group(int reply_group) {
		this.reply_group = reply_group;
	}


	public int getDepth() {
		return depth;
	}


	public void setDepth(int depth) {
		this.depth = depth;
	}


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public int getHit() {
		return hit;
	}


	public void setHit(int hit) {
		this.hit = hit;
	}


	public String getWritedate() {
		return writedate;
	}


	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}


	public List<Integer> getCustomerServiceList() {
		return customerServiceList;
	}


	public void setCustomerServiceList(List<Integer> customerServiceList) {
		this.customerServiceList = customerServiceList;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}

	



	

	


	
}
