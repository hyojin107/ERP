package ERP.service.buy;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.buy.IBuy_PurchaseDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_ItemVO;
import vo.buy.Buy_Order_MatVO;
import vo.buy.Buy_Order_UnionVO;
import vo.buy.Buy_PurchaseVO;

@Service
public class Buy_PurchaseServiceImpl implements IBuy_PurchaseService {
	
	@Inject
	IBuy_PurchaseDAO dao;
	
	@Override
	public ServiceResult createPurchase(Buy_PurchaseVO vo) {
		//매입서pk 는 발주서pk와 동일
		int result = dao.insertPurchase(vo);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public int readPurchaseCount(PagingVO<Buy_PurchaseVO> pagingVO) {
		return dao.selectPurchaseCount(pagingVO);
	}

	@Override
	public List<Buy_PurchaseVO> readPurchaseList(PagingVO<Buy_PurchaseVO> pagingVO) {
		List<Buy_PurchaseVO> purList = dao.selectPurchaseList(pagingVO);
		for(Buy_PurchaseVO pur : purList) {
			pur.setMatCnt(pur.getUnionList().size());
			List<Buy_Order_MatVO> mlist = new ArrayList<Buy_Order_MatVO>();
			List<Buy_ItemVO> ilist = new ArrayList<>();
			for(int i=0; i<pur.getUnionList().size(); i++) {
				Buy_Order_UnionVO union = pur.getUnionList().get(i);
				if(union.getMat_no().startsWith("M")) {	//원자재
					Buy_Order_MatVO  mat= new Buy_Order_MatVO();
					mat.setOrmat_code(union.getOrmat_code());
					mat.setMat_no(union.getMat_no());
					mat.setBuy_no(union.getBuy_no());
					mat.setOr_code(pur.getOr_code());
					mat.setOrmat_qty(union.getQty());
					mat.setCost(union.getCost());
					mat.setMat_name(union.getMat_name());
					mat.setLprod_name(union.getLprod());
					mat.setMat_stand_size(union.getStand_size());
					mlist.add(mat);
				} else {	//일반발주
					Buy_ItemVO item = new Buy_ItemVO();
					item.setItem_no(union.getMat_no());
					item.setOr_code(pur.getOr_code());
					item.setItem_name(union.getMat_name());
					item.setItem_qty(union.getQty());
					item.setItem_cost(union.getCost());
					item.setItem_lprod(union.getLprod());
					item.setItem_stand_size(union.getStand_size());
					ilist.add(item);
				}
			}
			pur.setMatList(mlist);
			pur.setItemList(ilist);
		}
		
		return purList;
	}

	@Override
	public ServiceResult deletePurchase(Buy_PurchaseVO purVO) {
		int result = dao.deletePurchase(purVO);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}
	
	
}



















