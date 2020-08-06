package ERP.service.wareHouse;

import java.util.List;

import vo.PagingVO;
import vo.wareHouse.ProdVO;

public interface IOuterProdService {

//	출고관리 
//	1. 현재고량이 부족한 상품 목록 출력 list
	/**
	 * 검색 조건에 맞는 상품 수량
	 * @param pagingVO
	 * @return
	 */
	public int ProdLackCnt(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 현재 재고량이 부족한 상품목록을 출력한다. 
	 * @param pagingVO
	 * @return
	 */
	public List<ProdVO> ProdLackList(PagingVO<ProdVO> pagingVO);
	
}
