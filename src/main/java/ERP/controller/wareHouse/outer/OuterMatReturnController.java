package ERP.controller.wareHouse.outer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("outer/matreturn")
public class OuterMatReturnController {
	// 4. 원자재 반품 의뢰서 목록 보여주기
	@GetMapping("list")
	public String OutMatReturnListViewGet() {
		return "wh/outer/outMatReturnListView";
	}
	
	// 4-1. 원자재 반품의뢰서 상세 보기
	@GetMapping("{board_no}")
	public String OutMatReturnViewGet() {
		return "wh/outer/outMatReturnModalView";
	}
	
	// 5. 원자재 반품 의뢰서 작성하기 , 작성하면서 원자재 출고 - get, post
	@GetMapping("insert")
	public String OutMatReturnRequestGet() {
		return "wh/outer/outMatReturnForm";
	}
	
	@PostMapping
	public String OutMatReturnRequestPost() {
		return "wh/outer/outMatReturnListView"; // 반품의뢰서 작성 후 리스트 보여주기 
	}
}
