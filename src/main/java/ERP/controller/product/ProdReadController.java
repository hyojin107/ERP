package ERP.controller.product;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.impl.Log4JLogger;
import org.apache.logging.slf4j.Log4jLogger;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.product.IprodOrderService;
import enums.ServiceResult;
import vo.PagingVO;
import vo.SearchVO;
import vo.product.PductListVO;
import vo.product.PductorderVO;

@Controller
@RequestMapping("/product")
public class ProdReadController {

	@Inject
	IprodOrderService service;
	
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PductorderVO> ajaxForList(
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentpage,
			SearchVO searchVo, Model model
			){
		
		list(currentpage, searchVo, model);
		return (PagingVO<PductorderVO>) model.asMap().get("pagingVO");
		
	}
	
	@GetMapping
	public String list(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, SearchVO searchVO,
			Model model) {
		
		
		
		PagingVO<PductorderVO> pagingVO = new PagingVO<>(5,10);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.ReadProdorderCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PductorderVO> orderList = service.ReadProdorderList(pagingVO);
		System.out.println(orderList.toString());
		pagingVO.setDataList(orderList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		String goPage = "product/productList";
		
		
		return goPage;
	}
	
	@GetMapping("{what}")
	public String view(
			@PathVariable(name = "what")String what, Model model ) {
		
		
		PductListVO pductlist = service.ReadProdorder(what);
		model.addAttribute("pductlist",pductlist);
		
		
		
		return "/product/productView";
	}
	
	
  @PostMapping("confirm")	
  @ResponseBody public String ConfirmUpdate( String porder_no) {
	  
	  System.out.println(porder_no);
	  int porder_num = Integer.parseInt(porder_no);
	 ServiceResult result = service.ConfirmProdorder(porder_num);
	 System.out.println(result.name());
	  return result.name();
  }
	
}
