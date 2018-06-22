package cn.fqy.ssm.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	 * 单个删除和多个删除合并的方法
	 * @param empId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}", method = RequestMethod.DELETE)
	public Msg deleEmpById(@PathVariable String empId){
		
		if(empId.contains("-")){
			//批量删除
			String[] ids = empId.split("-");
			List<Integer> listIds = new ArrayList<Integer>();
			for(String id : ids){
				listIds.add(Integer.parseInt(id));
			}
			employeeService.deleEmpBatch(listIds);
		}else{
			//单个删除
			Integer int_empId = Integer.parseInt(empId);
			employeeService.deleEmpById(int_empId);
		}
		
		return Msg.success();
	}
	
	/**
	 * 修改员工信息
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}", method = RequestMethod.PUT)
	public Msg updateEmp(Employee employee){
		
		employeeService.updateEmp(employee);
		
		return Msg.success();
	}
	
	/**
	 * 根据id查询员工信息
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getEmp/{id}", method=RequestMethod.GET)
	public Msg getEmp(@PathVariable Integer id){
		
		Employee employee = employeeService.getEmp(id);
		
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * ajax检查用户名是否已存在
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam(value="empName") String empName){
		//用户名正则表达式
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)){
			return Msg.fail().add("validateEmpNameMsg", "名字为6-16位英文数字组合或为2-5个汉字");
		}
		boolean b = employeeService.checkUser(empName);
		if(b){
			//查到
			return Msg.fail().add("validateEmpNameMsg", "员工名重复不可用");
		}else{
			//没有查到
			return Msg.success();
		}
	}
	
	
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
	
	/**
	 * 保存员工信息
	 * 限定请求方式
	 * @Valid：指定校验的bean
	 * BindingResult为错误信息list结果集
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if(result.hasErrors()){
			//存在校验错误
			//新建map存放错误信息
			Map<String, String> errorMap = new HashMap<String, String>();
			//遍历错误结果集
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError error : fieldErrors){
				//错误的字段名
				String fieldName = error.getField();
				//错误字段信息
				String errorMsg = error.getDefaultMessage();
				//将错误信息添加到map中
				errorMap.put(fieldName, errorMsg);
			}
			
			return Msg.fail().add("errors", errorMap);
		}else{
			//校验通过
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
}
