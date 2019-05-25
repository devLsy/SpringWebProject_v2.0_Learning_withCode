package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service		
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	// 글 등록
	public void register(BoardVO board) {
		
		log.info("resister...." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	// 글 조회
	public BoardVO get(Long bno) {
		
		log.info("get..." + bno);
		return mapper.read(bno);
	}

	@Override
	// 글 수정
	public boolean modify(BoardVO board) {
		
		log.info("modify..." + board);
		return mapper.update(board) == 1;
	}

	@Override
	// 글 삭제
	public boolean remove(Long bno) {
		
		log.info("remove..." + bno);
		return mapper.delete(bno) == 1;
	}
	
	@Override
	// 전체글 조회
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	// 전체 게시글 수 조회
	public int getTotal(Criteria cri) {
		log.info("get total count..");
		return mapper.getTotalCount(cri);
	}



}
