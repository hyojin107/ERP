package ERP.dao.wareHouse;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Repository
public interface IMaterialDAO {
	// 원자재 관리
	
	/**
	 * 원자재 입고
	 * @param matVO
	 * @return int
	 */
	public int insertMat(MaterialVO matVO);
	
	/**
	 * 원자재 상세보기
	 * @param mat_code
	 * @return 존재하지 않으면 DataNotFoundException 발생
	 */
	public MaterialVO readMat(String mat_no);
	
	/**
	 * 검색 조건에 맞는 등록 원자재 수
	 * @param pagingVO
	 * @return
	 */
	public int readMatCount(PagingVO<MaterialVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 원자재 목록
	 * @param pagingVO
	 * @return 
	 */
	public List<MaterialVO> readMatList(PagingVO<MaterialVO> pagingVO);
	
	/**
	 * 원자재 정보 수정
	 * @param matVO
	 * @return 존재 하지 않는 원자재라면 DataNotFoundException발생 
	 */
	public int modifyMat(MaterialVO matVO);
	
	/**
	 * 원자재 정보 삭제 > 취급여부를 yes에서 no로 변경 시킨다 
	 * @param matVO
	 * @return
	 */
	public int deleteMat(MaterialVO matVO);
		
}
