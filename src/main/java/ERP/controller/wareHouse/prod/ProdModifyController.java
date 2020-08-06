package ERP.controller.wareHouse.prod;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IProdService;
import enums.ServiceResult;
import vo.wareHouse.BOMVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("ware/prod")
public class ProdModifyController {
	// 상품 컨트롤러 (수정)
	
	private static Logger logger = LoggerFactory.getLogger(ProdInsertController.class);
	
	@Inject
	IProdService prodService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("ruleList",othersDAO.selectProdRuleList());
		model.addAttribute("matUserruleList",othersDAO.selectMatRuleList());
	}
	
	@ModelAttribute("methodType")
	public String methodName() {
		return "put";
	}
	
	// 2. 상품 수정
	@GetMapping("update/{prod_no}")
	public String ProdModifyGet(
		@PathVariable(name="prod_no") String prod_no, Model model
	) {
		wareSetting(model);
		ProdVO prodVO = prodService.readProd(prod_no);
		model.addAttribute("prodVO",prodVO);
		model.addAttribute("currentAction","/ware/prod/list/"+prod_no);
		return "wh/prod/prodInsertForm";
	}
	
	@PutMapping
	public String ProdModifyPost(		
		@Validated
		@ModelAttribute("prodVO") ProdVO prodVO,
		@ModelAttribute("bomVO") BOMVO bomVO,
		@RequestParam(required = false) String[] mat_no,
		@RequestParam(required = false) String[] mat_name,
		@RequestParam(required = false) Integer[] mat_number,
		@RequestParam(required = false) String[] mat_size, 
		BindingResult errors, 
		Model model, RedirectAttributes redirectattributes
	) throws IOException, ServletException  {
		List<BOMVO> list = new ArrayList<>();
		if(mat_no!=null) {
			for(int i=0; i< mat_no.length; i++) {
				BOMVO vo = new BOMVO();
				vo.setProd_no(prodVO.getProd_no());
				vo.setMat_no(mat_no[i]);
				vo.setMat_number(mat_number[i]);
				vo.setMat_size(mat_size[i]);
				list.add(vo);
			}
		}
		prodVO.setBomlist(list);
		
		model.addAttribute("currentAction","/ware/prod/list/"+prodVO.getProd_no());
		
		String url = null;
		String msg = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = prodService.modifyProd(prodVO);
			for(int i=0; i<list.size(); i++) {
				ServiceResult resultbom = prodService.modifyBOM(list.get(i));
			}
			switch(result) {
			case FAIL : 
				msg = "나중에 다시 시도하세요 ";
				url = "redirect:/ware/prod/update/"+prodVO.getProd_no();
				break;
			default : 
				url = "redirect:/ware/prod/list";
				redirectattributes.addFlashAttribute("lastUpdateProd",prodVO);
				break;
			}
		}else {
			url = "redirect:/ware/prod/update/"+prodVO.getProd_no();
		}
		model.addAttribute("msg",msg);
		return url;
	}
	
}
