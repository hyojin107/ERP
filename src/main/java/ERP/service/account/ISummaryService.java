package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.SummaryVO;

public interface ISummaryService {
	public ServiceResult  createSummary(SummaryVO vo); 
	public List<SummaryVO> readSummaryList(PagingVO<SummaryVO> pagingVO); 
	public SummaryVO readSummary(int Summary_no); 
	public ServiceResult removeSummary(SummaryVO vo); 
}
