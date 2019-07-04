package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO boardAttachVO);
	
	public void delete(BoardAttachVO boardAttachVO);
	
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
	
	// 어제 등록된 파일 목록 조회(db와 실제 경로의 파일 목록 비교하기 위함)
	public List<BoardAttachVO> getOldFiles();
}	
