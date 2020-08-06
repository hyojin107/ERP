package ERP.service.product;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.product.PdReportVO;

/**
 * @author PC-12
 *
 *생산보고서 리스트들을 읽는다.
 */
public interface IpdReportService {

	
	
	/**
	 * @return
	 * 생산보고서 리스트을 읽어온다.
	 */
	public List<PdReportVO> ReadReportList(PagingVO<PdReportVO> pdreportVO);
	
	/**
	 * @param Report_code
	 * @return
	 * 생산보고서 하나를 읽어온다.
	 */
	public PdReportVO ReadReport(String Report_code);
	
	
	/**
	 * @param reportVo
	 * @return
	 * 생산보고서 생성
	 */
	public ServiceResult CreateReport(PdReportVO reportVo);
	
}
