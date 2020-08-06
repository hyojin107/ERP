package ERP.dao.wareHouse;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.wareHouse.BOMVO;
import vo.wareHouse.MaterialVO;
import vo.wareHouse.ProdVO;

@Repository
public interface IProdDAO {
	// 상품관리
	
	/**
	 * 상품등록
	 * @param prodVO
	 * @return
	 */
	public int insertProd(ProdVO prodVO);
	
	/**
	 * 상품 상세보기
	 * @param prod_code
	 * @return
	 */
	public ProdVO readProd(String prod_no);
	
	/**
	 * 검색 조건에 맞는 상품의 갯수
	 * @param pagingVO
	 * @return
	 */
	public int readProdCount(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 검색 조건에 맞는 상품 목록
	 * @param pagingVO
	 * @return
	 */
	public List<ProdVO> readProdList(PagingVO<ProdVO> pagingVO);
	
	//------------------------------------------------- 상품정보 수정 & BOM 정보 수정
	
	/**
	 * 상품 정보 수정
	 * @param prodVO
	 * @return
	 */
	public int modifyProd(ProdVO prodVO);
	
	/**
	 * 상품 정보 수정시 bom 수정 동시 진행
	 * @param bomVO
	 * @return
	 */
	public int modifyBOM(BOMVO bomVO);
	
	//---------------------------------------------------원자재 검색
	/**
	 * BOM등록시 사용하는 원자재 수
	 * @param pagingVO
	 * @return
	 */
	public int searchMatCnt(PagingVO<MaterialVO> pagingVO);
	
	/**
	 * BOM등록시 사용하는 원자재 검색 결과
	 * @param pagingVO
	 * @return
	 */
	public List<MaterialVO> searchMatList(PagingVO<MaterialVO> pagingVO);

	/**
	 * autocomplate 원자재 이름 출력 
	 * @return
	 */
	public List<String> serarchMatNameList();
	
	//---------------------------------------------bom 정보 출력
	public List<BOMVO> readBomList(String prod_no);
}
