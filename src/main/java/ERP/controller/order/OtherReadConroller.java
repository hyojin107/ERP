package ERP.controller.order;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import ERP.dao.order.IEstimateDAO;
import ERP.service.order.IEstimateService;
import vo.wareHouse.LprodVO;
import vo.wareHouse.ProdVO;

@RestController
@RequestMapping(value = "/order/estimate/prod", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class OtherReadConroller {
	
	@Inject
	IEstimateService estimateService;
	
	
	
	@GetMapping("lprod")
	public List<Map<String, String>> getAllprodLgu() {
		List<Map<String, String>> prodLguList = estimateService.readAllProdLgu();
		return prodLguList;
	}
	
	@GetMapping("prod")
	public List<ProdVO> getAllprod(@RequestParam(required = false) String lprod_no){
		List<ProdVO> prodList = estimateService.readAllProd(lprod_no);
		return prodList;
	}
	
	@GetMapping("{prod_no}")
	public ProdVO prodRead(@PathVariable(name = "prod_no" ,required = true) String prod_no, Model model) {

		ProdVO prodVO = estimateService.readProdList(prod_no);
		return prodVO;
	}
	

}
