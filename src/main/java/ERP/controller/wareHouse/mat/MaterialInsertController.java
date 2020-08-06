package ERP.controller.wareHouse.mat;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IMaterialService;
import enums.ServiceResult;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/ware/mat")
public class MaterialInsertController {
	// 원자재 컨트롤러
	
	private static Logger logger = LoggerFactory.getLogger(MaterialInsertController.class);
	
	@Inject
	IMaterialService matService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("storeList",othersDAO.selectStoreList());
		model.addAttribute("ruleList",othersDAO.selectMatRuleList());
	}
	
	//0. 원자재 목록 보여주기 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MaterialVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch, Model model
	) throws IOException{
		MatList(currentPage, detailSearch, model);
		return (PagingVO<MaterialVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("list")
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
		return "wh/mat/matListView";
	}
	
	//0-1. 선택한 원자재 상세보기
	@GetMapping("{mat_no}")
	public String MatView(
		@PathVariable(required = true) String mat_no, Model model
	) {
		MaterialVO mat = matService.readMat(mat_no);
		model.addAttribute("mat",mat);
		wareSetting(model);
		return "/wh/mat/matModalView";
	}
	
	//1. 원자재 신규 등록 
	@GetMapping("insert")
	public String MatInsertGet(Model model) {
		wareSetting(model);
		model.addAttribute("currentPage","/ware/mat");
		return "wh/mat/matInsertForm";
	}
	
	@PostMapping
	public String MatInsertPost(
		@Validated
		@ModelAttribute("matVO") MaterialVO matVO,
		BindingResult errors, Model model
	) throws IllegalStateException,IOException {
		
		String msg = null;
		String url = null;
		
		wareSetting(model);
		
		if(!errors.hasErrors()) {
			ServiceResult result = matService.insertMat(matVO);
			switch(result) {
			case FAIL :
				msg = "잠시 뒤에 다시 시도하세요";
				url = "wh/mat/matInsertForm";
				break;
			case OK :
				url = "redirect:/ware/mat/list";
				break;
			}
		}else {
			url = "wh/mat/matInsertForm";
		}
		model.addAttribute("msg",msg);
		return url;
	}
	
}
