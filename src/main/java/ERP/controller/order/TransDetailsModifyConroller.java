package ERP.controller.order;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.order.ITransDetalisService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.order.TransDetailsVO;

@Controller
@RequestMapping("/order/transDetails/{tran_no}")
public class TransDetailsModifyConroller {
	
	@Inject
	ITransDetalisService service;
	
	
	@DeleteMapping
	public String delete() {
		
		return "order/transDetails/transDetailsList";
	}
	
	@GetMapping("form")
	public String updateForm(
			@PathVariable(required = true) String tran_no, Model model
	) {
		System.out.println("폼 띄ㅐ우기");
		System.out.println(tran_no);
		int tran_num = Integer.parseInt(tran_no);
		TransDetailsVO transDetails = service.readTransD(tran_num);
		model.addAttribute("transDetails", transDetails);
		model.addAttribute("currentAction", "/order/tansDetails/"+ tran_num);
		
		return "order/transDetails/transDetailsForm";
	}
	
	@PutMapping
	public String insert(
			@Validated(UpdateGroup.class)
			@ModelAttribute("tansDetails") TransDetailsVO transDetails,
			Errors errors, Model model, @RequestParam(required = false) String currentPage,
			RedirectAttributes redirectAttribute 
	) throws IllegalStateException, IOException {
		
		System.out.println("   put 매핑");
		System.out.println(     transDetails);
		model.addAttribute("currentAction", "/order/transDetails/transDetailsList/" + transDetails.getTran_no());
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyTransD(transDetails);
			
			switch (result) {
			case FAIL:
				message ="잠시후에 다시 시도하세요";
				goPage = "order/transDetails/"+transDetails.getTran_no()+"/form";
				break;

			default: //OK
				goPage = "redirect:/order/transDetails?page="+currentPage;
				redirectAttribute.addFlashAttribute("lastUpdatetransDetails", transDetails);
				break;
			}
		}else {
			goPage ="order/transDetails/"+transDetails.getTran_no()+"Form";
		}
		
		model.addAttribute("message", message);
		
		return goPage;
		
//		return "order/transDetails/transDetailsList";
	}
	
}
