package cn.fqy.ssm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fqy.ssm.bean.Department;
import cn.fqy.ssm.bean.Msg;
import cn.fqy.ssm.service.DepartmentService;

/**
 * 部门相关操作
 * @author acer
 *
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 查询所有部门
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		List<Department> list = departmentService.getDepts();
		
		return Msg.success().add("list", list);
	}
}
