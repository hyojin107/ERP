package ERP.dao.wareHouse;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.wareHouse.Mat_MF_OutVO;
import vo.wareHouse.OuterDocumentVO;
import vo.wareHouse.PDuct_List_VO;
import vo.wareHouse.PDuct_OR_VO;
import vo.wareHouse.ProdVO;

@Repository
public interface IOuterDao {
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
	
//	3. 생산의뢰서 작성, pduct_or
	/**
	 * 생산의뢰서 작성 / 등록 
	 * @param pdOrVO
	 * @return
	 */
	public int insertPDuctOR(PDuct_OR_VO pdOrVO);
	
//	public int insertPDuctList(PDuct_List_VO pdListVO);
	
	// 생산의뢰서 목록 리스트  테이블 pk생성
	/**
	 * 생산의뢰서 목록 테이블 pk생성
	 * @param pdListVO
	 * @return
	 */
	public int selectPductPK();
	
	/**
	 * mat_mt_out pk
	 * @return
	 */
	public int selectMatMfPK();
	
	/**
	 * pduct_OR pk
	 * @return
	 */
	public int selectPductOrPK();
	
	// 원자재 생산출고 등록 mat_mf_out
	/**
	 * 원자재 생산출고 등록 : 출고량 집계
	 * @param MatMfOutVO
	 * @return
	 */
	public int insertMatMfOut(PDuct_List_VO pductListVO);
			
	// 원자재 수량 업데이트 material 
	/**
	 * 원자재 수량 변경 (생산수량 * bom 수량)
	 * @param mat_no
	 * @return
	 */
	public int updateMatStock(Mat_MF_OutVO vo);
		
	// 원자재 창고 수량 업데이트 mat_sector
	/**
	 * 원자재 수량 변경 (생산수량 * bom 수량)
	 * @param mat_no
	 * @return
	 */
	public int updateMatSector(Mat_MF_OutVO vo);
	
	//------------------------------------------------
	
//	4. 생산의뢰서 목록 출력
	/**
	 * 조건에 맞는 생산의뢰서 수 
	 * @param pdOrVO
	 * @return
	 */
	public int readPDuctORCnt(PagingVO<PDuct_OR_VO> pdOrVO);
	/**
	 * 조건에 맞는 생산의뢰서 목록
	 * @param pagingVO
	 * @return
	 */
	public List<PDuct_OR_VO> readPDuctORList(PagingVO<PDuct_OR_VO> pagingVO);
	/**
	 * 생산의뢰서 상세보기
	 * @param board_no
	 * @return
	 */
	public PDuct_OR_VO readPDuctOR(int board_no);
	
//---------------------------------------------------------------------------------------------------
	// 7. 출하지시서
		/**
		 * 조건에 맞는 출하지시서, 생산보고서 갯수 반환
		 * @param pagingVO
		 * @return
		 */
		public int readOuterDocCnt(PagingVO<OuterDocumentVO> pagingVO);
		
		/**
		 * 조건에 맞는 출하지시서, 생산보고서 목록 전체 조회 
		 * @param pagingVO
		 * @return
		 */
		public List<OuterDocumentVO> readOuterDocList(PagingVO<OuterDocumentVO> pagingVO);
	
		// 7-1. 출하지시서 상세보기 
		/**
		 * 출하지시서 상세보기 
		 * @param board_no
		 * @return
		 */
		public DeliveryOrderVO readDeliveryOrder(int board_no);
		
//		11. 출하지시서로 상품 출고하기 
		
		/**
		 * 출하지시서 진행상태 수정하기 OR02
		 * @param deliveryVO
		 * @return
		 */
		public int updateOrDelivery(DeliveryOrderVO deliveryVO);
		
		/**
		 * prod_out pk 생성 
		 * @return
		 */
		public int prodOutPK();
	
		/**
		 * 상품 출고 테이블 insert하기 
		 * @param deliveryVO
		 * @return
		 */
		public int insertProdOut(DeliveryOrderVO deliveryVO);
		
}
