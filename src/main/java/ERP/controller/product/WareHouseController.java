package ERP.controller.product;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import ERP.service.product.wareHouseServiceImpl;
import vo.SearchVO;
import vo.product.LWareHouseVO;
import vo.product.StuffVO;
import vo.product.WareHouseVO;


@Controller
@RequestMapping("warehouse")
public class WareHouseController {

	@Value("#{appInfo.WareJsonPath}") 
	String WareJsonPath;
	String folderPath;
	
	@Inject
	WebApplicationContext container;
	ServletContext application;
	@PostConstruct 
	public void init() {
		application = container.getServletContext();
		 folderPath = application.getRealPath(WareJsonPath);
		File saveFolder = new File(folderPath); // folder�� ��ġ�� ���� ����
		if(!saveFolder.exists()) saveFolder.mkdirs(); // ���� ���ٸ� ����
	}
	
	
	@Inject
	wareHouseServiceImpl service;
	
	@GetMapping
	public String view() {
		return "product/WareView";
	}
	
	@PostMapping("callware")
	@ResponseBody
	public List<WareHouseVO> callWareHouse( WareHouseVO searchVO, String searchType){
		
		SearchVO search = new SearchVO();
		search.setSearchType(searchType);
		searchVO.setSearchvo(search);
		
		
		return service.ReadAllWareHouseList(searchVO);
	
	}
	

	@GetMapping("shape")
	public String getHouse() {
		return "/product/WareHouse";
	}
	
	
	@GetMapping( value = "lwarelist" ,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<LWareHouseVO> getlHouseList() {
		return service.ReadLWareHouseList();
	}
	@GetMapping( value = "warelist" ,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody 
	public List<WareHouseVO> getHouseList(String LwareHouse_no) {
		return service.ReadWareHouseList(LwareHouse_no);
	}
	
	
	
	
	@GetMapping("json")
	@ResponseBody public String getJsonFile(String store_no) {
		
		String filepath = "fail";
		String filename = service.GetWareHouseJsonName(store_no);
		if( StringUtils.isNotBlank(filename)) {
			File checkfile = new File(folderPath + "/" + filename + ".json");
			
			if(checkfile.exists()) {
				filepath =  filename + ".json";
			}
		}
		return filepath;	
	}
	
	@PostMapping("callsector")
	@ResponseBody
	public List<StuffVO> callSector(String sector_no ){
		
		return service.ReadSector(sector_no);
	
	}
	
	@GetMapping("sectorlist")
	public String sectorList(String store_no, String stuff_name, Model model) {
		
		Map<String, String> maplist = new HashMap<>();
		maplist.put("store_no",store_no);
		maplist.put("stuff_name",stuff_name);
		
		List<StuffVO> stufflist = service.ReadSectorList(maplist);
		model.addAttribute("stufflist",stufflist);
		
		return "/product/WareSectorList";
	}
	
	
}
