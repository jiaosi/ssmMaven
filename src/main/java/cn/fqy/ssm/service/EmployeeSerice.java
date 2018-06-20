package cn.fqy.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fqy.ssm.bean.Employee;
import cn.fqy.ssm.dao.EmployeeMapper;

/**
 * 员工业务层
 * @author acer
 *
 */
@Service
public class EmployeeSerice {
	@Autowired
	private EmployeeMapper employeeMapper;
	/**
	 * 查询所以员工
	 * @return
	 */
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}
	
}
