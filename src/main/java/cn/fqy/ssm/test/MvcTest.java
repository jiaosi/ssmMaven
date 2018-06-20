package cn.fqy.ssm.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import cn.fqy.ssm.bean.Employee;

import com.github.pagehelper.PageInfo;

/**
 * mvc的预先测试，没有直接在jsp页面进行
 * @author acer
 * 多添加一个springmvc的配置文件
 * spring4测试时需要servlet3.0的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//这个需要添加注释进行注入。为springmvc的ioc
	@Autowired
	private WebApplicationContext context;
	
	//虚拟mvc
	private MockMvc mockMvc;
	
	@Before
	public void initMockMvc(){
		mockMvc =  MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception{
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.
				get("/emps").param("pn", "5")).andReturn();
		MockHttpServletRequest mockRequest = mvcResult.getRequest();
		PageInfo pageInfo = (PageInfo) mockRequest.getAttribute("pageInfo");
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页数："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		
		System.out.println("在页面展示需要连续展示的页码");
		int[] nums = pageInfo.getNavigatepageNums();
		for(int j : nums){
			System.out.print(" "+j);
		}
		
		//获取员工数据
		List<Employee> list = pageInfo.getList();
		for(Employee employee : list){
			System.out.println(employee.getEmpName());
		}
	}
	
	
}
