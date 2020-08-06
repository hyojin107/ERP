package ERP.controller.buy;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IMaterialService;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/buy/incost")
public class InCostController {
	
	@Inject
	IMaterialService matService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("storeList",othersDAO.selectStoreList());
		model.addAttribute("ruleList",othersDAO.selectMatRuleList());
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MaterialVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch, Model model
	) throws IOException{
		MatList(currentPage, detailSearch, model);
		return (PagingVO<MaterialVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping()
	public String MatList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch,
		Model model
	) throws IOException
	{
		wareSetting(model);
		PagingVO<MaterialVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setDetailSearch(detailSearch); // 상세 검색 조건 
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = matService.readMatCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MaterialVO> matList = matService.readMatList(pagingVO);
		pagingVO.setDataList(matList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "buy/incost/inCostList";
	}
	
	
}
