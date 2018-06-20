<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 定义c标签 -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!-- 定义服务器路径 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'list.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.2.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
  <body>
    <div class="container">
    	<!-- 标题 -->
    	<div class="row">
    		<div class="col-md-12">
    			<h1>SSM-CRUD</h1>
    		</div>
    	</div>
    	
    	<!-- 按钮 -->
    	<div class="row">
    		<div class="col-md-4 col-md-offset-8">
    			<button type="button" class="btn btn-primary">新增</button>
    			<button type="button" class="btn btn-danger">删除</button>
    		</div>
    	</div>
    	
    	<!-- 查询出的员工信息表格显示 -->
    	<div class="row">
    		<table class="table table-hover" id="emp_table">
    			<thead>
	    			<tr>
	    				<th>#</th>
	    				<th>lastname</th>
	    				<th>email</th>
	    				<th>gender</th>
	    				<th>deptName</th>
	    				<th>操作</th>
	    			</tr>
    			</thead>
    			<tbody>
    				
    			</tbody>
    			
    		</table>
    	</div>
    	
    	<!-- 页码显示 -->
    	<div class="row">
    		<div class="col-md-6" id="page_info_area">
    			
    		</div>
    		
    		<div class="col-md-6" id="page_nav_area">
    			
    		</div>
    	</div>
    </div>
    
    
    <script type="text/javascript">
    	$(function(){
    		//指定显示第一页为首页显示
    		to_page(1);
    	});
    	
    	//封装ajax
    	function to_page(pn){
    		$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"get",
				success:function(result){
					//console.log(result);
					//1.显示员工数据于表格
					build_emp_table(result);
					//2.显示总页数，总记录数等信息
					build_page_info(result);
					//3.页码导航信息
					build_page_nav(result);
				}
			});
    	}
		
		//解析员工信息，从响应的json   
		function build_emp_table(result){
			$("#emp_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var emailTd = $("<td></td>").append(item.email);
				var genderTd = $("<td></td>").append(item.gender);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
				var deleBtn = $("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
				var btnTb = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
				
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(emailTd).append(genderTd).append(deptNameTd).append(btnTb).appendTo("#emp_table tbody");
			});
		}
		//左边总页数，总记录数等信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前页数："+result.extend.pageInfo.pageNum+"，总记录数："+result.extend.pageInfo.total+"，总页数："+result.extend.pageInfo.pages);
		}
		
		//页码导航信息
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			//前一页和后一页是否可以点击
			if(!result.extend.pageInfo.hasPreviousPage){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			if(!result.extend.pageInfo.hasNextPage){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
			}
			
			var pageUl = $("<ul></ul>").addClass("pagination").append(firstPageLi).append(prePageLi);
			//循环遍历页码
			var navPageNums = result.extend.pageInfo.navigatepageNums;
			$.each(navPageNums, function(index, item){
				var numPageLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
				if(result.extend.pageInfo.pageNum == item){
					numPageLi.addClass("active");
				}
				numPageLi.click(function(){
					to_page(item);
				});
				pageUl.append(numPageLi);
			});
			pageUl.append(nextPageLi).append(lastPageLi);
			
			$("<nav></nav>").append(pageUl).appendTo("#page_nav_area");
		}
    </script>
  </body>
</html>
