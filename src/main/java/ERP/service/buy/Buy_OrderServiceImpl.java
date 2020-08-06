package ERP.service.buy;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ERP.dao.buy.IBuy_OrderDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_ItemVO;
import vo.buy.Buy_OrderVO;
import vo.buy.Buy_Order_MatVO;
import vo.buy.Buy_Order_UnionVO;

@Service
public class Buy_OrderServiceImpl implements IBuy_OrderService{
	
	@Inject
	IBuy_OrderDAO dao;
	
	@Transactional
	@Override
	public ServiceResult createBuyOrder(Buy_OrderVO vo) {
		//발주서원자재목록 pk만들기
		if(vo.getMatList() != null) {
			int matPK = dao.selectBuyOrderMatPK();
			int matSize = vo.getMatList().size();
			if(matSize != 0) {
				for(Buy_Order_MatVO mat : vo.getMatList()) {
					mat.setOrmat_code(matPK++);
					mat.setOr_code(vo.getOr_code());
				}
			}
		}
		//일반물품발주 pk만들기
		if(vo.getItemList() != null) {
			int itemPK = dao.selectBuyOrderItemPK();
			int itemSize = vo.getItemList().size();
			if(itemSize != 0) {
				for(Buy_ItemVO item : vo.getItemList()) {
					item.setItem_no("I" + String.format("%04d", itemPK++));	//I0001
				}
			}
		}
		
		int cnt = dao.insertBuyOrder(vo);	//BUY_OR_MAT 리스트 등록
		
		//insert작업
		if(cnt>0 && vo.getMatList() != null) {
			dao.insertBuyOrderMatList(vo);
		}
		if(cnt>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public List<Buy_OrderVO> readBuyOrderList(PagingVO<Buy_OrderVO> pagingVO) {
		List<Buy_OrderVO> orList = dao.selectBuyOrderList(pagingVO);
		for(Buy_OrderVO or : orList) {
			or.setMatCnt(or.getUnionList().size());
			List<Buy_Order_MatVO> mlist = new ArrayList<Buy_Order_MatVO>();
			List<Buy_ItemVO> ilist = new ArrayList<>();
			for(int i=0; i<or.getUnionList().size(); i++) {
				Buy_Order_UnionVO union = or.getUnionList().get(i);
				if(union.getMat_no().startsWith("M")) {	//원자재
					Buy_Order_MatVO  mat= new Buy_Order_MatVO();
					mat.setOrmat_code(union.getOrmat_code());
					mat.setMat_no(union.getMat_no());
					mat.setBuy_no(union.getBuy_no());
					mat.setOr_code(or.getOr_code());
					mat.setOrmat_qty(union.getQty());
					mat.setCost(union.getCost());
					mat.setMat_name(union.getMat_name());
					mat.setLprod_name(union.getLprod());
					mat.setMat_stand_size(union.getStand_size());
					mlist.add(mat);
				} else {	//일반발주
					Buy_ItemVO item = new Buy_ItemVO();
					item.setItem_no(union.getMat_no());
					item.setOr_code(or.getOr_code());
					item.setItem_name(union.getMat_name());
					item.setItem_qty(union.getQty());
					item.setItem_cost(union.getCost());
					item.setItem_lprod(union.getLprod());
					item.setItem_stand_size(union.getStand_size());
					ilist.add(item);
				}
			}
			or.setMatList(mlist);
			or.setItemList(ilist);
//			or.getUnionList().clear();
		}
		return orList;
	}

	@Override
	public int readBuyOrderCount(PagingVO<Buy_OrderVO> pagingVO) {
		return dao.selectBuyOrderCount(pagingVO);
	}

	@Override
	public List<Buy_Doc_MatVO> readBuyDocMatList() {
		return dao.selectBuyDocMatList();
	}

	@Override
	public ServiceResult deleteDocMat(Buy_Doc_MatVO matVO) {
		int cnt = dao.deleteDocMat(matVO);
		if(cnt>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Transactional
	@Override
	public ServiceResult deleteBuyOrder(Buy_OrderVO orderVO) {
		int del = dao.deleteBuyOder(orderVO);
		if(del>0) {
			dao.updateDocStatus(orderVO);
			return ServiceResult.OK;
		}
		else return ServiceResult.FAIL;
	}
	
}
