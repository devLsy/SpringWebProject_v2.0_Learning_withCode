package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface BoardService {

	public void register(BoardVO board);
	
	
	// 회원가입 처리
	public void registerMember(MemberVO memberVO);
	// 회원 권한부여 처리
	public void registerAuth(MemberVO memberVO);
		
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	// 페이지네이션 처리를 하기 위해 parameter를 받음
	public List<BoardVO> getList(Criteria cri);	
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);

	     
}
