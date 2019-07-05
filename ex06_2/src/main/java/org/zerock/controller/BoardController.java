package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	// 전체 게시글 조회
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	// 게시글 등록처리
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String resister(BoardVO board, RedirectAttributes rttr) {
		
		log.info("==============================================");
		log.info("register: " + board.toString());
			
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("==============================================");
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}	
	
	// 게시글 입력 폼 처리
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	// 게시글 상세 조회
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	// 게시글 수정
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		
		log.info("modify: " + board);
				
		if(service.modify(board)) {	
			log.info("service.modify request!");
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();	
	}
		
	// 게시글 삭제	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
		
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri, String writer) {
		
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		log.info("attachList: " + attachList);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);	
			rttr.addFlashAttribute("result", "success");	
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}		
	
	@GetMapping(value = "/getAttachList",
						produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(bno), HttpStatus.OK);
		
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files~!!");
		log.info("attachList: " + attachList);
		
		attachList.forEach(attach -> {
				try {
					Path file = Paths.get("C:\\dev\\private\\upload\\tmp" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
					log.info("file: " + file);
					Files.deleteIfExists(file);
					
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("C:\\dev\\private\\upload\\tmp" + attach.getUploadPath() + "\\s_" + attach.getUuid()+ "_" + attach.getFileName());
						log.info("thumbNail: " + thumbNail);
						Files.delete(thumbNail);
					}
				} catch (Exception e) {
						log.error("delete file error: " + e.getMessage());
				} // end catch
			
		}); // end foreach
		
	}
	
	
	
	
	
	
}
