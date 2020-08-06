package ERP.controller.wareHouse.prod;

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

import ERP.service.wareHouse.IProdService;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Controller
@RequestMapping("/ware/prod/search")
public class ProdSearchController {

	// BOM등록시 원자재를 검색할 창 을 띄우는 controller
	
	private static Logger logger = LoggerFactory.getLogger(ProdSearchController.class);
	
	@Inject
	IProdService prodService;
	
	// 1. 조건에 맞는  원자재 보여주기 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MaterialVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch, Model model
	)throws IOException{
		matList(currentPage, detailSearch, model);
		return (PagingVO<MaterialVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("matsearch")
	public String matList(
		@RequestParam(name="page",required = false, defaultValue = "1") int currentPage,
		MaterialVO detailSearch, Model model) 
	throws IOException{
		PagingVO<MaterialVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = prodService.searchMatCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<MaterialVO> matList = prodService.searchMatList(pagingVO);
		pagingVO.setDataList(matList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "/wh/prod/prodInsertForm";
	}
	
	// 2. 원자재 이름만 저장하기
	@GetMapping("matnamesearch")
	@ResponseBody // 무조건 json 
	public List<String> matNameList() {
		List<String> matList = prodService.serarchMatNameList();
		return matList;
	}
}
