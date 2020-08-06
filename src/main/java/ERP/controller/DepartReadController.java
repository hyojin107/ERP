package ERP.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import ERP.dao.emp.IEmpListDAO;
import vo.emp.DepartmentVO;

@RestController
@RequestMapping(value = "/emp/salary",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class DepartReadController {
	
//	@Inject
//	IEmpListDAO empListDAO;
	
	@GetMapping("TeamList")
	public List<DepartmentVO> getTeamList(
			@RequestParam(required = false) String dep_no2){
//		List<DepartmentVO> teamList = empListDAO.selectTeamList(dep_no2);
//		return teamList;
		return null;
	}
	
	@GetMapping("departmentList")
	public List<Map<String, Object>> getdepartmentList(HttpServletRequest req,
			@RequestParam(required = false) ObjectMapper mapper,
			HttpServletResponse resp) throws Exception{
//	List<Map<String, Object>> departmentList  = empListDAO.selectDepartmentList();
//	return departmentList;
		return null;
	}
	

}
