package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	// 페이지네이션 처리를 하기 위해 parameter를 받음
	public List<BoardVO> getList(Criteria cri);	
	
	     
}
