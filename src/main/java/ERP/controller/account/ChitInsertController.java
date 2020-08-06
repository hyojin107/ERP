package ERP.controller.account;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.service.account.IChitService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.account.ChitVO;
import vo.account.ChitlistVO;

@Controller
@RequestMapping("/account/chit")
public class ChitInsertController {
	@Inject
	IChitService service;
	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/account/chit";
	}
	
	@GetMapping("form")
	public String form(@ModelAttribute("chit") ChitVO chit) {
		
		return "account/chit/chitForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("chit") ChitVO chit, BindingResult errors,
		Model model, Integer[] price, Integer[] qty, String[] product, String[] summary
	) {
		List<ChitlistVO> list = new ArrayList<>();
		if(price!=null) {
			for(int i = 0; i < price.length; i++) {
				ChitlistVO vo = new ChitlistVO();
				vo.setPrice(price[i]);
				vo.setProduct(product[i]);
				vo.setQty(qty[i]);
				if(summary!=null && summary.length>0)
				vo.setSummary(summary[i]);
				list.add(vo);
			}
		}
		chit.setChitList(list);
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createChit(chit);
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "account/chit/chitForm";
				break;
			default: // OK
				goPage = "redirect:/account/chit/";
				break;
			}
		} else {
			goPage = "account/chit/chitForm";
		}

		model.addAttribute("message", message);

		return goPage;
	}
}
