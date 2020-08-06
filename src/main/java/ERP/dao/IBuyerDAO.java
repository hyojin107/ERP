package ERP.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.BuyerVO;
import vo.PagingVO;
import vo.RuleVO;

/**
 * @author 송효진
 * @since 2020. 7. 3
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               	수정내용
 * --------     --------    ----------------------
 * 2020. 7. 3           송효진       		최초작성
 * Copyright (c) 2020 by DDIT All right reserved
 * </pre>
 */
@Repository
public interface IBuyerDAO {
	/**
	 * @param vo
	 * @return 등록된 구매처 수
	 */
	public int insertBuyBuyer(BuyerVO vo);
	/**
	 * @param vo
	 * @return 등록된 판매처 수
	 */
	public int insertProdBuyer(BuyerVO vo);
	/**
	 * @param vo
	 * @return 등록된 판매처 수
	 */
	public int insertAccountBuyer(BuyerVO vo);
	
	
	/**
	 * @return 거래상태 정책코드
	 */
	public List<RuleVO> selectRuleList();
	
	/**
	 * @param vo
	 * @return 검색 조건에 맞는 거래처 수 조회
	 */
	public int selectBuyerCount(PagingVO<BuyerVO> vo);
	/**
	 * @param pagingVO
	 * @return 검색 조건에 맞는 거래처 목록 조회
	 */
	public List<BuyerVO> selectBuyerList(PagingVO<BuyerVO> pagingVO);
	/**
	 * @param buyer_no
	 * @return 거래처 상세 조회
	 */
	public BuyerVO selectBuyer(String buyer_no);
	/**
	 * @param vo
	 * @return 거래처 정보 수정
	 */
	public int updateBuyer(BuyerVO vo);
	/**
	 * @param buyer_no
	 * @return 거래처 '사용 중단'으로 변경
	 */
	public int deleteBuyer(String buyer_no);
}
