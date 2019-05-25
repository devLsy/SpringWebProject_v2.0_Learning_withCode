package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ =@Autowired)
	private ReplyMapper replyMapper;
	
	/*답변 등록*/
	@Override
	public int register(ReplyVO replyVO) {
		log.info("register add~!!" + replyVO);
		return replyMapper.insert(replyVO);
	}
	
	/*답변 조회*/
	@Override
	public ReplyVO get(Long rno) {
		log.info("reply get: " + rno);
		return replyMapper.read(rno);
	}

	/*답변 삭제*/
	@Override
	public int remove(Long rno) {
		log.info("remove~!!!" + rno);
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

}
