package ERP.controller.wareHouse.enter;

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

import ERP.controller.wareHouse.mat.MaterialInsertController;
import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IEnterMatService;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/enter/mat")
public class EnterMatController {

	// 원자재, 상품 입고
	private static Logger logger = LoggerFactory.getLogger(MaterialInsertController.class);
	
	@Inject
	IEnterMatService enterService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("storeList",othersDAO.selectStoreList());
		model.addAttribute("ruleList",othersDAO.selectMatRuleList());
	}
	
	// 1. 원자재 목록 보여주기 - get 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MaterialVO> ajaxForList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch,
		Model model
	)throws IOException{
		EnMatListViewGet(currentPage,detailSearch,model);
		return (PagingVO<MaterialVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("matlist")
	public String EnMatListViewGet(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch, Model model
	) throws IOException{
		wareSetting(model);
		PagingVO<MaterialVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setDetailSearch(detailSearch); 
		pagingVO.setCurrentPage(currentPage);

		int totalRecord = enterService.MatLackCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MaterialVO> matList = enterService.MatLackList(pagingVO);
		pagingVO.setDataList(matList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "wh/enter/enMatListView";
	}
	
	// 5. 입고신청 목록 보기 (생산보고서, 반품의뢰서, 매입서 불러오기 )
	@GetMapping("requestlist")
	public String EnRequestListViewGet() {
		return "wh/enter/enRequestListView";
	}
}
