package com.zerock.controller;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTests {
	
	private Long[] bnoArr = {4194306L, 4194305L, 4194304L, 4194303L, 4194302L};
	
	@Setter(onMethod_ =@Autowired)
	private ReplyMapper replyMapper;
	
//	@Test
//	public void testCreate() {
//		
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			
//			ReplyVO replyVO = new ReplyVO();
//			
//			replyVO.setBno(bnoArr[i % 5]);
//			replyVO.setReply("댓글 테스트" + i);
//			replyVO.setReplyer("replyer" + i);
//			
//			replyMapper.insert(replyVO);
//			
//			
//		});
//	}
	
//	@Test
//	public void testRead() {
//			
//		Long targetRno = 5L;
//		
//		ReplyVO replyVO = replyMapper.read(targetRno);
//		log.info("replyVO: " + replyVO);
//	}
	
	@Test
	public void delete() {
		
		Long targetRno = 2L;
		
		replyMapper.delete(targetRno);	
		
	}
}
