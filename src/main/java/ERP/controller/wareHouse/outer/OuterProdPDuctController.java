package ERP.controller.wareHouse.outer;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IOuterPDuctService;
import ERP.service.wareHouse.IProdService;
import enums.ServiceResult;
import vo.PagingVO;
import vo.wareHouse.BOMVO;
import vo.wareHouse.PDuct_OR_VO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("/outer/prod/pduct")
public class OuterProdPDuctController {

	private static Logger logger = LoggerFactory.getLogger(OuterProdController.class); 
	
	@Inject
	IOuterPDuctService pductService;
	
	@Inject
	IProdService prodService;
	
	@Inject
	IWareOthersDAO othersDao;
	
	
	// 3. 생산의뢰서 목록 보여주기
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PDuct_OR_VO> ajaxForList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		PDuct_OR_VO detailSearch, Model model
	)throws IOException{
		OutProdProductListView(currentPage, detailSearch, model);
		return (PagingVO<PDuct_OR_VO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("list")
	public String OutProdProductListView(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		PDuct_OR_VO detailSearch, Model model
	)throws IOException {
		PagingVO<PDuct_OR_VO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = pductService.readPDuctORCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<PDuct_OR_VO> pductList = pductService.readPDuctORList(pagingVO);
		pagingVO.setDataList(pductList);
		
		model.addAttribute("pagingVO", pagingVO);		
		return "wh/outer/outProdProductReqListView";
	}
	
	// 4. 생산의뢰서 상세보기
	@GetMapping("{porder_no}")
	public String OutProdProductView(
		@PathVariable(required = true) int porder_no , Model model
	) {
		PDuct_OR_VO pductOrVO = pductService.readPDuctOR(porder_no);
		model.addAttribute("pductOrVO",pductOrVO);
		return "/wh/outer/outProdProductReqModalView";
	}
	
	// 2. 상품 생산의뢰서 작성하기 - get, post
	@GetMapping("insert/{prod_no}")
	public String OutProdProductRequestGet(
	 @PathVariable(name = "prod_no") String prod_no,Model model
	) {
		// prod 정보를 불러온다. 
		ProdVO prodVO = prodService.readProd(prod_no);
		model.addAttribute("prodVO", prodVO);
		List<BOMVO> bomlist = prodVO.getBomlist();
		if(bomlist!=null && bomlist.get(0).getMat_no()!=null) {
			for(BOMVO bom : bomlist) {
				// bom에 있는 원자재의 창고 정보 jsp에 넘겨주기 
				String mat_no = bom.getMat_no();
				model.addAttribute("storeList", othersDao.outerStoreList(mat_no));
			}
		}
		
		return "wh/outer/outProdProductReqForm";
	}
	
	@PostMapping
	public String OutProdProductRequestPost(
		@ModelAttribute("porderVO") PDuct_OR_VO porderVO,
		Model model,BindingResult errors, RedirectAttributes redirectattributes
	) throws IOException, ServletException  {
		System.out.println("porderVO 확인 : ");
		System.out.println(porderVO);
		
		String msg = null;
		String url = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = pductService.insertPDuctOR(porderVO);
			switch(result) {
			case FAIL:
				msg = "조금 뒤에 다시 시도하세요";
				url = "outer/outProdProductReqForm";
				break;
			default :
				url = "redirect:/outer/prod/pduct/list";
				break;
			}
		}else {
			url = "outer/outProdProductReqForm";
		}
		
		model.addAttribute("msg",msg);
		return url; // 작성완료 후 리스트로 돌아가기 
		
	}
}
