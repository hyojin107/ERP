package ERP.dao.product;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.product.LWareHouseVO;
import vo.product.StuffVO;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;

/**
 * @author PC-12 李쎄퀬 愿�由� DAO
 *
 *
 */
@Repository
public interface IwareHouseDao {

	/**
	 * @return 紐⑤뱺 李쎄퀬 List�뱾�쓣 肉뚮┛�떎.
	 */
	public List<WareHouseVO> SelectWareHouseList(WareHouseVO searchVO);

	/**
	 * @param WareHouse_code
	 * @return
	 * �꽑�깮�븳 李쎄퀬�쓽 Sector 由ъ뒪�듃�뱾�쓣 媛��졇�삩�떎
	 */
	public List<StuffVO> SelectSectorList(Map<String,String> maplist);

	/**
	 * @param Sector_code
	 * @return
	 * �꽑�깮�븳 Sector�쓽 ���옣 臾쇳뭹�뱾�쓣 媛��졇�삩�떎
	 */
	public List<StuffVO> SelectSector(String Sectorvo);

	/**
	 * @param warehouseVO
	 * @return
	 * 李쎄퀬瑜� ���옣�븳�떎. warehouse�뿉�뒗 Sector�쓽 由ъ뒪�듃�� Sector�븞�뿉�뒗 Prod, Mater SectorVO �뱾�씠 媛곴컖 媛�吏�怨� �엳�떎.
	 * Insert�븯硫� 理쒖냼 WareHouse, Sector, 援щ텇Sector 3�뀒�씠釉붿뿉 Insert媛� �맂�떎.
	 * 
	 */
	public int InsertWareHouse(WareHouseVO warehouseVO);

	/**
	 * @param warehouseVO
	 * @return
	 * Sector瑜� �닔�젙�븯嫄곕굹, Sector瑜� �궘�젣, Sector瑜� 異붽� �븷 �닔 �엲�떎.
	 */
	public int UpdateWareHouse(WareHouseVO warehouseVO);

	/**
	 * @param warehouse_code
	 * @return
	 * �빐�떦 WareHouse �깮�꽦�븯�뒗 湲곕뒫, �븘吏� 留뚮뱾吏��뿉 ���븳 �뿬遺� �솗�씤�븞�맖.
	 */
	public int RemoveWareHouse(String warehouse_code); 
	
	/**
	 * @return
	 * �빐�떦 Sector�뿉 ���븳 �뾽�뜲�씠�듃 湲곕뒫 
	 * �궗�슜�맆吏��뿉 ���븳 �뿬遺� �븘吏� �솗�젙�븘�떂
	 */
	public int UpdateWareSector();
	
	public List<WareHouseVO> WareHouseList(String LwareHouse_no);
	
	public String GetJsonFilename(String store_no);
	
	public List<LWareHouseVO> LWareHouseList();
	
	public int InsertSector(List<WareSectorVO> sectorlist);
	
}
