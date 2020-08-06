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
import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_OrderVO;

@Controller
@RequestMapping("/buy/order")
public class Buy_OrderRead {
	
	@Inject
	IBuy_OrderService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<Buy_OrderVO> ajaxList(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_OrderVO detailSearch, Model model) {
		list(currentPage, detailSearch, model);	//메서드 실행후엔 model안에 pagingVO가 들어있을 것임
		PagingVO<Buy_OrderVO> pagingVO = (PagingVO<Buy_OrderVO>) model.asMap().get("pagingVO");
		return pagingVO;
	}
	
	@GetMapping
	public String list(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_OrderVO detailSearch, Model model) {
		
		PagingVO<Buy_OrderVO> pagingVO = new PagingVO<>();
 		pagingVO.setDetailSearch(detailSearch);
 		
 		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readBuyOrderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<Buy_OrderVO> orderList = service.readBuyOrderList(pagingVO);
		pagingVO.setDataList(orderList);
		model.addAttribute("pagingVO", pagingVO);
		return "buy/order/buyOrderList";
	}
	
}





