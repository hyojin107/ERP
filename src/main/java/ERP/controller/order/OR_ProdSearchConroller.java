package ERP.controller.order;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.wareHouse.IProdService;
import vo.PagingVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("/order/prodSearch")
public class OR_ProdSearchConroller {
	//상품검색 컨트롤러
	
	@Inject
	IProdService prodService;
	
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
//			wareSetting(model);
			PagingVO<ProdVO> pagingVO = new PagingVO<>(5,3);
			pagingVO.setDetailSearch(detailSearch);
			pagingVO.setCurrentPage(currentPage);
			
			int totalRecord = prodService.readProdCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<ProdVO> prodList = prodService.readProdList(pagingVO);
			pagingVO.setDataList(prodList);
			
			model.addAttribute("pagingVO", pagingVO);
			return "order/prod/order_prodList";
		}
		
		// 0-1. 선택 상품 상세보기 
		@GetMapping("{prod_no}")
		public String prodView(
			@PathVariable(required = true) String prod_no, Model model
		) {
			ProdVO prod = prodService.readProd(prod_no);
			model.addAttribute("prod",prod);
//			wareSetting(model);
			return "/order/prod/order_prodModalView";
		}
	
	
	
	
	
}
