package ERP.dao.buy;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.buy.Buy_PurchaseVO;

@Repository
public interface IBuy_PurchaseDAO {
	
	/**
	 * @param vo
	 * @return 매입서 등록
	 */
	public int insertPurchase(Buy_PurchaseVO vo);
	
	/**
	 * @return 매입서 마지막 pk 값 들고오기
	 */
	public int selectPurchasePK();
	
	public int selectPurchaseCount(PagingVO<Buy_PurchaseVO> pagingVO);
	
	/**
	 * @param pagingVO
	 * @return 매입서 조회 리스트
	 */
	public List<Buy_PurchaseVO> selectPurchaseList(PagingVO<Buy_PurchaseVO> pagingVO);
	
	
	/**
	 * @param purVO
	 * @return 매입서 삭제
	 */
	public int deletePurchase(Buy_PurchaseVO purVO);
}
