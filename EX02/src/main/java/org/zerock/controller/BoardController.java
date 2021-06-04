package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register") // 메소드 오버로딩
	public String register(BoardVO board, RedirectAttributes rttr) {
		// BoardService호출. insert가 진행된다.
		service.register(board);
		
		// view로 데이터 전달. lombok에서 자동으로 VO의 getter를 생성해준다.
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
}
