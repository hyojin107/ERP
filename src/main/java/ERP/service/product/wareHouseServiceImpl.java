package ERP.service.product;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.product.IwareHouseDao;
import enums.ServiceResult;
import vo.product.LWareHouseVO;
import vo.product.StuffVO;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;

@Service
public class wareHouseServiceImpl implements IwareHouseService {

	@Inject
	IwareHouseDao dao;
	
	
	@Override
	public List<WareHouseVO> ReadAllWareHouseList(WareHouseVO searchVO) {
		// TODO Auto-generated method stub
		return dao.SelectWareHouseList(searchVO);
	}

	@Override
	public List<StuffVO> ReadSectorList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.SelectSectorList(map);
	}

	@Override
	public List<StuffVO> ReadSector(String Sectorvo) {
		return dao.SelectSector(Sectorvo);
	}

	@Override
	public ServiceResult CreateWareHouse(WareHouseVO warehouseVO) {
		
		int rowcnt = dao.InsertWareHouse(warehouseVO);
		ServiceResult result = ServiceResult.OK;
		if(rowcnt<= 0) result = ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult UpdateWareHouse(WareHouseVO warehouseVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult RemoveWareHouse(String warehouse_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult UpdateWareSector() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<WareHouseVO> ReadWareHouseList(String LwareHouse_no) {
		
		return dao.WareHouseList(LwareHouse_no);
	}

	@Override
	public String GetWareHouseJsonName(String Store_no) {
		// TODO Auto-generated method stub
		return dao.GetJsonFilename(Store_no);
	}

	@Override
	public List<LWareHouseVO> ReadLWareHouseList() {
		// TODO Auto-generated method stub
		return dao.LWareHouseList();
	}

	@Override
	public ServiceResult CreateSector(List<WareSectorVO> sectorlist) {
		
		int rowcnt = dao.InsertSector(sectorlist);
		ServiceResult result = ServiceResult.OK;
		if(rowcnt<= 0) result = ServiceResult.FAIL;
		return result;
	}

}
