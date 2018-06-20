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
	<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
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
    		<table class="table table-hover">
    			<tr>
    				<th>#</th>
    				<th>lastname</th>
    				<th>email</th>
    				<th>gender</th>
    				<th>deptName</th>
    				<th>操作</th>
    			</tr>
    			<c:forEach items="${pageInfo.list }" var="list">
    				<tr>
	    				<th>${list.empId }</th>
	    				<th>${list.empName }</th>
	    				<th>${list.email }</th>
	    				<th>${list.gender=="f"?"女":"男" }</th>
	    				<th>${list.department.deptName }</th>
	    				<th>
	    					<button type="button" class="btn btn-info btn-sm">
	    						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
	    					</button>
	    					<button type="button" class="btn btn-danger btn-sm">
	    						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	    					</button>
	    				</th>
    				</tr>
    			</c:forEach>
    			
    		</table>
    	</div>
    	
    	<!-- 页码显示 -->
    	<div class="row">
    		<div class="col-md-6">
    			当前页数：${pageInfo.pageNum }，总记录数：${pageInfo.total }，总页数：${pageInfo.pages }
    		</div>
    		<div class="col-md-6">
    			<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<c:choose>
				  		<c:when test="${pageInfo.pageNum==1 }">
				  			<li class="disabled"><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				    		<li class="disabled">
					      		<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        		<span aria-hidden="true">&laquo;</span>
					      		</a>
				    		</li>
				  		</c:when>
				  		<c:otherwise>
					  		<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						    <li>
						      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
				  		</c:otherwise>
				  	</c:choose>
				  	
				    <c:forEach items="${pageInfo.navigatepageNums }" var="pnn">
				    	<c:if test="${pnn==pageInfo.pageNum }">
				    		<li class="active"><a href="${APP_PATH }/emps?pn=${pnn}">${pnn }</a></li>
				    	</c:if>
				    	<c:if test="${pnn!=pageInfo.pageNum }">
				    		<li><a href="${APP_PATH }/emps?pn=${pnn}">${pnn }</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:choose>
				    	<c:when test="${pageInfo.pageNum==pageInfo.pages }">
				    		<li class="disabled">
						      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
				    		</li>
						    <li class="disabled"><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
						</c:when>
						<c:otherwise>
				    		<li>
						      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
		    				</li>
		    				<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
				    	</c:otherwise>
				    </c:choose>
				    
				  </ul>
				</nav>
    		</div>
    	</div>
    </div>
  </body>
</html>
