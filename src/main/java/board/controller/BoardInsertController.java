package board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import board.service.IBoardService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.BoardVO;

/**
 * 첨부파일을 포함한 게시글 등록 단계
 * 1. BoardVO 에서 업로드 되는 Part 정보를 받을 수 있도록 property 추가
 *    MultipartFile[] bo_files
 *    setter 를 구현하고, 비어있는 Part 정보를 걸러냄.
 * 2. AttatchVO 에서 adapter pattern 을 적용하여, 
 *    파일의 메타데이터와 이진데이터를 캡슐화할 수 있도록 생성자 정의.
 *    AttatchVO(MultipartFile boFile)
 *    해당 생성자 내부에서 파일의 메타데이터를 분리하여, AttatchVO의 각 프로퍼티값을 결정해줌.
 * 3. board.xml 과 attatch.xml 에 게시글의 일반 데이터와 첨부파일의 메타데이터를 
 *    insert 할수 있는 쿼리 작성.
 *    주의! 첨부파일 insert 시 bo_no 와 att_no 생성에 주의해야 함.
 * 4. 첨부파일의 메타데이터 저장이 끝나면, 파일의 이진 데이터를 정해진 폴더에 저장해야함.
 * 	  appInfo.properties 의 attatchPath 로 결정된 폴더에 저장하기 위한 로직이 필요함.
 *    processAttatches 메소드 참고.	
 *           
 *
 */
@Controller
@RequestMapping("/board")
public class BoardInsertController {
	@Inject
	IBoardService service;
	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/board";
	}
	
	@GetMapping("form")
	public String form(@ModelAttribute("board") BoardVO board) {
		return "board/boardForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO board, BindingResult errors,
		Model model
	) {
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createBoard(board);
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				goPage = "board/boardForm";
				break;
			default: // OK
				goPage = "redirect:/board/"+board.getBo_no();
				break;
			}
		} else {
			goPage = "board/boardForm";
		}

		model.addAttribute("message", message);

		return goPage;
	}
}
