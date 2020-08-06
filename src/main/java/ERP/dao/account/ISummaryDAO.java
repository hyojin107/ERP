package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.account.SummaryVO;

@Repository
public interface ISummaryDAO {
	public int insertSummary(SummaryVO vo);
	public SummaryVO selectSummary(int summary_code);
	public List<SummaryVO> selectSummaryList();
	public int deleteSummary(int summary_code);
}
