package ERP.controller.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.account.IFixAssetsDAO;
import ERP.service.account.IFixMinusService;
import vo.account.AccountVO;
import vo.account.FixAssetsVO;
import vo.account.FixMinusVO;

@Controller
@RequestMapping("/account/fixAssets/fixMinus")
public class FixMinusReadController {
	@Inject
	IFixAssetsDAO fixDao;
	@Inject
	IFixMinusService service;
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<FixAssetsVO> ajaxForlist(
		FixMinusVO vo, Model model
		){
		list(vo, model);
		return (List<FixAssetsVO>) model.asMap().get("fixList");
	}
	@GetMapping
	public String list(
			FixMinusVO vo, Model model	
			){
		List<FixAssetsVO> fixList = service.readFixMinusList(vo);
		FixMinusVO minusVO = fixDao.selectfixdate();
		model.addAttribute("fixList", fixList);
		model.addAttribute("fixDate", minusVO);
		
		return "account/statistics/fixMinusList";
	}
	@ModelAttribute("accountList")
	public List<AccountVO> accountListset(){
		return fixDao.selectAccountList();
	}
//	@GetMapping("{bo_no}")
//	public String view(@PathVariable(required = true)  int bo_no, Model model ) {
//		BoardVO board = service.readBoard(bo_no);
//		model.addAttribute("board", board);
//		return "board/boardView";
//	}
}
