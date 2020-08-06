package ERP.dao.wareHouse;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;
import vo.product.PdReportVO;
import vo.product.StuffVO;
import vo.wareHouse.EnterStuffVO;
import vo.wareHouse.MaterialVO;

@Repository
public interface IEnterDAO {

	//입고 관리
//	1. 현재고량이 부족한 원자재 목록 출력 - list
	/** 
	 * 검색 조건에 맞는 원자재 수량 
	 * @param pagingVO
	 * @return
	 */
	public int MatLackCnt(PagingVO<MaterialVO> pagingVO);
	
	/**
	 * 현 재고량이 부족한 원자재 목록 출력
	 * @param pagingVO
	 * @return
	 */
	public List<MaterialVO> MatLackList(PagingVO<MaterialVO> pagingVO);
	
	//------------------------------------------------------------------------------------
	// 생산보고서 토대로 상품 입고 하기 
//	8. 생산보고서 불러오기  -- 정민
	/**
	 * 조건에 맞는 생산보고서 수 
	 * @param pagingVO
	 * @return
	 */
	public int pdReportCnt(PagingVO<PdReportVO> pagingVO);
	/**
	 * 조건에 맞는 생산보고서 목록 출력
	 * @param pagingVO
	 * @return
	 */
	public List<PdReportVO> readPdReportList(PagingVO<PdReportVO> pagingVO);
	
//	11. 생산보고서 상세보기  -- 정민 
	/**
	 * 생산보고서 상세보기 
	 * @param board_no
	 * @return
	 */
	public PdReportVO readPdReport(int board_no);
	
//	12. 상품입고하기
	/**
	 * 생산보고서를 토대로 상품 입고하기 (생산보고서를 파라미터 값으로 받는다.)
	 * @param pdReportVO
	 * @return
	 */
	public ServiceResult EnterProd(PdReportVO pdReportVO);
	//------------------------------------------------------------------------------------
	// 반품의뢰서 토대로 상품 입고하기 
//	7. 반품의뢰서 불러오기  -- 제경
	/**
	 * 조건에 맞는 반품의뢰서 수 
	 * @param pagingVO
	 * @return
	 */
	public int readBuyerReturnCnt(PagingVO<BuyerReturnVO> pagingVO);
	/**
	 * 조건에 맞는 반품의뢰서 목록 불러오기 
	 * @param pagingVO
	 * @return
	 */
	public List<BuyerReturnVO> readBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO);
//	10. 반품의뢰서 상세보기 -- 제경
	/**
	 * 반품의뢰서 상세보기 
	 * @param board_no
	 * @return
	 */
	public BuyerReturnVO readBuyerReturn(int board_no);
//	12. 상품입고하기 
	/**
	 * 반품의뢰서를 토대로 상품 입고 (반품의뢰서를 파라미터로 받는다.)
	 * @param buyReVo
	 * @return
	 */
	public ServiceResult ReEnterProd(BuyerReturnVO buyReVo);
	//------------------------------------------------------------------------------------
	// 구매의뢰서 토대로 원자재 입고하기 
	
	public List<EnterStuffVO> readBuyDocList(String code);
}
