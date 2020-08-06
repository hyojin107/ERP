package ERP.controller.wareHouse.outer;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IOuterProdService;
import vo.PagingVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("/outer/prod")
public class OuterProdController {

	// 출고관리 : 상품 목록 보여주고 생산의뢰서 작성폼으로 넘어가기 
	
	private static Logger logger = LoggerFactory.getLogger(OuterProdController.class);
	
	@Inject
	IOuterProdService OprodService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("storeList",othersDAO.selectStoreList());
		model.addAttribute("ruleList",othersDAO.selectProdRuleList());
	}
	
	// 1. 상품 목록 보여주기 - get
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ProdVO> ajaxForList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		ProdVO detailSearch, Model model
	)throws IOException{
		OuProdListViewGet(currentPage, detailSearch, model);
		return (PagingVO<ProdVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("prodlist")
	public String OuProdListViewGet(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		ProdVO detailSearch, Model model
	) throws IOException{
		wareSetting(model);
		PagingVO<ProdVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = OprodService.ProdLackCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ProdVO> prodList = OprodService.ProdLackList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "wh/outer/outProdListView";		
	}
}
