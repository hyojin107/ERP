package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IOuterDao;
import enums.ServiceResult;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.wareHouse.OuterDocumentVO;
import vo.wareHouse.ProdVO;

@Service
public class OuterDocumentServiceImpl implements IOuterDocumentService {

	@Inject
	IOuterDao outerDao;
	
	// 7. 출하지시서, 생산보고서 불러오기 
	@Override
	public int readOuterDocCnt(PagingVO<OuterDocumentVO> pagingVO) {
		return outerDao.readOuterDocCnt(pagingVO);
	}

	@Override
	public List<OuterDocumentVO> readOuterDocList(PagingVO<OuterDocumentVO> pagingVO) {
		return outerDao.readOuterDocList(pagingVO);
	}

	// 7-1. 출하지시서
	/**
	 * 출하지시서 상세보기 
	 * @param board_no
	 * @return
	 */
	@Override
	public DeliveryOrderVO readDeliveryOrder(int board_no) {
		return outerDao.readDeliveryOrder(board_no);
	}
	
	//=======================================================
	
	/**
	 * 출하지시서 진행상태 수정하기 OR02
	 * @param deliveryVO
	 * @return
	 */
	@Override
	public ServiceResult updateOrDelivery(DeliveryOrderVO deliveryVO) {
		/**
		 * 출하지시서 진행상태 수정 > 상품 출고테이블 insert > 
		 * 상품테이블 수량 update > 상품 창고 구역 update 
		 */
		
		int prodoutInsert =0;
		
		// or_delivery > 출하지시서 번호를 해당하는 문서의 진행상태를 변경시켜준다. 
		int orDelivInsert = outerDao.updateOrDelivery(deliveryVO); // 출하지시서 진행상태 수정
		
		if(orDelivInsert > 0) {
			// 출하지시서의 상태를 변경하면 출하지시서>주문서>주문서상품목록에 있는 상품을 반복문을 돌면서 insert시킨다. 
			int prodoutPK = outerDao.prodOutPK(); // prod_outpk 생성 
				deliveryVO.setProd_out_no(prodoutPK);
			prodoutInsert = outerDao.insertProdOut(deliveryVO); // 상품 출고 테이블 insert
		}
		
		ServiceResult result = null;
		if(prodoutInsert > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	
	

}
