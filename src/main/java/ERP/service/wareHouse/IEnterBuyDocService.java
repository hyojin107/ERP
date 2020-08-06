package ERP.service.wareHouse;

import java.util.List;

import org.springframework.stereotype.Service;

import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_DocumentVO;
import vo.product.StuffVO;
import vo.wareHouse.EnterStuffVO;


public interface IEnterBuyDocService {
//	3. 구매 의뢰서 작성 -- 효진 -- Buy_Document
	/**
	 * 원자재 구매 의뢰서 작성하기 
	 * @param BuyDocVO
	 * @return
	 */
	public ServiceResult createBuyDoc(Buy_DocumentVO BuyDocVO);
	
//	4. 구매 의뢰서 목록 출력 -- 효진
	/**
	 * 조건에 맞는 구매의뢰서 수
	 * @param pagingVO
	 * @return
	 */
	public int readBuyDocCnt(PagingVO<Buy_DocumentVO> pagingVO);
	
	/**
	 * 조건에 맞는 구매의뢰서 목록 불러오기
	 * @param pagingVO
	 * @return
	 */
	public List<EnterStuffVO> readBuyDocList(String code);
//	5. 구매 의뢰서 상세보기 -- 효진
	/**
	 * 구매의뢰서 상세보기
	 * @param board_no
	 * @return
	 */
	public Buy_DocumentVO readBuyDoc(int board_no);
	
//	6. 매입서 불러오기  -- 효진
//	9. 매입서 상세보기 -- 효진
//	13. 원자재 입고하기
	// 매입서안에 있는 원자재 정보를 가져와야한다. 파라미터로 매입서를 받는다. 
	public ServiceResult EnterMat();
}
