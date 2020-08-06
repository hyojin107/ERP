package ERP.controller.wareHouse.outer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//@Controller
//@RequestMapping("outer/pduct")
public class OuterPDuctController {
	
	// 8. 생산보고서 상세보기
//	@GetMapping("{board_no}")
	public String OutPDuctViewGet() {
		return "wh/outer/outProductReportModalView";
	}
	
	// 8-1. 생산보고서를 토대로 추가 사용된 원자재 출고 하기
//	@PostMapping("{board_no}")
	public String OutPDuctMatPost() {
		return "wh/outer/outProdProductReqListView"; // 출고요청서 목록보여주기
	}
}
