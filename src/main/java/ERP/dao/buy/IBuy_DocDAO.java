package ERP.dao.buy;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.buy.Buy_DocumentVO;

@Repository
public interface IBuy_DocDAO {
	/**
	 * @param vo
	 * @return 구매 요청서 등록
	 */
	public int insertBuyDoc(Buy_DocumentVO vo);

	/**
	 * @return 구매요청서 목록
	 */
	public List<Buy_DocumentVO> selectBuyDocList(PagingVO<Buy_DocumentVO> pagingVO);
	
	/**
	 * @param pagingVO
	 * @return 검색 조건에 맞는 구매요청서 수 조회
	 */
	public int selectBuyDocCount(PagingVO<Buy_DocumentVO> pagingVO);
	
	/**
	 * @param docVO
	 * @return 구매요청서와 그에 해당하는 구매원자재목록 삭제 
	 */
	public int deleteDoc(Buy_DocumentVO docVO);
	
}
