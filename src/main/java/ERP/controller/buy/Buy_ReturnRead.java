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

import ERP.service.buy.IBuy_ReturnService;
import vo.PagingVO;
import vo.buy.Buy_OrderVO;
import vo.buy.Buy_ReturnVO;

@Controller
@RequestMapping("/buy/ret")
public class Buy_ReturnRead {
	
	@Inject
	IBuy_ReturnService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<Buy_ReturnVO> ajaxList(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_ReturnVO detailSearch, Model model) {
		list(currentPage, detailSearch, model);	//메서드 실행후엔 model안에 pagingVO가 들어있을 것임
		PagingVO<Buy_ReturnVO> pagingVO = (PagingVO<Buy_ReturnVO>) model.asMap().get("pagingVO");
		return pagingVO;
	}
	
	@GetMapping
	public String list(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			Buy_ReturnVO detailSearch, Model model) {
		
		PagingVO<Buy_ReturnVO> pagingVO = new PagingVO<>();
 		pagingVO.setDetailSearch(detailSearch);
 		
 		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readReturnCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<Buy_ReturnVO> orderList = service.readReturnList(pagingVO);
		pagingVO.setDataList(orderList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "buy/ret/buyReturnList";
	}
	
}
