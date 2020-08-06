package ERP.controller.account;

import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.account.IStatisticsService;
import vo.account.D3VO;
import vo.account.StatisticsVO;

@Controller
@RequestMapping("/account/pm")
public class MonthlyReadController {
	@Inject
	IStatisticsService service;
	
	@ModelAttribute("year")
	public Integer yaer(){
		return service.year();
	}
	
	@GetMapping(value = "monthly", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<StatisticsVO> ajaxForlist(
		StatisticsVO vo, Model model
		){
		if(vo.getStandard()==null)
			vo.setStandard(Calendar.getInstance().getWeekYear());
		list(vo, model);
		return (List<StatisticsVO>) model.asMap().get("list");
	}
	@GetMapping("monthly")
	public String list(
			StatisticsVO vo, Model model
			){
		if(vo.getStandard()==null)
			vo.setStandard(Calendar.getInstance().getWeekYear());
			List<StatisticsVO> list = service.readMonth(vo);
			model.addAttribute("list", list);
			model.addAttribute("currentPage", "/account/pm/monthly");
		return "account/statistics/monthly";
	}
	
	@GetMapping(value = "product/{year}", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxForproductlist(
		@PathVariable Integer year, StatisticsVO vo, Model model
		){
		productlist(vo, model);
		return (String) model.asMap().get("list");
	}
	@GetMapping("productly")
	public String productlist(
			StatisticsVO vo, Model model
			){
		if(vo.getStandard()==null)
			vo.setStandard(Calendar.getInstance().getWeekYear());
		String list = service.readProduct(vo);
		
		model.addAttribute("list", list);
		return "account/statistics/productly";
	}
//	@GetMapping("{bo_no}")
//	public String view(@PathVariable(required = true)  int bo_no, Model model ) {
//		BoardVO board = service.readBoard(bo_no);
//		model.addAttribute("board", board);
//		return "board/boardView";
//	}
}
