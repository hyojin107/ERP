package ERP.dao.product;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.product.PdReportVO;

/**
 * @author PC-12
 * 
 *
 */
@Repository
public interface IpdReportDao {
	
	/**
	 * @return
	 * 생산보고서 리스트들을 보여줌
	 */
	public List<PdReportVO> SelectReportList(PagingVO<PdReportVO> vo);
	
	/**
	 * @param PdReport_code
	 * @return
	 * 생산보고서 리스트들 중 하나를 선택함
	 */
	public PdReportVO SelectReportVO(String PdReport_code);
	
	
	/**
	 * @param reportVO
	 * @return
	 * 생산보고서를 작성한다.
	 */
	public ServiceResult InsertReportVO(PdReportVO reportVO);
	

}
