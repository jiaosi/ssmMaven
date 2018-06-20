package cn.fqy.ssm.test;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.fqy.ssm.bean.Department;
import cn.fqy.ssm.bean.Employee;
import cn.fqy.ssm.dao.DepartmentMapper;
import cn.fqy.ssm.dao.EmployeeMapper;

/**
 * spring-test测试mybatisCRUD
 * @author acer
 * 1.导入spring-test.jar
 * 2.@ContextConfiguration加载spring配置文件
 * 3.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class TestCRUD {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Test
	public void testCRUD(){
//		System.out.println(departmentMapper);
		
//		//插入数据
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "外宣部"));
		
		//插入员工数据
//		employeeMapper.insertSelective(new Employee(null, "Kim", "f", "kim@qq.com", 1));
		
		//批量插入
		for(int i = 0; i < 100; i++){
			String uid = UUID.randomUUID().toString().substring(0, 5);
			employeeMapper.insertSelective(new Employee(null, uid+i, "f", uid+"@qq.com", 1));
		}
		
		System.out.println("finish batch");
		
	}
	
}
