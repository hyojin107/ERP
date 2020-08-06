package ERP.controller.wareHouse.enter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("enter/pduct")
public class EnterPDuctController {
	
	// 6. 생산보고서 상세보기
	@GetMapping("{board_no}")
	public String EnPDuctViewGet() {
		return "wh/enter/enProductReportModalView";
	}
	
	// 7. 생산보고서를 토대로 상품 입고하기 - insert , post
	@PostMapping("{board_no}")
	public String EnterProdPost() {
		return  "wh/enter/enRequestListView"; // 5. 입고신청 목록 보기 (생산보고서, 반품의뢰서, 매입서 불러오기 )
	}
	
}
