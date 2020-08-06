package ERP.service.wareHouse;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.wareHouse.OuterDocumentVO;

public interface IOuterDocumentService {
	
	// 7. 출하지시서, 생산보고서 불러오기 
	/**
	 * 조건에 맞는 출하지시서, 생산보고서 갯수 반환
	 * @param pagingVO
	 * @return
	 */
	public int readOuterDocCnt(PagingVO<OuterDocumentVO> pagingVO);
	
	/**
	 * 조건에 맞는 출하지시서, 생산보고서 목록 전체 조회 
	 * @param pagingVO
	 * @return
	 */
	public List<OuterDocumentVO> readOuterDocList(PagingVO<OuterDocumentVO> pagingVO);
	
//	9. 출하지시서 상세보기 -- 제경
	/**
	 * 출하지시서 상세보기 
	 * @param board_no
	 * @return
	 */
	public DeliveryOrderVO readDeliveryOrder(int board_no);
	
//==========================================================
	
	/**
	 * 출하지시서 진행상태 수정하기 OR02
	 * @param deliveryVO
	 * @return
	 */
	public ServiceResult updateOrDelivery(DeliveryOrderVO deliveryVO);


}
