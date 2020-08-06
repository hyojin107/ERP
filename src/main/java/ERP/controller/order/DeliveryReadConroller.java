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

import ERP.service.order.IDeliveryOrderService;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;

@Controller
@RequestMapping("/order/delivery")
public class DeliveryReadConroller {
	
	@Inject
	IDeliveryOrderService deliveryService;
	
	@GetMapping(produces = "application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<DeliveryOrderVO> ajaxList(
		@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
		DeliveryOrderVO detailSearch, Model model
	){
		list(currentPage, detailSearch, model);
		PagingVO<DeliveryOrderVO> pagingVO = (PagingVO<DeliveryOrderVO>) model.asMap().get("pagingVO");
		return pagingVO;
	}
	
	@GetMapping
	public String list(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			DeliveryOrderVO detailSearch, Model model
	) {
		PagingVO<DeliveryOrderVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = deliveryService.readDeliveryCount(pagingVO);
		
		System.err.println("딜리버리리스트 도착?");
		
		List<DeliveryOrderVO> deliveryList = deliveryService.readDeliveryList(pagingVO);
		
		System.err.println(deliveryList +"시작");
		
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setDataList(deliveryList);
		
		System.err.println("-------- 끝");
		
		//페이징 vo에 데이터가 다있으니까 보내주기!
		model.addAttribute("pagingVO", pagingVO);
		
		//논리적인 view name
		return "order/delivery/deliveryList";
	}
	
	@GetMapping("{deliv_no}")
	public String view(
			@PathVariable(name = "deliv_no", required = true) String deliv_no, Model model
	) {
		System.err.println("delivery컨트롤러" + deliv_no);
		
		//스트링으로 왔으니까 숫자로 형변환
		int deliv_num = Integer.parseInt(deliv_no);
//		DeliveryOrderVO deliveryList = deliveryService.readDelivery(deliv_no);
		DeliveryOrderVO deliveryList = deliveryService.readDelivery(deliv_num);
		model.addAttribute("delivery", deliveryList);
		
		return "/order/delivery/deliveryView";
	}
}
