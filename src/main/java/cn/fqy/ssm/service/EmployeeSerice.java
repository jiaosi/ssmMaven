package cn.fqy.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fqy.ssm.bean.Employee;
import cn.fqy.ssm.bean.EmployeeExample;
import cn.fqy.ssm.bean.EmployeeExample.Criteria;
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
	/**
	 * 保存员工信息
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insert(employee);
	}
	
	/**
	 * 检查用户名是否已存在
	 * @param empName
	 * @return true查到 
	 * 			false没有查到
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		Long count = employeeMapper.countByExample(example);
		if(count > 0){
			return true;
		}
		return false;
	}
	/**
	 * 根据id查询员工信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		
		return employeeMapper.selectByPrimaryKey(id);
	}
	/**
	 * 修改员工信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		//没有更新员工名，所以用selective
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * 删除
	 * @param empId
	 */
	public void deleEmpById(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}
	/**
	 * 批量删除员工
	 * @param listIds
	 */
	public void deleEmpBatch(List<Integer> listIds) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//from user where empId in(listIds);按删除的id的集合删除
		criteria.andEmpIdIn(listIds);
		employeeMapper.deleteByExample(example);
	}
	
}
