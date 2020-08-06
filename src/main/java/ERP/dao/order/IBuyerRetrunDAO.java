package ERP.dao.order;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.order.BuyerReturnVO;

/**
 * 매출반품관리 Persistence Layer
 */
@Repository
public interface IBuyerRetrunDAO {
	
	/**
	 * 신규등록
	 * @param buyerId
	 * @return 등록된 글수
	 */
	public int insertBuyerRetrun(BuyerReturnVO buyerReturn);
	
	/**
	 * 매출반품상세조회
	 * @param buyerRetrn_no
	 * @return 존재하지 않으면 null 반환
	 */
	public BuyerReturnVO selectBuyerReturn(int or_retp_no);
	
	/**
	 * 검색조건에 맞는 게시글수 조회
	 * @param pagingVO
	 * @return 조회된 글 수 
	 */
	public int selectBuyerReturnCount(PagingVO<BuyerReturnVO> pagingVO); 
	
	/**
	 * 검색조건에 맞는 게시글 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO);
	
	/**
	 * 게시글 수정
	 * @param buyerReturn
	 * @return
	 */
	public int updateBuyerReturn(BuyerReturnVO buyerReturn);
	
	/**
	 * 게시글 삭제
	 * @param buyerReturn_no
	 * @return
	 */
	public int deleteBuyerReturn(int or_retp_no);
	
	
	
	
}
