package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service; //자동주입
	
	//목록
//	@GetMapping("/list")
//	public void list(Model model) throws Exception {
//		log.info("list");
//		model.addAttribute("list",service.getList());
//	}
	@GetMapping("/list")
	public void list(Criteria cri,Model model){
		log.info("list");
		model.addAttribute("list",service.getList(cri));
		int total=service.getTotal(cri);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	
	//등록
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		//서비스호출.insert
		service.register(board);
		//view로 데이터전달
		rttr.addFlashAttribute("result",board.getBno());
		return "redirect:/board/list";
	}
	
	//상세보기,수정화면
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,Model model) {
		model.addAttribute("board",service.get(bno));
	}
	
	
	//수정처리
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list"+cri.getListLink();
	}
	//삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr)
	{
		 log.info("remove..." + bno);
		 List<BoardAttachVO> attachList = service.getAttachList(bno);

			if (service.remove(bno)) {
				
				deleteFiles(attachList);

				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/board/list" + cri.getListLink();
	}	
	//첨부파일목록
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
	    
	    if(attachList == null || attachList.size() == 0) {
	      return;
	    }
	    
	    log.info("delete attach files...................");
	    log.info(attachList);
	    
	    attachList.forEach(attach -> {
	      try {        
	        Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
	        
	        Files.deleteIfExists(file);
	        //이미지이면 썸네일도 삭제
	        if(Files.probeContentType(file).startsWith("image")) {
	        
	          Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
	          
	          Files.delete(thumbNail);
	        }
	
	      }catch(Exception e) {
	        log.error("delete file error" + e.getMessage());
	      }
	    });
	  }
}
