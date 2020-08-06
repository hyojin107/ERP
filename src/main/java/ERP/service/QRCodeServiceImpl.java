package ERP.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ERP.dao.IQRCodeDAO;
import enums.ServiceResult;
import vo.emp.EmployeeVO;

@Service
public class QRCodeServiceImpl implements IQRCodeService {
	
	@Inject
	IQRCodeDAO dao;
	
	@Transactional
	@Override
	public ServiceResult createWork(EmployeeVO empVO) {
		int result = 0;
		int selectWork = dao.selectWork(empVO);
		if(selectWork > 0) {
			result = dao.updateWork(empVO);	//퇴근 등록
			if(result>0) return ServiceResult.WORKEND;
		}else {
			result = dao.insertWork(empVO);	//출근 등록
		}
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

}
