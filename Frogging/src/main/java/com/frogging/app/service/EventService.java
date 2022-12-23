package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.EventPagingVO;
import com.frogging.app.vo.EventVO;

public interface EventService {
	// 이벤트게시판 글목록
	public List<EventVO> eventList(EventPagingVO pVO);

	public List<EventVO> eventList_home(EventPagingVO pVO);

	// 이벤트등록 추후 관리자만 버튼이 보이도록
	public int eventWrite(EventVO vo);

	// 이벤트 내용보기
	public EventVO getEvent(int no);

	// 수정
	public int eventEdit(EventVO vo);

	public int eventEditOk(EventVO vo);

	// 삭제
	public int eventDel(int no, String id);

	// 조회수
	public void hitCount(int no);

	// 총레코드 수
	public int totalRecord(EventPagingVO pVO);

	public EventVO getImgName(String imgName);
}
