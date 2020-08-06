package ERP.service.order;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import ERP.dao.emp.IAttatachDAO;
import ERP.dao.order.IEstimateDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.order.EstimateListVO;
import vo.order.EstimateVO;
import vo.wareHouse.ProdVO;

/**
 * 견적서
 *
 */

@Service
public class EstimateServiceImpl implements IEstimateService {
	@Inject
	IEstimateDAO estimateDAO;
	@Inject
	IAttatachDAO attachDAO;
	
	@Inject
	WebApplicationContext context;
	
	
	
	@Transactional // 두개의 메소드를 실행시킬때 적용시키는 annotation
	@Override
	public ServiceResult createEstimate(EstimateVO estimate) {
		int rowcnt = estimateDAO.insertEstimate(estimate);
		ServiceResult result = null;
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public EstimateVO readEstimate(int est_no) {
		EstimateVO estimateVO = estimateDAO.selectEstimate(est_no);
		if(estimateVO==null) throw new DataNotFoundException("해당하는 견적서가 없음");
		return estimateVO;
	}

	@Override
	public int readEstimateCount(PagingVO<EstimateVO> pagingVO) {
		return estimateDAO.selectEstimateCount(pagingVO);
	}

	@Override
	public List<EstimateVO> readEstimateList(PagingVO<EstimateVO> pagingVO) {
		return estimateDAO.selectEstimateList(pagingVO);
	}
	
	@Transactional
	@Override
	public ServiceResult modifyEstimate(EstimateVO estimate) {
		readEstimate(estimate.getEst_no());
		int cnt = estimateDAO.updateEstimate(estimate);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyEstimateList(EstimateListVO estimateList) {
		int cnt = estimateDAO.updateEstList(estimateList);
		
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	


	@Override
	public ServiceResult removeEstimate(EstimateVO estimateVO) {
		int cnt = estimateDAO.deleteEstimate(estimateVO);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public List<Map<String, String>> readAllProdLgu() {
		return estimateDAO.selectAllProdLgu();
	}

	@Override
	public List<ProdVO> readAllProd(String prod_lgu) {
		return estimateDAO.selectAllProd(prod_lgu);
	}

	@Override
	public ProdVO readProdList(String prod_no) {
		ProdVO prodVO = estimateDAO.selectProd(prod_no);
		if(prodVO==null) 
			throw new DataNotFoundException(prodVO.getProd_name()+"상품이 없음");
		return prodVO;
	}



	
	
}
