package ERP.controller.account;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.account.ISummaryDAO;
import ERP.service.account.IAccountService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.account.AccountVO;
import vo.account.SummaryVO;

@Controller
@RequestMapping("/account/basic/account")
public class AccountInsertController {
	@Inject
	IAccountService service;
	@Inject
	ISummaryDAO sumDao;
	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/account/basic/account";
	}
	
	@GetMapping("form")
	public String form(@ModelAttribute("account") AccountVO account, Model model) {
		model.addAttribute("standardList", service.readStandardList());
		return "account/account/accountForm";
	}
	
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("account") AccountVO account, BindingResult errors,
		Model model
	) {
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createAccount(account);
			switch (result) {
			case FAIL:
				message = "잠시후 다시 시도해주세요.";
				goPage = "account/account/accountForm";
				break;
			default: // OK
				goPage = "redirect:/account/basic/account";
				break;
			}
		} else {
			goPage = "account/account/accountForm";
		}

		model.addAttribute("message", message);

		return goPage;
	}
	@PostMapping(value = "summary")
	@ResponseBody
	public String insertSummary(
			@Validated(InsertGroup.class) @ModelAttribute("summary") SummaryVO vo, BindingResult errors
		) {
			String result= null;
			if (!errors.hasErrors()) 
				result = sumDao.insertSummary(vo) == 1? "success" : "fail";
				
			return result;
		}

	@DeleteMapping("summary")
	@ResponseBody
	public String deleteSummary(@RequestParam(required = true) int summary_no) {
		String result = null;
		result = sumDao.deleteSummary(summary_no) == 1? "success" : "fail";
		return result;
	}
}
