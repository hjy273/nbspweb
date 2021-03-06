<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
			src="${ctx}/js/jQuery/jvalidation/jquery.validate.js"></script>
<script type="text/javascript"
			src="${ctx}/js/jQuery/jvalidation/jquery.validate.cn.js"></script>
<script type="text/javascript"
			src="${ctx}/js/jQuery/jvalidation/messages_cn.js"></script>
<script type="text/javascript"
			src="${ctx}/js/jQuery/jvalidation/additional-methods.min.js"></script>
<script type="text/javascript"
			src="${ctx}/js/jQuery/jvalidation/jquery.validate.ex.js"></script>
<script type="text/javascript"
	src="${ctx}/js/WdatePicker/WdatePicker.js"></script>
<title>处理家庭宽带隐患</title>
<script type="text/javascript">
	jQuery(function() {
		//启用Jquery验证
		jQuery("#patrolinfoForm").validate({
			focusInvalid : false
		});
	});
</script>
</head>
<body>
	<form id="patrolinfoForm" name="patrolinfoForm" method="post"
		action="${ctx }/ah/ahFamilyBandTroubleAction!update.action">
		<div class="title_bg">
			<div id="title" class="title">当前位置-处理家庭宽带隐患</div>
		</div>
		<div class="tabcontent">
			<table border="0" align="center">
				<tr>
					<th>隐患序号：</th>
					<td>${entity.ordernumber }</td>
				</tr>
				<tr>
					<th>隐患位置：</th>
					<td>${entity.position }</td>
				</tr>
				<tr>
					<th>隐患描述：</th>
					<td>${entity.remark }</td>
				</tr>
				<tr>
					<th>隐患设备类型：</th>
					<td>${entity.deviceType }</td>
				</tr>
				<tr>
					<th>预计整治完成时间：</th>
					<td><fmt:formatDate value="${entity.expectEndTime }"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
				</tr>
				<tr>
					<th>处理完成时间:</th>
					<td><input id="handleTime" name="handleTime" type="text"
						class="Wdate inputtext required" style="width: 225px"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						<span style="color: red">*</span>
					</td>
				</tr>
				<tr>
					<th>处理过程描述：</th>
					<td><textarea id="handleRemark" class="inputtext"
							name="handleRemark" style="height:120px "></textarea>
					    <input type="hidden" id="id" name="id" value="${entity.id}"  />
					    <input type="hidden" id="recodeId" name="recodeId" value="${entity.recodeId}"  />
					</td>
				</tr>
				<tr>
					<th>处理结果：</th>
					<td><baseinfo:dicselector name="handleResult"
							style="width: 225px" columntype="handle_result"
							cssClass="inputtext required" type="select"></baseinfo:dicselector>
						<span style="color: red">*</span>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center; margin-top: 10px">
			<input id="btnSubmit" value="保存" type="submit" class="button" /> <input name="" value="返回" type="button"
				class="button" onclick="history.go(-1);" />
		</div>
	</form>
</body>

</html>