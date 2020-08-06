package ERP.controller.wareHouse.enter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("enter/mat/buyorder")
public class EnterMatBuyOrderController {
	
	// 2. 원자재 구매요청서 작성하기 - get, post
	@GetMapping("insert/{mat_no}")
	public String EnMatBuyOrderGet() {
		return "buy/order/buyOrderForm"; // 효진 
	}
	
	@PostMapping
	public String EnMatBuyOrderPost() {
		return "wh/enter/enMatBuyListView"; // 구매요청서 목록으로 이동
	}	
	
	// 3. 원자재 구매요청서 목록 보여주기
	@GetMapping("buyrequestlist")
	public String EnMatBuyRequestGet() {
		return "wh/enter/enMatBuyListView"; // 구매요청서 목록으로 이동
	}
		
	// 4. 원자재 구매요청서 상세보기 -- board_no 쿼리스트링 넘겨주기
	@GetMapping("{board_no}")
	public String EnMatBuyReqeustReadGet() {
		return "wh/enter/enMatBuyModalView"; 
	}
	
}
