package com.frogging.app.vo;

public class PartyDetailVO {
	private int no;
	private int party_no;
	private String user_id;
	private int join_status;
	// 0: 신청 후 대기, 1: 신청 후 수락 완료, 2: 신청 후 거절, 3: 수락 후 퇴장, 4:파티장

	// 유저 닉네임
	private String nickname;

	// 파티 이름
	private String partyname;

	@Override
	public String toString() {
		return "PartyDetailVO [join_status=" + join_status + ", no=" + no + ", party_no=" + party_no + ", user_id="
				+ user_id + "]";
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getParty_no() {
		return party_no;
	}

	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getJoin_status() {
		return join_status;
	}

	public void setJoin_status(int join_status) {
		this.join_status = join_status;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPartyname() {
		return partyname;
	}

	public void setPartyname(String partyname) {
		this.partyname = partyname;
	}

}
