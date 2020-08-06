package ERP.service.product;

import java.util.List;
import java.util.Map;

import enums.ServiceResult;
import vo.product.LWareHouseVO;
import vo.product.StuffVO;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;

public interface IwareHouseService {

	public List<WareHouseVO> ReadAllWareHouseList(WareHouseVO searchVO);
	
	public List<StuffVO> ReadSectorList(Map<String,String> maplist);
	
	public List<StuffVO> ReadSector(String Sectorvo);
	
	public ServiceResult CreateWareHouse(WareHouseVO warehouseVO);
	
	public ServiceResult UpdateWareHouse(WareHouseVO warehouseVO);
	/**
	 * @param warehouse_code
	 * @return
	 * �빐�떦 WareHouse �깮�꽦�븯�뒗 湲곕뒫, �븘吏� 留뚮뱾吏��뿉 ���븳 �뿬遺� �솗�씤�븞�맖.
	 */
	public ServiceResult RemoveWareHouse(String warehouse_code); 
	
	/**
	 * @return
	 * �빐�떦 Sector�뿉 ���븳 �뾽�뜲�씠�듃 湲곕뒫 
	 * �궗�슜�맆吏��뿉 ���븳 �뿬遺� �븘吏� �솗�젙�븘�떂
	 */
	public ServiceResult UpdateWareSector();
	
	public List<WareHouseVO> ReadWareHouseList(String LwareHouse_no);
	
	public String GetWareHouseJsonName(String Store_no);
	
	public List<LWareHouseVO> ReadLWareHouseList();
	
	public ServiceResult CreateSector(List<WareSectorVO> sectorlist);
	
}
