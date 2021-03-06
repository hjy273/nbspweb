<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<%@ include file="/common/meta.jsp"%>
		<link href="${ctx}/css/base.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx }/js/in-min.js"
			autoload="true"
			core="${config.cdnurl}/cabletech/ui/js/jquery-1.7.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>草稿箱</title>
<script type="text/javascript">
In.add('jqui',{path:'${ctx}/js/jQuery/jqueryui/css/redmond/jquery-ui.custom.css'});
In.add('jquijs',{path:'${ctx}/js/jQuery/jqueryui/jquery-ui.custom.min.js',type:'js',charset:'utf-8',rely:['jqui']});
In.add('jquicn',{path:'${ctx}/js/jQuery/jqueryui/zh/jquery.ui.datepicker-zh-CN.js',type:'js',charset:'utf-8',rely:['jquijs']});
In.add('jresize',{path:'${ctx}/js/jQuery/jresize/jquery.wresize.js',type:'js',charset:'utf-8',rely:['jquicn']});
In.add('jgcss',{path:'${ctx}/js/jQuery/jqgrid/css/ui.jqgrid.css',charset:'utf-8',rely:['jresize']});
In.add('jgjs',{path:'${ctx}/js/jQuery/jqgrid/jquery.jqGrid.min.js',type:'js',charset:'utf-8',rely:['jgcss']});
In.add('jgcn',{path:'${ctx}/js/jQuery/jqgrid/grid.locale-cn.js',type:'js',charset:'utf-8',rely:['jgjs']});
In.add('common',{path:'${ctx}/common/js/common.js',type:'js',charset:'utf-8'});
In.add('wdatejs',{path:'${ctx}/js/WdatePicker/WdatePicker.js',type:'js',charset:'utf-8'});
In.add('workorder_common',{path:'${ctx}/workflow/workorder/js/workorder_common.js',type:'js',charset:'utf-8'});
In.add('layout',{path:'${ctx}/js/jQuery/layout/layout-default-latest.css'});
In.add('layoutjs',{path:'${ctx}/js/jQuery/layout/jquery.layout-latest.min.js',type:'js',charset:'utf-8',rely:['layout']});
	In.ready('jgcn','layoutjs', 'common', 'wdatejs', 'workorder_common', function() {
			setContextPath('${ctx }');
	accordionObj=jQuery("#accordion").accordion({
 		autoHeight:false,header: 'h3',navigation:true,
 		collapsible: true,active:1
	});
		//使用层布局
	  var jqgrid=jQuery("#workordergrid").jqGrid({    
			url: "${ctx}/workflow/workOrderDraftAction!listdata.action",   
			datatype: "json",mtype: 'POST',rownumbers: true,
			colNames:['工单标题','工单号','处理时限','工单类型', '派单人','派单时间','操作'],
			colModel:[
			          {name:'TASK_NAME',id:'TASK_NAME',sortable:false,width:250},
			          {name:'TASK_CODE',id:'TASK_CODE',sortable:false,width:180},
			          {name:'OVERTIME_SET_DIS',id:'OVERTIME_SET_DIS',sortable:false,width:130},
			          {name:'TASK_TYPE_DIS',id:'TASK_TYPE_DIS',sortable:false,width:120},
			          {name:'CREATER_NAME',id:'CREATER_NAME',sortable:false,width:120},
			          {name:'CREATE_DATE_DIS',id:'CREATE_DATE_DIS',sortable:false,width:120},
			          {name:'ID',id:'ID',sortable:false,formatter:OrderActionFmatter,width:80},
			          ],
			          rowNum:15,autowidth:true,rowList:[15,30,50],pager: '#workorderpager',viewrecords: true,hidegrid: false,shrinkToFit : false,fix:true,autoScroll:true, 
			prmNames: {page:"pageNo",rows:"rows", sort: "sidx",order: "sord"},   
			jsonReader: {
	               root:"result" ,                // 数据行（默认为：rows） 
	               page: "pageNo" ,            // 当前页 
	               total: "totalPages" ,    // 总页数 
	               records: "totalCount",     // 总记录数 
	               repeatitems: false
	               }
			  }).navGrid('#workorderpager',{edit:false ,add:false ,del:false,search:false,sortable:false  });
		
	  	jQuery(window).wresize(function(){
			grid_resize(jqgrid);
		});
		grid_resize(jqgrid);
		});
</script>
</head>
<body>
	<form id="searchForm" name="searchForm">
		<div id="header">
			<div class="title_bg">
				<div class="title">当前位置-草稿箱</div>
			</div>
			<div id="accordion">
				<h3>
					<a href="#" id="accord">搜索条件</a>
				</h3>
				<div class="tabcontent">
					<table cellspacing="0" cellpadding="0" border="0" align="center">
						<tr>
							<th>标题：</th>
							<td colspan="3">
								<input class="inputtext" type="text" id="workOrder_taskName" name="taskName" style="width:220px;" maxlength="60" />
							</td>
						</tr>
						<tr>
							<th>工单类型：</th>
							<td>
								<baseinfo:dicselector id="workOrder_taskType" style="width:220px;" name="taskType" columntype="TASK_CODE" type="select" cssClass="inputtext" isQuery="query"></baseinfo:dicselector>
							</td>
							<th>建单日期：</th>
							<td>
								<input id="workOrder_createDateMin" name="createDateMin" type="text" class="Wdate inputtext" style="width: 95px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'workOrder_createDateMax\')}'})" /> 
								至 
								<input id="workOrder_createDateMax" name="createDateMax" type="text" class="Wdate inputtext" style="width: 95px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'workOrder_createDateMin\')}'})" />
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="button" onclick="query();" class="button" value="查询" />
								<baseinfo:expexcel cls="exprotButton"  businessId="workorder_draft_list" name="导出excel"></baseinfo:expexcel>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div id="content" align="center" style="padding-top: 2px">
			<table id="workordergrid"></table>
			<div id="workorderpager"></div>
		</div>
	</form>
</body>
<script type="text/javascript">
//查询
function query() {
	jQuery("#workordergrid").jqGrid().setGridParam({
		postData: {
			taskName:jQuery("#workOrder_taskName").val(),
			taskType:jQuery('select[name="taskType"]').find("option:selected").val(),
			createDateMin:jQuery("#workOrder_createDateMin").val(),
			createDateMax:jQuery("#workOrder_createDateMax").val()
		} 
	}).trigger("reloadGrid");
}
</script>
</html>