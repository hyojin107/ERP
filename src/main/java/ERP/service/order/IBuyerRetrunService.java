package ERP.service.order;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;

public interface IBuyerRetrunService {
	
	/**
	 * 신규 매출반품 등록
	 * @param buyerReturn
	 * @return PKDUPLICATED, OK, FAIL
	 */
	public ServiceResult createBuyerReturn(BuyerReturnVO buyerReturn);
	
	/**
	 * 매출반품 상세조회
	 * @param ret_retp_no
	 * @return 존재하지 않는다면, DATANOTFOUNTEXCEPTION 발생
	 */
	public BuyerReturnVO readBuyerReturn(int ret_retp_no);
	
	/**
	 * 검색조건에 맞는 매출반품 수 
	 * @param pagingVO
	 * @return
	 */
	public int readBuyerReturnCount(PagingVO<BuyerReturnVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 매출반품 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<BuyerReturnVO> readBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO);
	
	/**
	 * 매출반품서 수정
	 * @param buyerReturn
	 * @return 존재하지 않는다면, DataNotFoundException, INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult modifyBuyerReturn(BuyerReturnVO buyerReturn);
	
	/**
	 * 매출반품서 삭제
	 * @param buyerReturn
	 * @return 존재하지 않는다면 DataNotFoundException, INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeBuyerReturn(BuyerReturnVO buyerReturn);
}
