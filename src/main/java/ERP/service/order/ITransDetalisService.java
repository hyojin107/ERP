package ERP.service.order;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.TransDetailsVO;

/**
 * 거래명세서
 *
 */
public interface ITransDetalisService {
	
	public ServiceResult createTransD(TransDetailsVO transD);
	public TransDetailsVO readTransD(Integer tran_no);
	public int readTransDCount(PagingVO<TransDetailsVO> pagingVO);
	public List<TransDetailsVO> readTransDList(PagingVO<TransDetailsVO> pagingVO);
	public ServiceResult modifyTransD(TransDetailsVO transD);
	public ServiceResult deleteTransD(int tran_no);
	
}
