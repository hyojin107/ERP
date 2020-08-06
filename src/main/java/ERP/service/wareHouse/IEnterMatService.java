package ERP.service.wareHouse;

import java.util.List;

import org.springframework.stereotype.Service;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;
import vo.product.PdReportVO;
import vo.wareHouse.MaterialVO;

public interface IEnterMatService {

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
	
}
