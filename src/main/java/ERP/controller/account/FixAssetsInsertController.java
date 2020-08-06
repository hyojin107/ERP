package ERP.controller.account;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.dao.account.IFixAssetsDAO;
import ERP.dao.account.IRatioDAO;
import ERP.service.account.IFixAssetsService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.account.FixAssetsVO;

@Controller
@RequestMapping("/account/fixAssets")
public class FixAssetsInsertController {
	@Inject
	IFixAssetsService service;
	@Inject
	IFixAssetsDAO fixDao;
	@Inject
	IRatioDAO ratioDao;
	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/account/fixAssets";
	}
	
	private void set(Model model) {
		model.addAttribute("accountList", fixDao.selectAccountList());
		model.addAttribute("ratioList", ratioDao.selectRatioList());
	}
	
	@GetMapping("form")
	public String form(Model model) {
		set(model);
		return "account/fixAssets/assetsForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("fixAssets") FixAssetsVO fixAssets, BindingResult errors,
		Model model
	) {
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createFixAssets(fixAssets);
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "account/fixAssets/assetsForm";
				break;
			default: // OK
				goPage = "redirect:/account/fixAssets/";
				break;
			}
		} else {
			goPage = "account/fixAssets/assetsForm";
		}

		model.addAttribute("message", message);

		return goPage;
	}
}
