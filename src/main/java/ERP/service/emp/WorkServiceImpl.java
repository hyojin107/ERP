package ERP.service.emp;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import ERP.dao.emp.IWorkDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.WorkVO;

@Service
public class WorkServiceImpl implements IWorkService {

	@Inject
	 private IWorkDAO wokDAO;
//	@Inject 
//	private IEmployeeDAO empDAO;
	
	
	@Inject
	WebApplicationContext container;
	
	// 등록
	@Override
	public ServiceResult createWork(WorkVO vo) {
		ServiceResult result = wokDAO.insertWork(vo)>0?ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	
	//수정
	@Override
	public ServiceResult modifyWork(WorkVO vo) {
		ServiceResult result = wokDAO.updateWork(vo)>0? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	// 근태 리스트 
	@Override
	public List<WorkVO> readWorkList(PagingVO<WorkVO> pagingVO) {
		
		List<WorkVO> workEmp =  wokDAO.selectWorkList(pagingVO); // 사원리스트 정보를 가져오는거 
		
		// workEMP를 FOR을 돌려서 비교하고 결과 값을 담아주다. 
		for(int i = 0; i <workEmp.size(); i++) {
				// 지각을 구분 하거
				// 출근시간이 9시보다 크면 지각 --> y : n
				// substring 으로 시분초를 짤라와서 0 9:00:00 비교
				String workTime = workEmp.get(i).getWork_time(); // i의 출근시간을 가져온다.2020-07-22 09:00:00
				System.out.println(workTime);
				// workEMP로 비교를 해야 함 
//				Date Tdate = null;
				if(workTime == null) continue;
				
			  	 try {
			  		SimpleDateFormat date = new SimpleDateFormat("HH:mm:ss");
			  		SimpleDateFormat date3 = new SimpleDateFormat("HHmmss");
			  		SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
//			  		Tdate = date.format(workTime); // 09:00:00
//			  		Date aa = new Date(workTime);
			  		Date bb = date.parse("08:59:00"); // 출근시간 기준
//			  		System.out.println("출근기준 8시59분=="+bb);
			  	
			  		Date aa = date2.parse(workTime); // 출근시간  workTime 형식을  date로 바꿔준다. 
//			  		System.out.println("출근시간=="+aa);
			  		
			  		int a = Integer.parseInt(date3.format(aa));
//			  		System.out.println("출근시간기준 a =="+a);
			  		int b =Integer.parseInt(date3.format(bb));
//			  		System.out.println("출근시간b =="+b);
			  		
			  		
			  		if(a > b) {
			  			workEmp.get(i).setLateTime("지각");
			  		}
			  		
			  		
				} catch (ParseException e) {
					e.printStackTrace();
				}
			 	
			  		 
			 	// 연장시간을 계산 
				//  퇴근시간  -  18:00:00 =  연장시간 
				// 시간만 짤라서 가져와서 
				// vo에 담아주는거 
			  	 
				String lateTime = workEmp.get(i).getOffwork_time();//퇴근시간 가져오는거 
			
				
				if(lateTime == null) continue;
				
				try {
					
					SimpleDateFormat dataFormat = new SimpleDateFormat("HH:mm:ss");
					SimpleDateFormat dataForma = new SimpleDateFormat("HHmmss");
					SimpleDateFormat dataFor = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
					
					Date CEndTime   = dataFormat.parse("20:00:00"); // 연장시간 기준점
					Date REndTime  = dataFor.parse(lateTime); // 퇴근시간 형식 바꿔주는거 
					
					int ff = Integer.parseInt(dataForma.format(CEndTime)); // 기준시간
//					System.out.println("기준시간"+ff);
					
					int endatime = Integer.parseInt(dataForma.format(REndTime)); // 퇴근시간
//					System.out.println("퇴근시간"+endatime);
					
					int result = endatime - ff; //  23시 - 20시 
//					System.out.println("연장시간 결과 값"+result);
					 if( result > 0) { //  연장시간이 있으면 
						 int hours  = (int) (result/10000);
						 workEmp.get(i).setExtendsTime(hours);
					 }else {
						 workEmp.get(i).setExtendsTime(null);
					 }
					 
				} catch (ParseException e) {
					e.printStackTrace();
				}
		}
		return workEmp; 
	}

	// 사원 1명 클릭시 --> 모달창으로 보여지기
	@Override
	public WorkVO readWork(String emp_no) {
		WorkVO work = wokDAO.selectWork(emp_no);
		if(work == null) {
			throw new DataNotFoundException(emp_no+"에 해당하는 정보가 없습니다.");
		}
		return work;
	}

	// 월간 근태 리스트 
	@Override
	public int readWorkCount(PagingVO<WorkVO> pagingVO) {
		return wokDAO.selectWorkCount(pagingVO);
	}
	
	@Override
	public List<WorkVO> readMonthList(PagingVO<WorkVO> pagingVO) {
		return wokDAO.selectMonthList(pagingVO);
	}


}
