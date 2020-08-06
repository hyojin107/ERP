package ERP.service.product;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ERP.dao.product.IproOrderDao;
import ERP.dao.wareHouse.IProdDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.product.PdReportVO;
import vo.product.PductListVO;
import vo.product.PductorderVO;

@Service
public class prodOrderServiceImpl implements IprodOrderService {

	@Inject
	IproOrderDao dao;
	
	@Override
	public List<PductorderVO> ReadProdorderList(PagingVO<PductorderVO> pductorde) {
		
		
		return dao.SelectListprodOrder(pductorde);
	}

	@Override
	public PductListVO ReadProdorder(String order_code) {
		
		return dao.SelectprodOrder(order_code);
	}

	@Override
	public ServiceResult CreateProdorder(PdReportVO orderVO) {

		int cnt = dao.InsertprodOrder(orderVO);

		ServiceResult result = null;
		
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public int ReadProdorderCount(PagingVO<PductorderVO> pductorde) {
		
		return dao.CountSelectprodOrder(pductorde);
	}

	
	@Transactional
	@Override
	public ServiceResult ConfirmProdorder(int porder_no) {
		
		int cnt = dao.UpdateConfirmOrder(porder_no);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt > 0) result = ServiceResult.OK;
		
		return result;
	}

	@Override
	public List<PductorderVO> ReadConfirmorderList() {
		// TODO Auto-generated method stub
		return dao.SelectConfirmOrder();
	}

	
}
