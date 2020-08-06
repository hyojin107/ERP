package ERP.service.buy;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_ReturnVO;

public interface IBuy_ReturnService {
	
	/**
	 * @param retVO
	 * @return 반품서 등록
	 */
	public ServiceResult createReturn(Buy_ReturnVO retVO);
	
	public int readReturnCount(PagingVO<Buy_ReturnVO> pagingVO);
	
	public List<Buy_ReturnVO> readReturnList(PagingVO<Buy_ReturnVO> pagingVO);
	
	/**
	 * @param retVO
	 * @return 반품서 삭제
	 */
	public ServiceResult deleteReturn(Buy_ReturnVO retVO);
}
