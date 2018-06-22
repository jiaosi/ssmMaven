package cn.fqy.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fqy.ssm.bean.Department;
import cn.fqy.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	/**
	 * 查询所有部门
	 * @return
	 */
	public List<Department> getDepts() {
		
		return departmentMapper.selectByExample(null);
	}

}
