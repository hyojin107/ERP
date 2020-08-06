package ERP.controller.account;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.account.ISummaryDAO;
import ERP.service.account.IAccountService;
import vo.PagingVO;
import vo.SearchVO;
import vo.account.AccountVO;
import vo.account.SummaryVO;

@Controller
@RequestMapping("/account/basic/account")
public class AccountReadController {
	@Inject
	IAccountService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AccountVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		SearchVO searchVO, Model model
		){
		list(currentPage, searchVO, model);
		return (PagingVO<AccountVO>) model.asMap().get("pagingVO");
	}
	@GetMapping
	public String list(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, Model model
			){
		PagingVO<AccountVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readAccountCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AccountVO> prodList = service.readAccountList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("currentAction", "/account/basic/account/");
		
		return "account/account/accountList";
	}
	@GetMapping("{account_no}")
	public String view(@PathVariable(required = true)  int account_no, Model model ) {
		AccountVO account = service.readAccount(account_no);
		model.addAttribute("account", account);
		model.addAttribute("standardList", service.readStandardList());
		return "/account/account/accountView";
	}
	
	@GetMapping("stand")
	public List<Map<String, Object>> standaccList(){
		return null;
	}
	@Inject
	ISummaryDAO dao;
	@GetMapping(value = "summary",  produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<SummaryVO> ajaxlist(Model model){
		summary(model);
		return (List<SummaryVO>) model.asMap().get("list");
	}
	@GetMapping("summary")
	public String summary(Model model) {
		List<SummaryVO> list = dao.selectSummaryList();
		model.addAttribute("list", list);
		return "account/account/summary";
	}
}
