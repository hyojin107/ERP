package ERP.dao.wareHouse;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;
import vo.product.DisStuffVO;
import vo.product.PdReportVO;
import vo.product.StuffVO;
import vo.wareHouse.Mat_DisUseVO;
import vo.wareHouse.Prod_DisUseVO;

@Repository
public interface IDisuseDAO {
//	폐기관리
//	1. 폐기등록서 작성 (원자재, 상품)
	/**
	 * 원자재 폐기 등록
	 * @param matdisVO
	 * @return
	 */
	public int insertDisUse(DisStuffVO stuffVO);
	
	/**
	 * 상품 폐기등록
	 * @param proddisVO
	 * @return
	 */
	public ServiceResult insertProdDisUse(Prod_DisUseVO proddisVO);
	
//	2. 폐기등록서 목록 보여주기(원자재, 상품)
	/**
	 * 조건에 맞는 원자재 폐기 수
	 * @param pagingVO
	 * @return
	 */
	public int readMatDisUseCnt(PagingVO<Mat_DisUseVO> pagingVO);
	
	/**
	 * 조건에 맞는 상품 폐기 수
	 * @param pagingVO
	 * @return
	 */
	public int readProdDisUseCnt(PagingVO<Prod_DisUseVO> pagingVO);
	
	/**
	 * 검색 조건에 맞는 원자재 목록 
	 * @param pagingVO
	 * @return
	 */
	public List<StuffVO> readMatDisUseList(StuffVO detailSearch);
	/**
	 * 검색 조건에 맞는 상품 목록
	 * @param pagingVO
	 * @return
	 */
	public List<StuffVO> readProdDisUseList(StuffVO detailSearch);
	
//	3. 폐기등록서 상세보기 (원자재 , 폐기)
	/**
	 * 원자재 폐기 등록서 상세 보기 
	 * @param board_no
	 * @return
	 */
	public Mat_DisUseVO readMatDisUse(int board_no);
	/**
	 * 상품 폐기 등록서 상세 보기
	 * @param board_no
	 * @return
	 */
	public Prod_DisUseVO readProdDisUse(int board_no);
	
//	4. 반품의뢰서 불러오기 -- 제경
	/**
	 * 조건에 맞는 반품의뢰서 갯수반환
	 * @param pagingVO
	 * @return
	 */
	public int readBuyerReturnCnt(PagingVO<BuyerReturnVO> pagingVO);
	
	/**
	 * 반품의뢰서 목록 전체 조회
	 * @param pagingVO
	 * @return
	 */
	public List<BuyerReturnVO> readBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO);

//	6. 반품의뢰서 상세보기 -- 제경
	/**
	 * 반품의뢰서 상세보기 
	 * @param board_no
	 * @return
	 */
	public BuyerReturnVO readBuyerReturn(int board_no);

//	8. 반품의뢰서로 상품 폐기 처리
	/**
	 * 반품의뢰서를 토대로 상품폐기하기 
	 * @param buyReturnVO
	 * @return
	 */
	public ServiceResult prodReDisUse(BuyerReturnVO buyReturnVO);
	
//	5. 생산보고서 불러오기 -- 정민
	/**
	 * 조건에 맞는 생산보고서 수 (?)
	 * @param pagingVO
	 * @return
	 */
	public int pdReportCnt(PagingVO<PdReportVO> pagingVO);
	
	/**
	 * 조건에 맞는 생산 보고서 목록
	 * @param pagingVO
	 * @return
	 */
	public List<PdReportVO> readPdReportList(PagingVO<PdReportVO> pagingVO);
	
//	7. 생산보고서 상세보기 -- 정민
	/**
	 * 생산보고서 상세보기 
	 * @param board_no
	 * @return
	 */
	public PdReportVO readPdReport(int board_no);
	
//	9. 생산보고서로 상품 폐기 처리
	/**
	 * 생산보고서를 토대로 상품 폐기처리 ,생산보고서 vo를 파라미터 값으로 받는다
	 * @param pdReportVO
	 * @return
	 */
	public ServiceResult prodMFDisUse(PdReportVO pdReportVO);
	
}
