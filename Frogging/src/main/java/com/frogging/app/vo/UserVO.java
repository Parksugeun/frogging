package com.frogging.app.vo;

public class UserVO {


	private String id;
	private String name;
	private String nickname;
	private int height;
	private int sex;
	private int restriction;

	
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", name=" + name + ", nickname=" + nickname + ", height=" + height + ", sex=" + sex
				+ ", restriction=" + restriction + "]";
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getRestriction() {
		return restriction;
	}

	public void setRestriction(int restriction) {
		this.restriction = restriction;
	}

	
}
