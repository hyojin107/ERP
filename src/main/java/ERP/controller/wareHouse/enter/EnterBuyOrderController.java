package ERP.controller.wareHouse.enter;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;

import ERP.service.wareHouse.IEnterBuyDocService;
import vo.product.StuffVO;
import vo.wareHouse.EnterStuffVO;

@Controller
@RequestMapping("enter/buyorder")
public class EnterBuyOrderController {
	
	@Inject
	IEnterBuyDocService service;
	
	// 10. 매입서 상세보기
	@GetMapping("{code}/{lstore_no}/insert")
	public String InsertOrder(
			@PathVariable(name = "code")String code,
			@PathVariable(name = "lstore_no")String lstore_no,
			Model model
			) {
		
		model.addAttribute("code",code);
		model.addAttribute("lstore_no",lstore_no);
		
		return "/wh/enter/enStuffInsert";
	}
	
	// 11. 매입서를 토대로 원자재 입고하기 - insert , post
	@GetMapping("list")
	public String EnterMatPost() {
		
		
	
		return  "wh/enter/enRequestListView"; // 5. 입고신청 목록 보기 (생산보고서, 반품의뢰서, 매입서 불러오기 )
	}
	
	@ResponseBody
	@GetMapping("json")
	public List<EnterStuffVO> getEnterList(String code) {
		
		List<EnterStuffVO> list =  service.readBuyDocList(code);
		
		
		return list;
	}
	
}
