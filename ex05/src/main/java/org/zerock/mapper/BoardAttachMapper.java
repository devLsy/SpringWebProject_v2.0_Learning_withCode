package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO boardAttachVO);
	
	public void delete(BoardAttachVO boardAttachVO);
	
	public List<BoardAttachVO> findByBno(Long bno);
}
