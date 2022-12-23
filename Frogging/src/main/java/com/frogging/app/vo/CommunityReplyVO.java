package com.frogging.app.vo;

public class CommunityReplyVO {
	private int reply_no;
	private int no;
	private String id;
	private String content;
	private String writedate;
	private int depth;
	private int reply_group;
	private String nickname;
	

	@Override
	public String toString() {
		return "CommunityReplyVO [reply_no=" + reply_no + ", no=" + no + ", id=" + id + ", content=" + content
				+ ", writedate=" + writedate + ", depth=" + depth + ", reply_group=" + reply_group + "]";
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getReply_group() {
		return reply_group;
	}

	public void setReply_group(int reply_group) {
		this.reply_group = reply_group;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}
