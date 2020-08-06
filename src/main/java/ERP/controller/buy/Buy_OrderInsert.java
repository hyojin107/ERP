package ERP.controller.buy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.buy.IBuy_OrderDAO;
import ERP.service.buy.IBuy_OrderService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_OrderVO;
import vo.buy.Buy_Order_MatVO;

@Controller
@RequestMapping("/buy/order")
public class Buy_OrderInsert {
	
	@Inject
	IBuy_OrderService service;
	
	@GetMapping("form")
	public String form(Model model) {
		//구매요청 원자재 목록
		List<Buy_Doc_MatVO> docMatList = service.readBuyDocMatList();
		model.addAttribute("docMatList", docMatList); 
		return "buy/order/buyOrderForm";
	}
	
	@PostMapping(value="docDel", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String del(String buy_no, String mat_no) {
		Buy_Doc_MatVO matVO = new Buy_Doc_MatVO();
		matVO.setBuy_no(Integer.parseInt(buy_no));
		matVO.setMat_no(mat_no);
		
		ServiceResult result = service.deleteDocMat(matVO);
		if(ServiceResult.OK.equals(result)) {
			return "요청 항목이 성공적으로 삭제되었습니다.";
		}else {
			return "삭제 실패. 잠시후 다시 시도해주세요.";
		}
	}
	
	@PostMapping
	public String insert(Buy_OrderVO vo, BindingResult errors, Model model) {
		List<Buy_Order_MatVO> matList = vo.getMatList();
		if(matList!=null && matList.size()>0) {
			List<Buy_Order_MatVO> matArray = new ArrayList<>();
			for(Buy_Order_MatVO mat : matList) {
				if(mat==null|| mat.getOrmat_qty() == null || mat.getOrmat_qty()==0) continue;
				matArray.add(mat);
			}
			vo.setMatList(matArray);
		}
		
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBuyOrder(vo);
			switch(result) {
			case FAIL:
				message = "잠시 후 다시 시도해주세요";
				goPage = "buy/order/buyOrderForm";
				break;
			default:
				System.out.println("등록 성공");
				goPage = "redirect:/buy/order";
			}
		}else {
			goPage = "buy/order/buyOrderForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
}
