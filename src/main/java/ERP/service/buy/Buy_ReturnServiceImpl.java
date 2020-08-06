package ERP.service.buy;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.buy.IBuy_ReturnDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_ItemVO;
import vo.buy.Buy_OrderVO;
import vo.buy.Buy_Order_MatVO;
import vo.buy.Buy_Order_UnionVO;
import vo.buy.Buy_Ret_ItemVO;
import vo.buy.Buy_Ret_MatVO;
import vo.buy.Buy_ReturnVO;
import vo.buy.Buy_Return_UnionVO;

@Service
public class Buy_ReturnServiceImpl implements IBuy_ReturnService {
	
	@Inject
	IBuy_ReturnDAO dao;
	
	@Override
	public ServiceResult createReturn(Buy_ReturnVO retVO) {
		//반품원자재 목록 pk만들기
		if(retVO.getMatList() != null) {
			int matPK = dao.selectRetMatPK();
			int matSize = retVO.getMatList().size();
			if(matSize != 0) {
				for(Buy_Ret_MatVO mat : retVO.getMatList()) {
					mat.setRetmat_no(matPK++);
				}
			}
		}
		//반품일반 목록 pk만들기
		if(retVO.getItemList() != null) {
			int itemPK = dao.selectRetItemPK();
			int itemSize = retVO.getItemList().size();
			if(itemSize != 0) {
				for(Buy_Ret_ItemVO item : retVO.getItemList()) {
					item.setRetitem_no(itemPK++);
				}
			}
		}
		
		int result = dao.insertReturn(retVO);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
		
	}

	@Override
	public int readReturnCount(PagingVO<Buy_ReturnVO> pagingVO) {
		return dao.selectReturnCount(pagingVO);
	}

	@Override
	public List<Buy_ReturnVO> readReturnList(PagingVO<Buy_ReturnVO> pagingVO) {
		List<Buy_ReturnVO> retList = dao.selectReturnList(pagingVO);
		for(Buy_ReturnVO ret : retList) {
			ret.setMatCnt(ret.getUnionList().size());
			List<Buy_Ret_MatVO> mlist = new ArrayList<>();
			List<Buy_Ret_ItemVO> ilist = new ArrayList<>();
			for(int i=0; i<ret.getUnionList().size(); i++) {
				Buy_Return_UnionVO union = ret.getUnionList().get(i);
				if(union.getMat_no().startsWith("M")) {	//원자재
					Buy_Ret_MatVO  mat= new Buy_Ret_MatVO();
					mat.setOrmat_code(union.getOrmat_code());
					mat.setMat_no(union.getMat_no());
					mat.setRetmat_qty(union.getQty());
					mat.setCost(union.getCost());
					mat.setMat_name(union.getMat_name());
					mat.setLprod_name(union.getLprod_name());
					mat.setMat_stand_size(union.getStand_size());
					mlist.add(mat);
				} else {	//일반발주
					Buy_Ret_ItemVO item = new Buy_Ret_ItemVO();
					item.setItem_no(union.getMat_no());
					item.setItem_name(union.getMat_name());
					item.setRetitem_qty(union.getQty());
					item.setItem_cost(union.getCost());
					item.setItem_lprod(union.getLprod_name());
					item.setItem_stand_size(union.getStand_size());
					ilist.add(item);
				}
			}
			ret.setMatList(mlist);
			ret.setItemList(ilist);
//			or.getUnionList().clear();
		}
		return retList;
	}

	@Override
	public ServiceResult deleteReturn(Buy_ReturnVO retVO) {
		int result = dao.deleteReturn(retVO);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

}










