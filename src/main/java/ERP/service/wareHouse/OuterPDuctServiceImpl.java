package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ERP.dao.wareHouse.IOuterDao;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.wareHouse.Mat_MF_OutVO;
import vo.wareHouse.PDuct_List_VO;
import vo.wareHouse.PDuct_OR_VO;

@Service
public class OuterPDuctServiceImpl implements IOuterPDuctService {

	@Inject
	IOuterDao outerDao;
	
	@Transactional
	@Override
	public ServiceResult insertPDuctOR(PDuct_OR_VO pd_OrVO) {
		ServiceResult result=null;
		
		// update 확인용 변수
		int updatematStock = 0; 
		int updatematSector = 0;
		
		//----------------- 생산의뢰서 등록 ,생산의뢰서 물품 목록 insert
		if(pd_OrVO.getPductList()!=null) {
			int pductListPK = outerDao.selectPductPK();  // pductlist pk 생성 , pduct_no
			int pductsize = pd_OrVO.getPductList().size(); //pd_or_vo에 있는 pductlist길이 저장
			if(pductsize>0) { 
				//--------------- 생산물품목록번호 pk주입
				int pductOrPK = outerDao.selectPductOrPK(); // 생산의뢰서 pk 생성
				for(int i=0; i<pductsize; i++) {
					PDuct_List_VO pductListVO = pd_OrVO.getPductList().get(i);
					pductListVO.setPduct_no(pductListPK);
					pd_OrVO.getPductList().get(i).setPduct_no(pductListPK);// pductList에 상품을 저장할 때마다 pk가 1씩 증가 됨
					for(Mat_MF_OutVO mfVO : pductListVO.getMatOutList()) {
						mfVO.setPduct_no(pductListPK);
						mfVO.setPorder_no(pductOrPK);
					}
					pductListPK++;
				}
				
				pd_OrVO.setPorder_no(pductOrPK); // pduct_or pk set 
				int por_result = outerDao.insertPDuctOR(pd_OrVO); //생산의뢰서 insert
				
				if(por_result>0) {
					//----------- 원자재 생산출고 PK 주입
					int mfoutpk = outerDao.selectMatMfPK(); // mat_mf_out pk : mf_no 생성 
					for(PDuct_List_VO pd_listVO : pd_OrVO.getPductList()) {
						if(pd_listVO.getMatOutList()!=null && pd_listVO.getMatOutList().size()>0) {
							// 원자재 갯수 만큼 원자재 생산 출고에 pk를 set 시킨다. 
							for(Mat_MF_OutVO mfout : pd_listVO.getMatOutList()) {
								mfout.setMf_no(mfoutpk++); // mat_mf_out pk 증가 
							}
						}						
						pd_listVO.setPorder_no(pductOrPK); // list_vo 에 있는 porder_no에 위에서 만들어준 pductor의 pk를 넣어준다.			
						
						// pduct_or 의 pductlist 만큼 반복문 돌리기 
						//----------- 원자재 생산 출고 insert
						System.out.println("\n\n확인\n"+pd_OrVO+"\n\n\n");
						int mfOut_result = outerDao.insertMatMfOut(pd_listVO);
						System.out.println("\n\ninsertMatMfOut 실행 후\n"+pd_OrVO+"\n\n\n");
						
						// 원자재, 원자재 창고 구역 update
						if(mfOut_result>0){
							for(Mat_MF_OutVO mf : pd_listVO.getMatOutList()) {
								updatematStock = outerDao.updateMatStock(mf);								
								updatematSector = outerDao.updateMatSector(mf);
							}
						}
					}
				}
			}
		}
		System.out.println("\n\n확인\n"+pd_OrVO+"\n\n\n");
		if(updatematStock > 0 && updatematSector > 0) {
			result = ServiceResult.OK; 
		}
		return result;
	}

	@Override
	public int readPDuctORCnt(PagingVO<PDuct_OR_VO> pdOrVO) {
		return outerDao.readPDuctORCnt(pdOrVO);
	}

	@Override
	public List<PDuct_OR_VO> readPDuctORList(PagingVO<PDuct_OR_VO> pagingVO) {
		return outerDao.readPDuctORList(pagingVO);
	}

	@Override
	public PDuct_OR_VO readPDuctOR(int board_no) {
		PDuct_OR_VO pductVO = outerDao.readPDuctOR(board_no);
		if(pductVO==null) {
			throw new DataNotFoundException(board_no+ " 에 해당하는 게시글이 존재 하지 않습니다.");
		}
		return pductVO;
	}

}
