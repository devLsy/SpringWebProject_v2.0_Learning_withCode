package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO replyVO);
	public ReplyVO get(Long bno);
	public int remove(Long bno);
	public int modify(ReplyVO replyVO);
	
	public List<ReplyVO> getList(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
	