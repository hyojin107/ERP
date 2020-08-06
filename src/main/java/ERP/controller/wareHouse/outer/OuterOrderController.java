package ERP.controller.wareHouse.outer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//@Controller
//@RequestMapping("outer/order")
public class OuterOrderController {
	// 7. 출하지시서 상세보기
//	@GetMapping("{board_no}")
	public String OutOrderViewGet() {
		return "wh/outer/outProdOuterReqModalView";
	}
	
	// 7-1. 출하지시서에서 생산의뢰서로 이동하기 , 생산의뢰서 작성하기 
//	@GetMapping("topduct")
	public String OutOrderToProductGet() {
		return "wh/outer/outProdProductReqForm";
	}
	
//	@PostMapping
	public String OutOrderToProductPost() {
		return "wh/outer/outProdProductReqListView"; // 출고요청서 목록보여주기
	}
		
	// 7-1. 출하지시서를 토대로 상품 출고하기
//	@PostMapping("{board_no}")
	public String OutOrderPductPost() {
		return "wh/outer/outProdProductReqListView"; // 출고요청서 목록보여주기
	}
}
