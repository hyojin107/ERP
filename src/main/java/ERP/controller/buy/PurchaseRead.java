package ERP.controller.buy;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.buy.IBuy_OrderService;
import ERP.service.buy.IBuy_PurchaseService;
import vo.PagingVO;
import vo.buy.Buy_OrderVO;
import vo.buy.Buy_PurchaseVO;

@Controller
@RequestMapping("/buy/purchase")
public class PurchaseRead {
	
	@Inject
	IBuy_PurchaseService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<Buy_PurchaseVO> ajaxList(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_PurchaseVO detailSearch, Model model) {
		list(currentPage, detailSearch, model);	//메서드 실행후엔 model안에 pagingVO가 들어있을 것임
		PagingVO<Buy_PurchaseVO> pagingVO = (PagingVO<Buy_PurchaseVO>) model.asMap().get("pagingVO");
		return pagingVO;
	}
	
	@GetMapping
	public String list(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_PurchaseVO detailSearch, Model model) {
		
		PagingVO<Buy_PurchaseVO> pagingVO = new PagingVO<>();
 		pagingVO.setDetailSearch(detailSearch);
 		
 		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readPurchaseCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<Buy_PurchaseVO> purList = service.readPurchaseList(pagingVO);
		pagingVO.setDataList(purList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "buy/purchase/purchaseList";
	}
	
}











