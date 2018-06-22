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
  
  <!-- 编辑员工模态框（弹出框） -->
	<div class="modal fade" id="emp_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">编辑员工</h4>
	      </div>
	      <div class="modal-body">
	      <!-- 员工信息表单 -->
	        <form class="form-horizontal" id="emp_update_form">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input name="email" type="email" class="form-control" id="inputEmail_update" placeholder="xxx@xx.com">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <div class="radio">
					  <label>
					    <input type="radio" name="gender" id="emp_gender1" value="m" checked>
					    	男
					  </label>
					  <label>
					    <input type="radio" name="gender" id="emp_gender2" value="f" >
					    	女
					  </label>
				  </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-5">
			      <select class="form-control" name="bId">
				  <!-- 从数据库读取部门id -->
				  
				  </select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_modal_save">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  <!-- 新增员工模态框（弹出框） -->
	<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
	      <!-- 员工信息表单 -->
	        <form class="form-horizontal" id="emp_add_form">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input name="empName" type="text" class="form-control" id="inputEmpName" placeholder="empName">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input name="email" type="email" class="form-control" id="inputEmail" placeholder="xxx@xx.com">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <div class="radio">
					  <label>
					    <input type="radio" name="gender" id="emp_gender1" value="m" checked>
					    	男
					  </label>
					  <label>
					    <input type="radio" name="gender" id="emp_gender2" value="f" >
					    	女
					  </label>
				  </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-5">
			      <select class="form-control" name="bId">
				  <!-- 从数据库读取部门id -->
				  
				  </select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_add_modal_save">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  
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
    			<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
    			<button type="button" class="btn btn-danger" id="emp_dele_selected_btn">删除</button>
    		</div>
    	</div>
    	
    	<!-- 查询出的员工信息表格显示 -->
    	<div class="row">
    		<table class="table table-hover" id="emp_table">
    			<thead>
	    			<tr>
	    				<th><input type="checkbox" id="checkbox_all"/></th>
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
    
    	//定义全局变量总记录数，用于保存员工信息成功后跳转到最后一页，即跳转到totalRecord数字代表的页数
    	var totalRecord;
    	//标识当前页，用以修改后返回
    	var currentPage;
    	
    	
    	//=======================删除员工信息====================================
    	//批量删除
    	$("#emp_dele_selected_btn").click(function(){
    		//选中的所有员工名
    		var deleEmpNames = "";
    		//选中的所有员工的编号
    		var ids = "";
    		$.each($(".checkbox_item:checked"), function(){
    			deleEmpNames += $(this).parents("tr").find("td:eq(2)").text()+"，";
    			ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
    		});
    		//alert(deleEmpNames);
    		deleEmpNames = deleEmpNames.substring(0, deleEmpNames.length - 1);
    		ids = ids.substring(0, ids.length - 1);
    		if(confirm("确认删除："+deleEmpNames+" 吗？")){
    			$.ajax({
    				url:"${APP_PATH}/emp/"+ids,
    				type:"delete", 
    				success:function(result){
    					alert(result.msg);
    					//返回当前页
    					to_page(currentPage);
    				}
    			});
    		}
    	});
    	//复选框：全选
    	$("#checkbox_all").click(function(){
    		//使其下所有复选框同此有相同的checked属性值即可
    		//注意，dom属性用prop获取，attr获取为undefined
    		$(".checkbox_item").prop("checked", $(this).prop("checked"));
    	});
    	//当选中所有复选框，第一个也要自动选中
    	$(document).on("click", ".checkbox_item", function(){
    		//选中数量是否等于复选框总共数量
    		var flag = $(".checkbox_item:checked").length == $(".checkbox_item").length;
    		$("#checkbox_all").prop("checked", flag);
    		
    	});
    	$(document).on("click", ".btn-dele", function(){
    		//获得删除按钮对应的员工姓名
    		//查找父类元素的下的第二个td框
    		//alert($(this).parents("tr").find("td:eq(1)").text());
    		var empName = $(this).parents("tr").find("td:eq(2)").text();
    		var id = $(this).attr("empId_dele");
    		if(confirm("确认删除 "+empName+" 吗？")){
    			//确认删除，发起ajax请求
    			$.ajax({
    				url:"${APP_PATH}/emp/"+id,
    				type:"delete",
    				success:function(result){
    					alert(result.msg);
    					to_page(currentPage);
    				}
    			});
    		}
    	});
    	
    	
    	//=======================员工修改操作====================================
    	//更新按钮操作
    	$("#emp_update_modal_save").click(function(){
    		//1.校验邮箱格式
    		var email = $("#inputEmail_update").val();
    		var regexEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    		if(!regexEmail.test(email)){
    			//alert("邮箱格式不正确");
    			/* $("#inputEmail").parent().addClass("has-error");
    			$("#inputEmail").next("span").text("邮箱格式不正确"); */
    			show_validate_msg("#inputEmail_update", "has-error", "邮箱格式不正确");
    			return false;
    		}else{
    			/* $("#inputEmail").parent().addClass("has-success");
    			$("#inputEmail").next("span").text(""); */
    			show_validate_msg("#inputEmail_update", "has-success", "");
    		}
    		
    		//获取员工id
    		var id = $(this).attr("empId_edit");
    		
    		//2.发送ajax请求，执行更新操作
    		$.ajax({
    			url:"${APP_PATH}/emp/"+id,
    			type:"put",
    			data:$("#emp_update_form").serialize(),
    			success:function(result){
					alert(result.msg);		
    			}
    		});
    		
    		//3.关闭模态框
    		$("#emp_update_modal").modal("hide");
    		
    		//4.返回到当前修改查询页
    		to_page(currentPage);
    	});
    	
    	function getEmp(id){
    		$.ajax({
    			url:"${APP_PATH}/getEmp/"+id,
    			type:"get",
    			success:function(result){
    				//console.log(result);
    				var empData = result.extend.emp;
    				$("#empName_update_static").text(empData.empName);
    				$("#inputEmail_update").val(empData.email);
    				$("#emp_update_modal input[name=gender]").val([empData.gender]);
    				
    			}
    		});
    	}
    	//为document中所有btn-edit类添加点击事件
    	$(document).on("click", ".btn-edit", function(){
    		//模态框中的表单刚开始为清空状态
    		//$("#emp_add_modal form")[0].reset();
    		initForm("#emp_update_modal form");
    		
    		//查询需要编辑的员工信息，并显示
    		var id = $(this).attr("empId_edit");
    		getEmp(id);
    		
    		//把员工id添加到更新按钮作为其自定义属性
    		$("#emp_update_modal_save").attr("empId_edit", id);
    		
    		//ajax请求部门信息在下拉列表中显示
    		$.ajax({
    			url:"${APP_PATH}/depts",
    			type:"get",
    			success:function(result){
    				//console.log(result);
    				//{"code":100,"msg":"处理成功！","extend":{"list":[{"deptId":1,"deptName":"编辑部"},
    				//{"deptId":2,"deptName":"开发部"},{"deptId":3,"deptName":"外宣部"}]}}
    				//将以上json数据转到下拉列表
    				$("#emp_update_modal select").empty();
    				$.each(result.extend.list, function(index, list){
    					var opt = $("<option></option>").append(list.deptName).attr("value", list.deptId);
    					opt.appendTo("#emp_update_modal select");
    				});
    				
    			}
    		});
    	
    		//弹出modal
    		$("#emp_update_modal").modal({
    			backdrop:"static"
    		});
    	});
    	
    	
    	//=======================ajax验证用户名是否已存在===========================
    	//当输入框文本改变
    	$("#inputEmpName").change(function(){
    		var empName = this.value;
    		$.ajax({
    			url:"${APP_PATH}/checkuser", 
    			data:"empName="+empName,
    			type:"POST",
    			success:function(result){
    				if(result.code == 200){
    					//查到，即重复
    					show_validate_msg("#inputEmpName", "has-error", result.extend.validateEmpNameMsg);
    					//给保存按钮添加自定义是否ajax失败属性，后续以此判断为不可点击保存按钮
    					$("#emp_add_modal_save").attr("ajax-status","fail");
    				}else{
    					//可用员工名
    					show_validate_msg("#inputEmpName", "has-success", "员工名可用");
    					$("#emp_add_modal_save").attr("ajax-status","success");
    				}
    			}
    		});
    	});
    	
    
    	//=======================保存员工信息=====================================
    	//格式验证信息
    	function show_validate_msg(ele, clazz, text){
    		//清楚之前遗留的样式
    		$(ele).parent().removeClass("has-success has-error");
    		$(ele).next("span").text("");
    		$(ele).parent().addClass(clazz);
    		$(ele).next("span").text(text);
    	}
    	//校验输入员工格式
    	function emp_add_validate(){
    		
    		//1.校验员工名
    		var empName = $("#inputEmpName").val();
    		var regexName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    		if(!regexName.test(empName)){
    			//alert("名字为6-16位英文数字组合或为2-5个汉字");
    			show_validate_msg("#inputEmpName", "has-error", "名字为6-16位英文数字组合或为2-5个汉字");
    			return false;
    		}else{
    			show_validate_msg("#inputEmpName", "has-success", "");
    		}
    		
    		//2.校验邮箱格式
    		var email = $("#inputEmail").val();
    		var regexEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    		if(!regexEmail.test(email)){
    			//alert("邮箱格式不正确");
    			/* $("#inputEmail").parent().addClass("has-error");
    			$("#inputEmail").next("span").text("邮箱格式不正确"); */
    			show_validate_msg("#inputEmail", "has-error", "邮箱格式不正确");
    			return false;
    		}else{
    			/* $("#inputEmail").parent().addClass("has-success");
    			$("#inputEmail").next("span").text(""); */
    			show_validate_msg("#inputEmail", "has-success", "");
    		}
    		
    		return true;
    	}
    	//===================点击保存===========================================
    	$("#emp_add_modal_save").click(function(){
    	
    		//保存之前进行格式校验
    		if(!emp_add_validate()){
    			return false;
    		} 
    		
    		//判断用户名是否存在的保存按钮是否可用的后续是否执行ajax
    		if($("#emp_add_modal_save").attr("ajax-status")=="fail"){
    			return false;
    		}
    		
    		//alert($("#emp_add_form").serialize());
    		$.ajax({
    			url:"${APP_PATH}/emp",
    			type:"POST", 
    			//将表单数据序列化为提交格式
    			data:$("#emp_add_form").serialize(),
    			success:function(result){
					//根据服务器传回的状态码，给出是否保存成功的提示
					if(result.code == 200){
						//失败
						//console.log(result);
						//在相应的提示区添加错误信息
						/* alert(result.extend.errors.email);
						alert(result.extend.errors.empName); */
						//如果为空的话会显示undefined
						if(undefined != result.extend.errors.empName){
							show_validate_msg("#inputEmpName", "has-error", result.extend.errors.empName);
						}
						if(undefined != result.extend.errors.email){
							show_validate_msg("#inputEmail", "has-error", result.extend.errors.email);
						}
					}else{
						//成功
						//输出成功信息
						alert(result.msg);
	    				/*
	    				 * 保存完毕应当
	    				 * 1.关闭模态框
	    				 * 2.显示最后一页新增的数据
	    				 */
	    				 //关闭模态窗
	    				$('#emp_add_modal').modal('hide');
	    				//显示最后一页新增的数据，当参数大于最后一页会自动解析到最后一页
	    				to_page(totalRecord);
					}
    			}
    		});
    	});
    
    	
    	//========================新增员工点击btn弹出modal=============================
    	//初始化表单，使其样式及文字都为初始状态
    	function initForm(ele){
    		$(ele)[0].reset();
    		$(ele).find("*").removeClass("has-success has-error");
    		$(ele).find(".help-block").text("");
    	}
    	$("#emp_add_modal_btn").click(function(){
    		
    		//模态框中的表单刚开始为清空状态
    		//$("#emp_add_modal form")[0].reset();
    		initForm("#emp_add_modal form");
    		
    		//ajax请求部门信息在下拉列表中显示
    		$.ajax({
    			url:"${APP_PATH}/depts",
    			type:"get",
    			success:function(result){
    				//console.log(result);
    				//{"code":100,"msg":"处理成功！","extend":{"list":[{"deptId":1,"deptName":"编辑部"},
    				//{"deptId":2,"deptName":"开发部"},{"deptId":3,"deptName":"外宣部"}]}}
    				//将以上json数据转到下拉列表
    				$("#emp_add_modal select").empty();
    				$.each(result.extend.list, function(index, list){
    					var opt = $("<option></option>").append(list.deptName).attr("value", list.deptId);
    					opt.appendTo("#emp_add_modal select");
    				});
    				
    			}
    		});
    	
    		//弹出modal
    		$("#emp_add_modal").modal({
    			backdrop:"static"
    		});
    	});
    
    //===============分页===================
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
				//复选框
				var empCheckbox = $("<td><input type='checkbox' class='checkbox_item' /></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var emailTd = $("<td></td>").append(item.email);
				var genderTd = $("<td></td>").append(item.gender=="f"?"女":"男");
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm btn-edit").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
				//为编辑按钮添加自定义标识员工id属性，以便用以查询
				editBtn.attr("empId_edit", item.empId);
				var deleBtn = $("<button></button>").addClass("btn btn-danger btn-sm btn-dele").append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
				//为删除按钮添加自定义标识员工id属性，以便用以查询
				deleBtn.attr("empId_dele", item.empId);
				var btnTb = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
				
				$("<tr></tr>").append(empCheckbox).append(empIdTd).append(empNameTd).append(emailTd).append(genderTd).append(deptNameTd).append(btnTb).appendTo("#emp_table tbody");
			});
		}
		//左边总页数，总记录数等信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前页数："+result.extend.pageInfo.pageNum+"，总记录数："+result.extend.pageInfo.total+"，总页数："+result.extend.pageInfo.pages);
			//设置全局变量totalRecord的值
			totalRecord = result.extend.pageInfo.total;
			//设置当前页数，用以后续编辑信息用
			currentPage = result.extend.pageInfo.pageNum;
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
