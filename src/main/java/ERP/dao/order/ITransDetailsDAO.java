package ERP.dao.order;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.order.TransDetailsVO;

/**
 * 거래명세서 persistence layer 
 *
 */
@Repository
public interface ITransDetailsDAO {
	
	/**
	 * 거래명세서입력
	 * @param transDetailsVO
	 * @return
	 */
	public int insertTransD(TransDetailsVO transD);
	
	/**
	 * 거래명세서 상세조회
	 * @param tran_no
	 * @return
	 */
	public TransDetailsVO selectTransD(int tran_no);
	
	/**
	 * 검색조건에 맞는 거래명세서 수 조회
	 * @param transD
	 * @return
	 */
	public int selectTransDCount(PagingVO<TransDetailsVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 거래명세서 목록 조회
	 * @param transD
	 * @return
	 */
	public List<TransDetailsVO> selectTransDList(PagingVO<TransDetailsVO> pagingVO);
	
	/**
	 * 수정
	 * @param transD
	 * @return
	 */
	public int updateTransDetails(TransDetailsVO transD);
	
	/**
	 * 삭제
	 * @param tran_no
	 * @return
	 */
	public int deleteTransDetails(int tran_no);
	
	
}
