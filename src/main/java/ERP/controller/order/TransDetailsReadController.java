package ERP.controller.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.ITransDetalisService;
import vo.PagingVO;
import vo.order.ShipmentVO;
import vo.order.TransDetailsVO;

@Controller
@RequestMapping("/order/transDetails")
public class TransDetailsReadController {
	
	@Inject
	ITransDetalisService transDetailsService;
	
	@GetMapping(produces = "application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<TransDetailsVO> ajaxList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			TransDetailsVO detailSearch, Model model
	){
		System.out.println("325riueuge");
		list(currentPage, detailSearch, model);
		PagingVO<TransDetailsVO> pagingVO = (PagingVO<TransDetailsVO>) model.asMap().get("pagingVO");
		return pagingVO;
	}
	
	
	@GetMapping
	public String list(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			TransDetailsVO detailSearch, Model model
	) {
		
		PagingVO<TransDetailsVO> pagingVO = new PagingVO<>(7,5);
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = transDetailsService.readTransDCount(pagingVO);
		
		System.out.println("거래명세서 리스트 서비스까지 도착");
		
		List<TransDetailsVO> transDetailsList = transDetailsService.readTransDList(pagingVO);
		
		System.out.println("     transDetailsList  : "+ transDetailsList );
		
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setDataList(transDetailsList);
		
		//페이징 vo에 데이터가 다있으니까 보내주기!
		model.addAttribute("pagingVO", pagingVO);
				
		//논리적인 view name
		return "order/transDetails/transDetailsList";
	}
	
	@GetMapping("{tran_no}")
	public String view(
			@PathVariable(name = "tran_no", required = true) String tran_no, Model model	
	) {
		int tran_num = Integer.parseInt(tran_no);
		TransDetailsVO transDetailsList = transDetailsService.readTransD(tran_num);
		model.addAttribute("transDetails", transDetailsList);
		return "/order/transDetails/transDetailsView";
	}
}
