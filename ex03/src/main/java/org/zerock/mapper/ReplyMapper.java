package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

/*답변처리 위한 interface*/
public interface ReplyMapper {
	
	public int insert(ReplyVO replyVO);
	public ReplyVO read(Long rno);
	public int delete(Long rno);	
	public int update(ReplyVO replyVO);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno); 
	
	/*전체 댓글 숫자 조회*/
	public int getCountByBno(Long bno);
}
		