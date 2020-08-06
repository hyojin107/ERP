package ERP.service.wareHouse;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.wareHouse.PDuct_OR_VO;

public interface IOuterPDuctService {
	
//	3. 생산의뢰서 작성 
	/**
	 * 생산의뢰서 작성 / 등록
	 * @param pdOrVO
	 * @return
	 */
	public ServiceResult insertPDuctOR(PDuct_OR_VO pdOrVO);
	
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
}
