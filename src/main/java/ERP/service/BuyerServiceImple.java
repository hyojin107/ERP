package ERP.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.IBuyerDAO;
import enums.ServiceResult;
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
 * 2020. 7. 3            송효진       		최초작성
 * Copyright (c) 2020 by DDIT All right reserved
 * </pre>
 */
@Service
public class BuyerServiceImple implements IBuyerService {
	
	@Inject
	IBuyerDAO dao;
	
	
	@Override
	public ServiceResult createBuyer(BuyerVO buyer, String code) {
		int result = 0;
		if("M".equals(code)) {
			result = dao.insertBuyBuyer(buyer);		//구매처			
		}else if("P".equals(code)){
			result = dao.insertProdBuyer(buyer);	//판매처
		}else {
			result = dao.insertAccountBuyer(buyer);
		}
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}
	
	@Override
	public BuyerVO readBuyer(String buyer_no) {
		return dao.selectBuyer(buyer_no);
	}

	@Override
	public int readBuyerCount(PagingVO<BuyerVO> pagingVO) {
		return dao.selectBuyerCount(pagingVO);
	}

	@Override
	public List<BuyerVO> readBuyerList(PagingVO<BuyerVO> pagingVO) {
		return dao.selectBuyerList(pagingVO);
	}

	@Override
	public ServiceResult modifyBuyer(BuyerVO buyer) {
		int result = dao.updateBuyer(buyer);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeBuyer(String buyer_no) {
		int result = dao.deleteBuyer(buyer_no);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public List<RuleVO> readRuleList() {
		return dao.selectRuleList();
	}

}
