package org.zerock.controller;


import java.util.Date;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//@RestController
@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service; //자동주입
	
//	 목록
//	 @GetMapping("/list")
//	 public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list",service.getList());
//	}
	
	// 등록
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		//서비스호출.insert
		service.register(board);
		//view로 데이터전달
		rttr.addFlashAttribute("result",board.getBno());
		return "redirect:/board/list";
	}
	// 상세보기,수정화면
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) { // @ModelAttribute는 model.addAttribute("cri", cri)와 같은 역할을 한다. => criteria의 값을 넘겨주기 위해 사용.
		model.addAttribute("board",service.get(bno));
	}
	// 수정처리
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list" + cri.getListLink();
	}
	// 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr){
		 if (service.remove(bno)) {
			 rttr.addFlashAttribute("result", "success");
		 }
//		 rttr.addAttribute("pageNum", cri.getPageNum());
//		 rttr.addAttribute("amount", cri.getAmount());
//		 rttr.addAttribute("type", cri.getType());
//		 rttr.addAttribute("keyword", cri.getKeyword());
		 
		 return "redirect:/board/list" + cri.getListLink();
	}
	
	// 목록 paging 처리
	@GetMapping
	public void list (Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		
		// 전체 글 수를 가져온다
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
}
