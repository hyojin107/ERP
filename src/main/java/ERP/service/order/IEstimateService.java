package ERP.service.order;
/**
 * 견적서
 *
 */

import java.util.List;
import java.util.Map;

import enums.ServiceResult;
import vo.BuyerVO;
import vo.PagingVO;
import vo.order.EstimateListVO;
import vo.order.EstimateVO;
import vo.wareHouse.ProdVO;

public interface IEstimateService {
	public ServiceResult createEstimate(EstimateVO estimate);
	public EstimateVO readEstimate(int est_no);
	public int readEstimateCount(PagingVO<EstimateVO> pagingVO);
	public List<EstimateVO> readEstimateList(PagingVO<EstimateVO> pagingVO);
	public ServiceResult modifyEstimate(EstimateVO estimate);
	public ServiceResult modifyEstimateList(EstimateListVO estimateList);
	public ServiceResult removeEstimate(EstimateVO estimateVO);
	public List<Map<String, String>> readAllProdLgu();
	public List<ProdVO> readAllProd(String prod_lgu);
	public ProdVO readProdList(String prod_no);

	
}
