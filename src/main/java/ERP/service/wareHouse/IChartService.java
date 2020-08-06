package ERP.service.wareHouse;

import org.springframework.stereotype.Service;

import vo.PagingVO;
import vo.wareHouse.MaterialVO;
import vo.wareHouse.ProdVO;

@Service
public interface IChartService {
	// prodvo 안에서 전부 출력할수 있도록 
	// 어디서 어떤 정보를 긁어올것인지 파악  

	// 현황(CHART)
	// 상품별 입고, 출고, 폐기 현황 보여주기
	public int prodEnterChart(ProdVO prod_no);
	public int prodOuterChart(ProdVO prod_no);
	public int prodDisuseChart(ProdVO prod_no);
	
	// 원자재별 입고, 출고, 폐기 현황 보여주기
	public int matEnterChart(MaterialVO mat_no);
	public int matOuterChart(MaterialVO mat_no);
	public int matDisuseChart(MaterialVO mat_no);
	
	// 기간별  상품 입고, 출고, 폐기 현황 보여주기
	public int periodProdEnChart(PagingVO<ProdVO> pagingVO);
	public int periodProdOuChart(PagingVO<ProdVO> pagingVO);
	public int periodProdDuChart(PagingVO<ProdVO> pagingVO);
	
	// 기간별  원자재 입고, 출고, 폐기 현황 보여주기
	public int periodMatEnChart(PagingVO<MaterialVO> pagingVO);
	public int periodMatOuChart(PagingVO<MaterialVO> pagingVO);
	public int periodMatDuChart(PagingVO<MaterialVO> pagingVO);
	
}
