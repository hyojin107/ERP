package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IDisuseDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;
import vo.product.DisStuffVO;
import vo.product.PdReportVO;
import vo.product.StuffVO;
import vo.wareHouse.Mat_DisUseVO;
import vo.wareHouse.Prod_DisUseVO;

@Service
public class DisuseServiceImpl implements IDisuseService{

	@Inject
	IDisuseDAO dao;
	


	@Override
	public int readMatDisUseCnt(PagingVO<Mat_DisUseVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int readProdDisUseCnt(PagingVO<Prod_DisUseVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
	@Override
	public List<StuffVO> readMatDisUseList(StuffVO detailSearch) {
		
		return dao.readMatDisUseList(detailSearch);
	}
	

	@Override
	public List<StuffVO> readProdDisUseList(StuffVO detailSearch) {
		// TODO Auto-generated method stub
		return dao.readProdDisUseList(detailSearch);
	}

	@Override
	public Mat_DisUseVO readMatDisUse(int board_no) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

	@Override
	public Prod_DisUseVO readProdDisUse(int board_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int readBuyerReturnCnt(PagingVO<BuyerReturnVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BuyerReturnVO> readBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BuyerReturnVO readBuyerReturn(int board_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult prodReDisUse(BuyerReturnVO buyReturnVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int pdReportCnt(PagingVO<PdReportVO> pagingVO) {
		
		return dao.pdReportCnt(pagingVO);
	}

	@Override
	public List<PdReportVO> readPdReportList(PagingVO<PdReportVO> pagingVO) {
		
		return dao.readPdReportList(pagingVO);
	}

	@Override
	public PdReportVO readPdReport(int board_no) {
		// TODO Auto-generated method stub
		return dao.readPdReport(board_no);
	}

	@Override
	public ServiceResult prodMFDisUse(PdReportVO pdReportVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult insertStuffDisUse(DisStuffVO disstuffvo) {
		  dao.insertDisUse(disstuffvo);
		  
		  
		return null;
	}



}
