package ERP.controller.wareHouse.mat;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IMaterialService;
import enums.ServiceResult;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/ware/mat")
public class MaterialModifyController {
 // 원자재 컨트롤러 (수정, 삭제(사용여부 N), 상세보기)
	
	@Inject
	IMaterialService matService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("ruleList",othersDAO.selectMatRuleList());
	}
	
	//2. 원자재 수정
	@GetMapping("update/{mat_no}")
	public String MatModifyGet(
		@PathVariable(name="mat_no") String mat_no, Model model
	) {
		wareSetting(model);
		MaterialVO matVO = matService.readMat(mat_no);
		model.addAttribute("matVO", matVO);
		model.addAttribute("currentAction", "/ware/mat/list/"+mat_no);
		return "wh/mat/matInsertForm";
	}
	
	@PutMapping
	public String MatModifyPut(
		@Validated
		@ModelAttribute("matVO") MaterialVO matVO,
		Errors errors,
		@RequestParam(required = false, defaultValue = "1") String currentPage,
		Model model, 
		RedirectAttributes redirectattributes
	) throws IOException, ServletException {
		
		model.addAttribute("currentAction","/ware/mat/list/"+matVO.getMat_no());
		
		String url = null;
		String msg = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = matService.modifyMat(matVO);
			switch(result) {
			case FAIL:
				msg="나중에 다시 시도하세요";
				url = "redirect:/ware/mat/update/"+matVO.getMat_no();
				break;
			default : 
				url = "redirect:/ware/mat/list?page="+currentPage;
				redirectattributes.addFlashAttribute("lastUpdateMat", matVO);
				break;
			}
		}else {
			url = "redirect:/ware/mat/update/"+matVO.getMat_no();
		}
		model.addAttribute("msg",msg);
		return url;
	}
	
	// 원자재 삭제 (사용여부 > G001(Y) , G002(N) )
//	@PostMapping(value = "delteMat")
//	public String MatDel(){
//	return null;
//	}
	
}
