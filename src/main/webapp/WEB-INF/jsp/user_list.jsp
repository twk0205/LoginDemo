<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" src="/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/js/easyui-lang-zh_TW.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="/css/icon.css">
<style>
/*
#dataTable, #dataTable td, #dataTable th {
  border: 1px solid;
}

table {
  width: 30%;
  border-collapse: collapse;
}
*/
</style>
</head>

<body>
	<div align="center">
		<h2>
			User List (Login : ${loginAccount}) &nbsp;&nbsp;&nbsp;&nbsp; <a href="#" id="logout_btn" class="easyui-linkbutton">Logout</a>
			
		</h2>
		<form id="search_form" method="post">
			<input type="hidden" id="loginAccount" value="${loginAccount}"/>
			<input type="hidden" id="updateStatus" value="${updateStatus}"/>
			<table>
				<tbody>
					<tr>
						<td>Account : </td>
						<td>
							<input type="text"  id="account" name="account" size="20" maxlength="20" class="easyui-textbox"/>
						</td>
						<td>Name : </td>
						<td>
							<input type="text" id="name" name="name" size="20" maxlength="20" class="easyui-textbox"/>
						</td>
						<td>
							<a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">Search</a>							
						</td>
					<tr>
				</tbody>
			</table>
		</form>
		<form id="edit_form" method="post" action="edit_user">
			<input type="hidden" id="editAccount" name="editAccount"/>
		</form>
		<form id="delete_form" method="post" action="delete_user">
			<input type="hidden" id="deleteAccount" name="deleteAccount"/>
		</form>
		<br/>
		<!-- 
		<table id="dataTable">
			<thead>
				<tr>
					<th style="width:5%;">Index</th>
					<th style="width:25%;">Account</th>
					<th style="width:25%;">Password</th>
					<th style="width:25%;">Name</th>
					<th style="width:10%;">&nbsp;</th>
					<th style="width:10%;">&nbsp;</th>
				</tr>
			</thead>
			<tbody id="uTbody"></tbody>
		</table>
		 -->
		 <div style="text-align:center;width:1000px">
			<table id="dataTable"></table>
		</div>
	</div>
</body>

<script>
var userInfoList = JSON.parse('${userInfoList}');
var loginAccount = $("#loginAccount").val();
var data = {
		"total" : userInfoList.length,
		"rows"  : userInfoList
}
$(document).ready(function() {
	console.log(data);
	checkMsg();
	
    $('#dataTable').datagrid({
    	rownumbers: true,
        data:data,
        scrollbarSize:0,
        fitColumns:true,
        emptyMsg: 'No record found',
        columns:[[
    		{field:'account',title:'Account',width:250},
    		{field:'name',title:'Name',width:250},
    		{field:'password',title:'Password',width:250},
            {field:'action',title:'Action',width:80,align:'center',
                formatter:function(value, row, index){
                	if(row.account == loginAccount) {
	                	var editHtml = '<a href="#" onclick="editUser(\'' + row.account + '\')" >Edit</a> ';
	                    var delHtml = '<a href="#" onclick="deleteUser(\'' + row.account + '\')">Delete</a>';
	                    return editHtml + '/' + delHtml;
                	}
                }
            }
        ]]
    });
  
  //do search
  $('#search_btn').bind('click', function(){
	  var search = {}
      search["account"] = $("#account").val();
	  search["name"] = $("#name").val();
	  $.ajax({
			url: '/doSearch',
			type: 'POST',
			contentType: "application/json",
			dataType: 'json',
			cache: false,
			data: JSON.stringify(search),
			success: function(resp) {
				data = {
						"total" : resp.length,
						"rows"  : resp
				}
				
				$('#dataTable').datagrid('loadData', data); 
				console.log('reload data' + data);
				console.log(data);
			}
		})
  });
  
  //do logout
  $("#logout_btn").click(function() {
	  $("#search_form").attr("action", "/");
	  $("#search_form").submit();
  });

});

function editUser(userAccount) {
	$("#editAccount").val(userAccount);
	$("#edit_form").submit();
}

function deleteUser(userAccount) {
	if(confirm("Are you sure?")){
		$("#deleteAccount").val(userAccount);
		$("#delete_form").submit();
	}
}

function checkMsg() {
	var updateStatus = $("#updateStatus").val();
	if(updateStatus == "true") {
	    alert("Update success.");
	}
}
</script>
</html>
