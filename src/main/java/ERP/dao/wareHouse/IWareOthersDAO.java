package ERP.dao.wareHouse;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import vo.RuleVO;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;
import vo.wareHouse.LprodVO;
import vo.wareHouse.OuterStoreVO;

/**
 * @author 작성자명
 * @since 2020. 7. 4
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2020. 7. 4    임수진                    lpord_name를 불러오기 위한 DAO
 * 2020. 7. 5    임수진                    공장name과 섹터 name을 불러오기 위한 DAO
 * 2020. 7. 23    임수진                  상품이 저장된 창고와 창고구역 출력 
 * Copyright (c) 2020 by DDIT All right reserved
 * </pre>
 */
@Repository
public interface IWareOthersDAO {

	/**
	 * lprod_name, lprod_no 출력 
	 * @return
	 */
	public List<LprodVO> selectLprodList();
	
	/**
	 * store VO
	 * store_no, lstore_no, store_name, store_def, use_status
	 * @return
	 */
	public List<WareHouseVO> selectStoreList();
	
	/**
	 * sector VO
	 * sector_no, store_no
	 * @return
	 */
	public List<WareSectorVO> selectSectorList(@Param("store_no") String store_no);
	
	/**
	 * ruleVO, code, name G001(사용중),G002(사용중지)
	 * @return
	 */
	public List<RuleVO> selectMatRuleList();
	
	/**
	 * G003(생산중),G004(생산중단)
	 * @return
	 */
	public List<RuleVO> selectProdRuleList();
	
	/**
	 * 해당 원자재가 저장된 창고 리스트 출력
	 * @param mat_prod_no
	 * @return
	 */
	public List<OuterStoreVO> outerStoreList(@Param("mat_no") String mat_no);
	
	/**
	 * 해당 원자재가 저장되어있으면서 창고를 선택하면 sector list 출력 
	 * @param outStoreVO
	 * @return
	 */
	public List<OuterStoreVO> outerSectorList(OuterStoreVO outStoreVO);
	
	/**
	 * 해당 상품이 저장된 창고 리스트 출력
	 * @param prod_no
	 * @return
	 */
	public List<OuterStoreVO> outerPStroeList(@Param("prod_no") String prod_no);
	
	/**
	 * 해당 상품이 저장되어있으면서 창고를 선택하면 sector list 출력 
	 * @param outStoreVO
	 * @return
	 */
	public List<OuterStoreVO> outerPSectorList(OuterStoreVO outStoreVO);
}
