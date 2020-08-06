package ERP.controller.wareHouse.prod;

import java.io.IOException;
import java.util.ArrayList;
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
import ERP.service.wareHouse.IProdService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.PagingVO;
import vo.wareHouse.BOMVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("/ware/prod")
public class ProdInsertController {
	//상품 컨트롤러 
	
	private static Logger logger = LoggerFactory.getLogger(ProdInsertController.class);
	
	@Inject
	IProdService prodService;
	
	@Inject
	IWareOthersDAO othersDAO;
	
	private void wareSetting(Model model) {
		model.addAttribute("lprodList",othersDAO.selectLprodList());
		model.addAttribute("ruleList",othersDAO.selectProdRuleList());
		model.addAttribute("matUserruleList",othersDAO.selectMatRuleList());
	}
	
	// 0. 상품 목록 보여주기 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ProdVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		ProdVO detailSearch, Model model
	)throws IOException{
		ProdList(currentPage, detailSearch, model);
		return (PagingVO<ProdVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("list")
	public String ProdList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		ProdVO detailSearch, Model model
	) throws IOException{
		wareSetting(model);
		PagingVO<ProdVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = prodService.readProdCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ProdVO> prodList = prodService.readProdList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "wh/prod/prodListView";
	}
	
	// 0-1. 선택 상품 상세보기 
	@GetMapping("{prod_no}")
	public String prodView(
		@PathVariable(required = true) String prod_no, Model model
	) {
		ProdVO prod = prodService.readProd(prod_no);
		model.addAttribute("prod",prod);
		wareSetting(model);
		return "/wh/prod/prodModalView";
	}
	
	// 1. 상품 신규 등록
	@GetMapping("insert")
	public String ProdInsertGet(Model model) {
		wareSetting(model);
		return "wh/prod/prodInsertForm";
	}
	
	@PostMapping
	public String ProdInsertPost(
		@Validated(InsertGroup.class) @ModelAttribute("prodVO") ProdVO prodVO,
		@RequestParam(required = false) String[] mat_no,
		@RequestParam(required = false) String[] mat_name,
		@RequestParam(required = false) Integer[] mat_number,
		@RequestParam(required = false) String[] mat_size, 
		BindingResult errors, Model model
	) throws IllegalStateException, IOException{ 
		List<BOMVO> list = new ArrayList<>();
		if(mat_no!=null) {
			for(int i=0; i< mat_no.length; i++) {
				BOMVO vo = new BOMVO();
				vo.setMat_no(mat_no[i]);
				vo.setMat_number(mat_number[i]);
				vo.setMat_size(mat_size[i]);
				list.add(vo);
			}
		}
		prodVO.setBomlist(list);
		String msg = null;
		String url = null;
		if(!errors.hasErrors()) {
			ServiceResult result = prodService.insertProd(prodVO);
			switch(result) {
			case FAIL:
				msg = "조금뒤에 다시 시도하세요";
				url = "wh/prod/prodInsertForm";
				break;
			default :
				url = "redirect:/ware/prod/list";
				break;
			}
		}else {
			url = "wh/prod/prodInsertForm";
		}
		
		model.addAttribute("msg",msg);
		return url; 
	}
		
}
