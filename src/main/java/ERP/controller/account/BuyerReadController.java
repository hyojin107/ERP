package ERP.controller.account;

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

import ERP.service.IBuyerService;
import vo.BuyerVO;
import vo.PagingVO;
import vo.SearchVO;

@Controller
@RequestMapping("/account/basic/buyer")
public class BuyerReadController {
	@Inject
	IBuyerService service;
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<BuyerVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		SearchVO searchVO, Model model
		){
		list(currentPage, searchVO, model);
		return (PagingVO<BuyerVO>) model.asMap().get("pagingVO");
	}
	@GetMapping
	public String list(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, Model model
			){
		PagingVO<BuyerVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readBuyerCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<BuyerVO> prodList = service.readBuyerList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "account/buyer/buyerList";
	}
	@GetMapping("{buyer_no}")
	public String view(@PathVariable(required = true)  String bo_no, Model model ) {
		BuyerVO buyer = service.readBuyer(bo_no);
		model.addAttribute("buyer", buyer);
		return "account/buyer/buyerView";
	}
}
