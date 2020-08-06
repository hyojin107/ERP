package ERP.controller.wareHouse.disuse;

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

import ERP.service.wareHouse.DisuseServiceImpl;
import ERP.service.wareHouse.IDisuseService;
import vo.PagingVO;
import vo.SearchVO;
import vo.product.PdReportVO;
import vo.product.PductListVO;
import vo.product.PductorderVO;

@Controller
@RequestMapping("ware/dis")
public class DisuseProdReadController {

	@Inject
	IDisuseService service;
	

	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PdReportVO> ajaxForList(
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentpage,
			SearchVO searchVo, Model model
			){
		
		list(currentpage, searchVo, model);
		return (PagingVO<PdReportVO>) model.asMap().get("pagingVO");
		
	}
	
	@GetMapping
	public String list(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, SearchVO searchVO,
			Model model) {
		
		
		
		PagingVO<PdReportVO> pagingVO = new PagingVO<>(5,10);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.pdReportCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PdReportVO> orderList = service.readPdReportList(pagingVO);
		System.out.println(orderList.toString());
		pagingVO.setDataList(orderList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		String goPage = "wh/disuse/disRequestListView";
		
		
		return goPage;
	
}
	
	
	@GetMapping("{what}")
	public String view(
			@PathVariable(name = "what")String what, Model model ) {
		
		
		
		PdReportVO pductlist = service.readPdReport(Integer.parseInt(what));
		model.addAttribute("pductlist",pductlist);
		
		
		
		return "/wh/disuse/disFormModalView";
	}
	
	@GetMapping("form/{what}")
	public String ReportInsert(@PathVariable(name = "what")String what, Model model ) {
		
		
		
		
		return "wh/disuse/disInsertForm";
	}
	
	
}
