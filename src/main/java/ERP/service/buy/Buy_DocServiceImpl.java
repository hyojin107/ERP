package ERP.service.buy;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.buy.IBuy_DocDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_Doc_MatVO;
import vo.buy.Buy_DocumentVO;

@Service
public class Buy_DocServiceImpl implements IBuy_DocService {

	@Inject
	IBuy_DocDAO dao;
	
	@Override
	public ServiceResult createBuyDoc(Buy_DocumentVO vo) {
		int result = dao.insertBuyDoc(vo);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public List<Buy_DocumentVO> readBuyDocList(PagingVO<Buy_DocumentVO> pagingVO) {
		List<Buy_DocumentVO> result = dao.selectBuyDocList(pagingVO);
		for(Buy_DocumentVO doc : result) {
			for(Buy_Doc_MatVO mat : doc.getMatList()) {
				if("Q001".equals(mat.getDoc_status())) {
					mat.setDoc_status("진행중");
				}else if("Q002".equals(mat.getDoc_status())) {
					mat.setDoc_status("발주완료");
				}else if("Q003".equals(mat.getDoc_status())) {
					mat.setDoc_status("요청 취소");
				}else if("Q004".equals(mat.getDoc_status())) {
					mat.setDoc_status("발주 취소");
				}
			}
		}
		return result;
	}

	@Override
	public int readBuyDocCount(PagingVO<Buy_DocumentVO> pagingVO) {
		return dao.selectBuyDocCount(pagingVO);
	}

	@Override
	public ServiceResult deleteBuyDoc(Buy_DocumentVO docVO) {
		int result = dao.deleteDoc(docVO);
		System.out.println("결과: "+result);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}
	
}

