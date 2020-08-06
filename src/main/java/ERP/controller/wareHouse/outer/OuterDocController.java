package ERP.controller.wareHouse.outer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IOuterDocumentService;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;
import vo.wareHouse.OuterDocumentVO;
import vo.wareHouse.OuterStoreVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("outer/doc")
public class OuterDocController {
	
	private static Logger logger = LoggerFactory.getLogger(OuterDocController.class);
	
	@Inject
	IOuterDocumentService docService;
	
	@Inject
	IWareOthersDAO othersDao;

	// 출하지시서 목록 띄우기 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<OuterDocumentVO> ajaxForList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		OuterDocumentVO detailSearch, Model model
	)throws IOException{
		DocList(currentPage,detailSearch, model);
		return (PagingVO<OuterDocumentVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("list")
	public String DocList(
		@RequestParam(name="page",required = false, defaultValue = "1") int currentPage,
		OuterDocumentVO detailSearch, Model model) throws IOException{
		PagingVO<OuterDocumentVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = docService.readOuterDocCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OuterDocumentVO> outDocList = docService.readOuterDocList(pagingVO);
		pagingVO.setDataList(outDocList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "wh/outer/outRequestListView";
	}

	// 7. 출하지시서 상세보기
	@GetMapping("order/{board_no}")
	public String OutOrderViewGet(
		@PathVariable(required = true) int board_no, Model model
	) {
		DeliveryOrderVO delOrVO  = docService.readDeliveryOrder(board_no);
		model.addAttribute("delOrVO",delOrVO);
		System.out.println("        리스트확인  \n"+delOrVO.getOrder().get(0).getOrderList());
		
		List<OrderVO> delOrder = delOrVO.getOrder(); // ordervo를 꺼내고 
		List<String> prod_no_list = new ArrayList<>();
		List<List<OuterStoreVO>> storeList = new ArrayList<>();
		
		for(int i = 0; i<delOrder.size(); i++) {
			List<OrderListVO> orderList = delOrder.get(i).getOrderList(); // orderlist 주문상품 목록을 꺼냄 
			for(int j=0; j<orderList.size(); j++) {
				List<ProdVO> prodList = orderList.get(j).getProdList(); // 상품 
				for(int k=0; k<prodList.size(); k++) {
					String prod_no = prodList.get(k).getProd_no();
					prod_no_list.add(prod_no);
					storeList.add(othersDao.outerPStroeList(prod_no));
					model.addAttribute("storeList",storeList);
				}
			}
		}
		return "/wh/outer/outProdOuterReqModalView";
	}
	
	// 7-1. 출하지시서를 토대로 상품 출고하기
	@PostMapping(produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String OutOrderPductPost(
		@RequestBody DeliveryOrderVO deliveryOrVO
		, HttpServletResponse resp
	) throws IOException{
		// jsp에서 상품 출하 버튼을 누르면 넘어온다. 
		// or_delivery에서 deliv_prog 상태코드를 수정한다. 
		// prod_out 테이블 insert 
		// prod_sector 테이블 insert 
		// 모든 상태가 잘 진행되면 jsp 에서 alert창이 나오고 
		// 아니라면 alert창이 나오지 않는다.
		
		System.out.println("deliveryVO 확인 ");
		System.out.println("       "+deliveryOrVO);
		String resultStr =null;
		try {
			ServiceResult result = docService.updateOrDelivery(deliveryOrVO);
			if(ServiceResult.OK.equals(result)) {
				resultStr = "ok";
			}else {
				resultStr = "fail";
			}
		} catch (DataNotFoundException e) {
			resultStr = "fail";
		}
		return resultStr;
//		return "wh/outer/outProdProductReqListView"; // 출고요청서 목록보여주기
	}
}
