package ERP.controller.wareHouse;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ERP.dao.wareHouse.IWareOthersDAO;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;
import vo.wareHouse.LprodVO;
import vo.wareHouse.OuterStoreVO;

@RestController
@RequestMapping(value = "/ware/lprod", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class WareOthersReadController {

	@Inject
	IWareOthersDAO otherDAO;
	
	/**
	 * lprod list
	 * @return
	 */
	@GetMapping(value = "getLprodList")
	public List<LprodVO> getLprodList(){
		List<LprodVO> lprodList = otherDAO.selectLprodList();
		return lprodList;
	}
	
	/**
	 * store list
	 * @return
	 */
	@GetMapping(value = "getStoreList")
	public List<WareHouseVO> getStoreList(){
		List<WareHouseVO> storeList = otherDAO.selectStoreList();
		return storeList;
	}
	
	
	/**
	 * sector list
	 * @return
	 */
	@GetMapping(value = "getSectorList")
	public List<WareSectorVO> getSectorList(
		@RequestParam(required = false) String store_no
	)throws IOException{
		List<WareSectorVO> sectorList = otherDAO.selectSectorList(store_no);
		return sectorList;
	}
	
	/**
	 * 원자재 출고 : 창고 목록 불러오기 
	 * @param mat_no
	 * @return
	 * @throws IOException
	 */
//	@GetMapping(value = "outStoreList")
//	public List<OuterStoreVO> outStoreList(
//		@RequestParam(required = false) String mat_no
//	)throws IOException{
//		List<OuterStoreVO> storeList = otherDAO.outerStoreList(mat_no);
//		return storeList;
//	}
	
	/**
	 * 원자재 출고 : 창고구역 불러오기 
	 * @param outStroeVO
	 * @return
	 * @throws IOException
	 */
	@GetMapping(value = "outSectorList")
	public List<OuterStoreVO> outSectorList(OuterStoreVO outStroeVO)throws IOException{
		List<OuterStoreVO> sectorList = otherDAO.outerSectorList(outStroeVO);
		return sectorList;
	}
	
	/**
	 * 상품출고 : 창고구역 불러오기 
	 * @param outStoreVO
	 * @return
	 * @throws IOException
	 */
	@GetMapping(value = "outPSectorList")
	public List<OuterStoreVO> outPSectorList(OuterStoreVO outStoreVO) throws IOException{
		List<OuterStoreVO> sectorList = otherDAO.outerPSectorList(outStoreVO);
		return sectorList;
	}
	
	
}
