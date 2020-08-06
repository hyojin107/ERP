package ERP.controller.emp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.BoardVO;
import vo.SearchVO;

@Controller
@RequestMapping("emp/register/calendar")
public class CalendarController { // 관리자 달력 
	
	@GetMapping("admin")
	public String list( // 달력 정보 가져오는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/iframe"; //게시판 목록 리스트 
	}

	
	@PutMapping
	@ResponseBody
	public String update( // 일정 수정 
		@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board, 
		BindingResult errors, Model model,
		RedirectAttributes redirectAttributes
	){
//		String goPage = null;
//		String message = null;
//		if (!errors.hasErrors()) {
//			ServiceResult result = service.modifyBoard(board);
//			switch (result) {
//			case FAIL:
//				message = "쫌따 다시 해보셈.";
//				redirectAttributes.addFlashAttribute("board", board);
//				goPage = "redirect:/board/{bo_no}/form";
//				break;
//			case INVALIDPASSWORD:
//				message = "비번 오류.";
//				redirectAttributes.addFlashAttribute("board", board);
//				goPage = "redirect:/board/{bo_no}/form";
//				break;
//			default: // OK
//				goPage = "redirect:/board/{bo_no}";
//				break;
//			}
//		} else {
//			goPage = "redirect:/board/{bo_no}/form";
//			redirectAttributes.addFlashAttribute("board", board);
//			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.board", errors);
//		}
//
//		model.addAttribute("message", message);

		return "emp/iframe"; 
	
	}
	
	
}
