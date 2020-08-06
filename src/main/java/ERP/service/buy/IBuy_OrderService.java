package ERP.service.buy;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_OrderVO;

public interface IBuy_OrderService {
	/**
	 * @param vo
	 * @return 발주서 등록 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult createBuyOrder(Buy_OrderVO vo);
	
	/**
	 * @return 발주서 리스트
	 */
	public List<Buy_OrderVO> readBuyOrderList(PagingVO<Buy_OrderVO> pagingVO); 
	
	/**
	 * @param pagingVO
	 * @return 검색 조건에 맞는 발주서 수 조회
	 */
	public int readBuyOrderCount(PagingVO<Buy_OrderVO> pagingVO);

	/**
	 * @return 발주서Form에 띄울 구매요청 목록
	 */
	public List<Buy_Doc_MatVO> readBuyDocMatList();
	
	/**
	 * @return 요청항목 원자재 삭제
	 */
	public ServiceResult deleteDocMat(Buy_Doc_MatVO matVO);
	
	/**
	 * @param orderVO
	 * @return 발주서 삭제, 이에 따른 구매요청서 상태 변경
	 */
	public ServiceResult deleteBuyOrder(Buy_OrderVO orderVO);
	
}
