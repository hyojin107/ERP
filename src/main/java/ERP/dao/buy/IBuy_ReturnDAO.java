package ERP.dao.buy;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.buy.Buy_ReturnVO;

@Repository
public interface IBuy_ReturnDAO {
	
	/**
	 * @param retVO
	 * @return 반품서 등록
	 */
	public int insertReturn(Buy_ReturnVO retVO);
	
	public int selectRetItemPK();
	
	public int selectRetMatPK();
	
	
	public int selectReturnCount(PagingVO<Buy_ReturnVO> pagingVO);
	
	public List<Buy_ReturnVO> selectReturnList(PagingVO<Buy_ReturnVO> pagingVO);
	
	
	/**
	 * @param retVO
	 * @return 반품서 삭제
	 */
	public int deleteReturn(Buy_ReturnVO retVO);
}
