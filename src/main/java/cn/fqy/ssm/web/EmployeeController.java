package cn.fqy.ssm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.fqy.ssm.bean.Employee;
import cn.fqy.ssm.bean.Msg;
import cn.fqy.ssm.service.EmployeeSerice;

/**
 * 员工信息CRUD
 * @author acer
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeSerice employeeService;
	/**
	 * 以json形式返回给页面以对象
	 * @param pn
	 * @return
	 * @ResponseBody：需要导入jackson databind包：将对象转为json
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmps(@RequestParam(value="pn", defaultValue="1")Integer pn){
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		//将查询结果封装到pageInfo中,int参数为连续显示页数
		PageInfo pageInfo = new PageInfo(list, 4);
		//将pageInfo添加到Msg Bean中
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn", defaultValue="1")Integer pn,
			Model model){
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		//将查询结果封装到pageInfo中,int参数为连续显示页数
		PageInfo pageInfo = new PageInfo(list, 4);
		//将结果传到model传到页面
		model.addAttribute("pageInfo",pageInfo);
		
		return "list";
	}
	
}
