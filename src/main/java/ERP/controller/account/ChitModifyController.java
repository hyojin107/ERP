package ERP.controller.account;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.account.IChitService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.BoardVO;
import vo.account.ChitVO;

@Controller
@RequestMapping("/account/chit")
public class ChitModifyController {
	@Inject
	IChitService service;
	
	@PutMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> update(
		@Validated(UpdateGroup.class) ChitVO vo, 
		BindingResult errors
	){
		Map<String, Object> map = new HashMap<>();
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyChit(vo);
			if(result==ServiceResult.OK) 
				map.put("chit_no","수정 성공");
		} else {
			map.put("chit_no","수정 실패");
		}
		return map;
	}
	
	@DeleteMapping
	public String delete(
			@ModelAttribute("board") BoardVO board, 
			BindingResult errors, RedirectAttributes redirectAttributes
			){
//		String goPage = null;
//		String message = null;
//		if (!errors.hasErrors()) {
//			ServiceResult result = service.removeBoard(board);
//			switch (result) {
//			case FAIL:
//				message = "쫌따 다시 해보셈.";
//				goPage = "redirect:/board/{bo_no}";
//				break;
//			case INVALIDPASSWORD:
//				message = "비번 오류.";
//				goPage = "redirect:/board/{bo_no}";
//				break;
//			default: // OK
//				goPage = "redirect:/board";
//				break;
//			}
//		} else {
//			goPage = "redirect:/board/{bo_no}";
//		}
//		
//		redirectAttributes.addFlashAttribute("message", message);
//		
//		return goPage;
		return null;
		
	}
}


