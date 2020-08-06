package ERP.controller.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.account.IFixAssetsDAO;
import ERP.dao.account.IRatioDAO;
import ERP.service.account.IFixAssetsService;
import board.service.IBoardService;
import vo.BoardVO;
import vo.PagingVO;
import vo.SearchVO;
import vo.account.AccountVO;
import vo.account.FixAssetsVO;
import vo.account.RatioVO;

@Controller
@RequestMapping("/account/fixAssets")
public class FixAssetsReadController {
	@Inject
	IFixAssetsService service;
	@Inject
	IFixAssetsDAO fixDao;
	@Inject
	IRatioDAO ratioDao;
	private void set(Model model) {
		model.addAttribute("accountList", fixDao.selectAccountList());
		model.addAttribute("ratioList", ratioDao.selectRatioList());
	}
	@GetMapping("{fixassets_no}")
	public String view(@PathVariable(required = true)  int fixassets_no, Model model ) {
		set(model);
		FixAssetsVO vo = service.readFixAssets(fixassets_no);
		model.addAttribute("fixAssets", vo);
		return "/account/fixAssets/assetsView";
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<FixAssetsVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		FixAssetsVO vo, Model model
		){
		list(currentPage, vo, model);
		return (PagingVO<FixAssetsVO>) model.asMap().get("pagingVO");
	}
	@GetMapping
	public String list(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			FixAssetsVO vo, Model model
			){
		PagingVO<FixAssetsVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(vo);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readFixAssetsCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<FixAssetsVO> fixAssetsList = service.readFixAssetsList(pagingVO);
		pagingVO.setDataList(fixAssetsList);
		
		model.addAttribute("currentAction", "/account/fixAssets/");
		model.addAttribute("pagingVO", pagingVO);
		return "account/fixAssets/assetsList";
	}
	                          
	
	@ModelAttribute("accountList")
	public List<AccountVO> accountListset(){
		return fixDao.selectAccountList();
	}
	
	@Inject
	IRatioDAO dao;
	@GetMapping("ratio")
	public String ratio(Model model) {
		model.addAttribute("list",dao.selectRatioList());
		return "account/fixAssets/ratio";
	}
	
	@GetMapping(value = "ratio", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<RatioVO> listRatio(){
		return dao.selectRatioList();
	}
	
	@PostMapping("ratio")
	@ResponseBody
	public RatioVO selectRatio(@RequestParam int life_year) {
		RatioVO vo = dao.selectRatio(life_year);
		return vo;
	}
}
