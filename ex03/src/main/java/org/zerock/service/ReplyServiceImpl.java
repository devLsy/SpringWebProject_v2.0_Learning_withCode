package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ =@Autowired)
	private ReplyMapper replyMapper;
	
	@Setter(onMethod_ =@Autowired)
	private BoardMapper boardMapper;
	
	/*답변 등록*/
	@Transactional
	@Override
	public int register(ReplyVO replyVO) {
		log.info("register add~!!" + replyVO);
		boardMapper.updateReplyCnt(replyVO.getBno(),1);
		return replyMapper.insert(replyVO);
	}
	
	/*답변 조회*/
	@Override
	public ReplyVO get(Long rno) {
		log.info("reply get: " + rno);
		return replyMapper.read(rno);
	}

	/*답변 삭제*/
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove~!!!" + rno);
		ReplyVO replyVO  = replyMapper.read(rno);
		
		boardMapper.updateReplyCnt(replyVO.getBno(), -1);
		return replyMapper.delete(rno);
	}
	
	/*답변 수정*/	
	@Override
	public int modify(ReplyVO replyVO) {
		log.info("modify~!!" + replyVO);	
		return replyMapper.update(replyVO);
	}
	
	/*답변 목록 조회*/	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Spring5_Board: " + bno);
		return replyMapper.getListWithPaging(cri, bno);
	}
	
	/*댓글 전체 갯수 조회*/
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(replyMapper.getCountByBno(bno), replyMapper.getListWithPaging(cri, bno));
	}

}
