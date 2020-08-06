package ERP.controller.order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

import ERP.service.order.IEstimateService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.order.EstimateListVO;
import vo.order.EstimateVO;

@Controller
@RequestMapping("/order/estimate/{est_no}")
public class EstimateModifyController {
	
	@Inject
	IEstimateService service;
	
	//상품수정------------------------------------------------------------------
	
	
	
	@GetMapping("form")
	public String updateForm(@PathVariable(required = true)String est_no, Model model) {
		int est_num = Integer.parseInt(est_no);
		EstimateVO estimate = service.readEstimate(est_num);
		model.addAttribute("estimate", estimate);
		model.addAttribute("currentAction", "/order/estimate/"+est_num);
		return "order/estimate/estimateForm";
	}
	
	@PutMapping
	public String update(
		@Validated(UpdateGroup.class) 
		@ModelAttribute("estimate") EstimateVO estimate,
		@ModelAttribute("estimateList") EstimateListVO estimateList,
		@RequestParam(required = false) int[] est_no,
		@RequestParam(required = false) String[] prod_no,
		@RequestParam(required = false) int[] est_qty,
		Errors errors, Model model, @RequestParam(required = false) String currentPage,
		RedirectAttributes redirectAttribute
		) throws IllegalStateException, IOException {
		
		//리스트 넣어주기-------------------------------------------------
		List<EstimateListVO> list = new ArrayList<>();
		if(prod_no!=null) {
			for(int i=0; i<prod_no.length; i++) {
				EstimateListVO vo = new EstimateListVO();
				vo.setEst_no(estimateList.getEst_no());
				vo.setProd_no(prod_no[i]);
				vo.setEst_qty(est_qty[i]);
				list.add(vo);
			}
		}
		estimate.setEstimateList(list);
		//------------------------------------------------------------
		
//		model.addAttribute("estimate", estimate);
//		model.addAttribute("estimateList", estimateList);
		
		model.addAttribute("currentAction", "/order/estimate/estimateList"+estimate.getEst_no());
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyEstimate(estimate);
			for(int i=0; i<list.size(); i++) {
				ServiceResult resultList = service.modifyEstimateList(list.get(i));
			}
			switch (result) {
			case FAIL:
				message ="잠시후에 다시 시도하세요";
				goPage = "redirect:/order/estimate/"+estimate.getEst_no()+"/form";
				break;

			default: //OK
				goPage = "redirect:/order/estimate";
				redirectAttribute.addFlashAttribute("lastUpdateEstimate", estimate);
				break;
			}
		}else {
			System.out.println("에러뜬거임");
			goPage ="redirect:/order/estimate/"+estimate.getEst_no()+"/form";
		}
		
		model.addAttribute("message", message);
		
//		return "order/estimate/estimateList";
		return goPage;
	}
	
}
