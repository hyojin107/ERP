package board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import board.service.IBoardService;
import enums.ServiceResult;
//
///board/글번호/form	:		BoardModifyController.form
///board/글번호(PUT)	:		BoardModifyController.update
///board/글번호(DELETE)	:	BoardModifyController.delete
import validate.groups.UpdateGroup;
import vo.BoardVO;

@Controller
@RequestMapping("/board/{bo_no}")
public class BoardModifyController {
	@Inject
	IBoardService service;
	
	@ModelAttribute("currentAction")
	public String currentAction(@PathVariable(required = true) int bo_no) {
		return "/board/"+bo_no;
	}
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}
	
	
	
	@GetMapping("form")
	public String form(@PathVariable(required = true) int bo_no, Model model) {
		if(!model.containsAttribute("board")) {
			BoardVO board = service.readBoard(bo_no);
			model.addAttribute("board", board);
		}
		return "board/boardForm";
	}
	
	@PutMapping
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board, 
		BindingResult errors, Model model,
		RedirectAttributes redirectAttributes
	){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyBoard(board);
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				redirectAttributes.addFlashAttribute("board", board);
				goPage = "redirect:/board/{bo_no}/form";
				break;
			case INVALIDPASSWORD:
				message = "비번 오류.";
				redirectAttributes.addFlashAttribute("board", board);
				goPage = "redirect:/board/{bo_no}/form";
				break;
			default: // OK
				goPage = "redirect:/board/{bo_no}";
				break;
			}
		} else {
			goPage = "redirect:/board/{bo_no}/form";
			redirectAttributes.addFlashAttribute("board", board);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.board", errors);
		}
		redirectAttributes.addFlashAttribute("message", message);

		return goPage;
		
	}
	
	@DeleteMapping
	public String delete(
			@ModelAttribute("board") BoardVO board, 
			BindingResult errors, RedirectAttributes redirectAttributes
			){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.removeBoard(board);
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				goPage = "redirect:/board/{bo_no}";
				break;
			case INVALIDPASSWORD:
				message = "비번 오류.";
				goPage = "redirect:/board/{bo_no}";
				break;
			default: // OK
				goPage = "redirect:/board";
				break;
			}
		} else {
			goPage = "redirect:/board/{bo_no}";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		
		return goPage;
		
	}
}


