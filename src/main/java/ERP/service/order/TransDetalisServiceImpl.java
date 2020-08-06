package ERP.service.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.order.ITransDetailsDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.order.ShipmentVO;
import vo.order.TransDetailsVO;

/**
 * 거래명세서
 *
 */
@Service
public class TransDetalisServiceImpl implements ITransDetalisService {
	
	@Inject
	ITransDetailsDAO transDetailsDAO;
	
	@Override
	public ServiceResult createTransD(TransDetailsVO transD) {
		int rowcnt = transDetailsDAO.insertTransD(transD);
		ServiceResult result = null;
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public TransDetailsVO readTransD(Integer tran_no) {
		TransDetailsVO transDetailsVO = transDetailsDAO.selectTransD(tran_no);
		if(transDetailsVO==null) throw new DataNotFoundException();
		return transDetailsVO;
	}

	@Override
	public int readTransDCount(PagingVO<TransDetailsVO> pagingVO) {
		return transDetailsDAO.selectTransDCount(pagingVO);
	}

	@Override
	public List<TransDetailsVO> readTransDList(PagingVO<TransDetailsVO> pagingVO) {
		return transDetailsDAO.selectTransDList(pagingVO);
	}

	@Override
	public ServiceResult modifyTransD(TransDetailsVO transD) {
		int cnt = transDetailsDAO.updateTransDetails(transD);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult deleteTransD(int tran_no) {
		ServiceResult result = null;
		int rowcnt = transDetailsDAO.deleteTransDetails(tran_no);
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
