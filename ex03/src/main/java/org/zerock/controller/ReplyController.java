package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@Log4j
@AllArgsConstructor
@RestController
/*답변처리를 위한 컨트롤러*/
public class ReplyController {
	
	private ReplyService replyService;
	
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> create(@RequestBody ReplyVO replyVO) {
	
		log.info("replyVO: " + replyVO);
		int insertCount = replyService.register(replyVO);
		
		log.info("Reply INSERT COUNT: " + insertCount);
		// return값이 1이면 성공, 아닌 경우 에러 전송
		return insertCount == 1 
				? new ResponseEntity<>("success", HttpStatus.OK) : 
				   new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				
	}
	
	
}
