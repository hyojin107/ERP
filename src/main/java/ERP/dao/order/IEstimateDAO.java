package ERP.dao.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import vo.BuyerVO;
import vo.PagingVO;
import vo.order.EstimateListVO;
import vo.order.EstimateVO;
import vo.wareHouse.ProdVO;

/**
 * 견적서 persistence layer
 */
@Repository
public interface IEstimateDAO {
	
	/**
	 * 신규등록
	 * @param estimate
	 * @return 등록된 견적서 수 
	 */
	public int insertEstimate(EstimateVO estimate);
	
	/**
	 * 견적서 상세조회
	 * @param est_no
	 * @return 존재하지 않으면 null 반환
	 */
	public EstimateVO selectEstimate(int est_no);

	/**
	 * 검색조건에 맞는 견적서 조회
	 * @param pagingVO
	 * @return 
	 */
	public int selectEstimateCount(PagingVO<EstimateVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 견적서 목록조회
	 * @param pagingVO
	 * @return
	 */
	public List<EstimateVO> selectEstimateList(PagingVO<EstimateVO> pagingVO);
	
	//정보수정-----------------------------------------------------------------------
	/**
	 * 견적서 수정
	 * @param estimate
	 * @return
	 */
	public int updateEstimate(EstimateVO estimate);
	
	public int updateEstList(EstimateListVO estimateList);
	
	//정보수정-----------------------------------------------------------------------
	/**
	 * 견적서 삭제
	 * @param est_no
	 * @return
	 */
	public int deleteEstimate(EstimateVO estimateVO);
	
	/**
	 * prod의 분류코드 전부 불러오기
	 * @return
	 */
	public List<Map<String, String>> selectAllProdLgu();
	
	/**
	 * 분류코드에 해당하는 상품 모두 불러오기
	 * @param prod_lgu
	 * @return
	 */
	public List<ProdVO> selectAllProd(@Param("lgu") String prod_lgu);
	
	/**
	 * 상품 상세보기
	 * @param prod_no
	 * @return
	 */
	public ProdVO selectProd(String prod_no);
	

}
