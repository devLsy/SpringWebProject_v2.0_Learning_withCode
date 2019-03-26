package org.zerock.mapper;

import org.zerock.domain.ReplyVO;

/*답변처리 위한 interface*/
public interface ReplyMapper {
	
	public void insert(ReplyVO replyVO);
	public ReplyVO read(Long bno);
	public int delete(Long bno);
	
}
	