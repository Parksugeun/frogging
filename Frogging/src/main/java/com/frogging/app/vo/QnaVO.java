package com.frogging.app.vo;

import java.util.List;

public class QnaVO {
	private int no;  
	private int reply_group;
	private int depth;
	private int reply_seq;
	private String subject;
	private String content;
	private String id;
	private int hit;
	private String writedate;
	private String name;
	
	private List<Integer> qnaList;
	private String result;
	private int parent_no;




	@Override
	public String toString() {
		return "QnaVO [no=" + no + ", reply_group=" + reply_group + ", depth=" + depth + ", reply_seq=" + reply_seq
				+ ", subject=" + subject + ", content=" + content + ", id=" + id + ", hit=" + hit + ", writedate="
				+ writedate + ", qnaList=" + qnaList + ", result=" + result + "]";
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


	public int getReply_seq() {
		return reply_seq;
	}


	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
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


	public String getResult() {
		return result;
	}


	public void setResult(String result) {
		this.result = result;
	}
	
	public List<Integer> getQnaList() {
		return qnaList;
	}


	public void setQnaList(List<Integer> qnaList) {
		this.qnaList = qnaList;
	}


	public int getParent_no() {
		return parent_no;
	}


	public void setParent_no(int parent_no) {
		this.parent_no = parent_no;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	


	

	


	
}
