package ERP.controller.account;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.account.IFixAssetsService;
import enums.ServiceResult;
//
///fixAssets/글번호/form	:		FixAssetsModifyController.form
///fixAssets/글번호(PUT)	:		FixAssetsModifyController.update
///fixAssets/글번호(DELETE)	:	FixAssetsModifyController.delete
import validate.groups.UpdateGroup;
import vo.account.FixAssetsVO;

@Controller
@RequestMapping("/account/fixAssets/{fixassets_no}")
public class FixAssetsModifyController {
	@Inject
	IFixAssetsService service;
	
	@ModelAttribute("currentAction")
	public String currentAction(@PathVariable(required = true) int fixassets_no) {
		return "/account/fixAssets/";
	}
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}
	
	@PutMapping(produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("fixAssets") FixAssetsVO fixAssets, 
		BindingResult errors
	){
		System.out.println(fixAssets.getImg());
		String goPage = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyFixAssets(fixAssets);
			switch (result) {
			case FAIL:
				goPage = "수정실패";
				break;
			default: 
				goPage = "수정성공";
				break;
			}
		} else {
			goPage = "자료입력 오류";
		}
		return goPage;
	}
	
	@DeleteMapping
	public String delete(
			@ModelAttribute("fixAssets") FixAssetsVO fixAssets, 
			BindingResult errors, RedirectAttributes redirectAttributes
			){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.removeFixAssets(fixAssets);
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				goPage = "redirect:/account/fixAssets/{bo_no}";
				break;
			case INVALIDPASSWORD:
				message = "비번 오류.";
				goPage = "redirect:/account/fixAssets/{bo_no}";
				break;
			default: // OK
				goPage = "redirect:/account/fixAssets";
				break;
			}
		} else {
			goPage = "redirect:/account/fixAssets/{bo_no}";
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		
		return goPage;
		
	}
}


