package ERP.dao.buy;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_OrderVO;

@Repository
public interface IBuy_OrderDAO {
	
	/**
	 * @param vo
	 * @return 발주서 등록
	 */
	public int insertBuyOrder(Buy_OrderVO vo);
	
	/**
	 * @param vo
	 * @return 트리거 발동으로 인해, 트랜젝션 관리를 위해 원자재 리스트는 따로 insert해줌
	 */
	public int insertBuyOrderMatList(Buy_OrderVO vo);

	/**
	 * @return 발주서 목록
	 */
	public List<Buy_OrderVO> selectBuyOrderList(PagingVO<Buy_OrderVO> pagingVO);
	
	/**
	 * @param pagingVO
	 * @return 검색 조건에 맞는 발주서 수 조회
	 */
	public int selectBuyOrderCount(PagingVO<Buy_OrderVO> pagingVO);
	
	/**
	 * @return 발주 원자재 PK 구하기
	 */
	public int selectBuyOrderMatPK();
	
	/**
	 * @return 일반 발주 물품 PK 구하기
	 */
	public int selectBuyOrderItemPK();
	
	/**
	 * @return 발주서Form에 띄울 구매요청 목록
	 */
	public List<Buy_Doc_MatVO> selectBuyDocMatList();
	
	/**
	 * @return 요청항목 원자재 삭제
	 */
	public int deleteDocMat(Buy_Doc_MatVO matVO);
	
	
	/**
	 * @param orderVO
	 * @return 발주서 삭제
	 */
	public int deleteBuyOder(Buy_OrderVO orderVO);
	
	/**
	 * @param orderVO
	 * @return 발주서 삭제에 따라, 구매요청목록에서의 상태값 변경 
	 */
	public int updateDocStatus(Buy_OrderVO orderVO);
}

