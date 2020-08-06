package ERP.service;

import java.util.List;

import enums.ServiceResult;
import vo.BuyerVO;
import vo.PagingVO;
import vo.RuleVO;

public interface IBuyerService {
	/**
	 * @param buyer
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult createBuyer(BuyerVO buyer, String code);
	
	/**
	 * 
	 * @return 거래상태 정책코드
	 */
	public List<RuleVO> readRuleList();
	
	/**
	 * @param pagingVO
	 * @return 거래처 수
	 */
	public int readBuyerCount(PagingVO<BuyerVO> pagingVO);
	/**
	 * @param pagingVO
	 * @return 모든 거래처 vo
	 */
	public List<BuyerVO> readBuyerList(PagingVO<BuyerVO> pagingVO);
	/**
	 * @param buyer_no
	 * @return 해당하는 거래처의 vo
	 */
	public BuyerVO readBuyer(String buyer_no);
	/**
	 * @param buyer
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult modifyBuyer(BuyerVO buyer);
	/**
	 * @param buyer_no
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult removeBuyer(String buyer_no);
}
