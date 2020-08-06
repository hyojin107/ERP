package ERP.service.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.account.IChitDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.account.ChitVO;

@Service
public class ChitServiceImpl implements IChitService{
	@Inject
	IChitDAO dao;

	@Override
	public ServiceResult createChit(ChitVO vo) {
		return dao.insertChit(vo)>0?ServiceResult.OK:ServiceResult.FAIL;
	}

	@Override
	public int readChitCount(PagingVO<ChitVO> pagingVO) {
		return dao.selectAllChitCount(pagingVO);
	}

	@Override
	public List<ChitVO> readChitList(ChitVO vo) {
		List<ChitVO> list =dao.selectAllChitList(vo); 
//		if(list != null) 
//			for(ChitVO temp : list) {
//				temp = dao.selectChit(temp);
//			}
		
		return list;
	}

	@Override
	public ChitVO readChit(String chit_no) {
		ChitVO vo = new ChitVO();
		vo.setChit_no(chit_no);
		return dao.selectChit(vo);
	}

	@Override
	public ServiceResult modifyChit(ChitVO vo) {
		return dao.updateChit(vo) > 0? ServiceResult.OK:ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeChit(ChitVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

}
