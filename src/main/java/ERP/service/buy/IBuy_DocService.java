package ERP.service.buy;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_DocumentVO;

public interface IBuy_DocService {
	/**
	 * @param vo
	 * @return 구매요청서 등록 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult createBuyDoc(Buy_DocumentVO vo);
	
	/**
	 * @return 구매요청서 리스트
	 */
	public List<Buy_DocumentVO> readBuyDocList(PagingVO<Buy_DocumentVO> pagingVO); 
	
	/**
	 * @param pagingVO
	 * @return 검색 조건에 맞는 구매요청서 수 조회
	 */
	public int readBuyDocCount(PagingVO<Buy_DocumentVO> pagingVO);
	
	public ServiceResult deleteBuyDoc(Buy_DocumentVO docVO);
}
