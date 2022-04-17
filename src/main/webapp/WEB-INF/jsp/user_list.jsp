<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
#dataTable, #dataTable td, #dataTable th {
  border: 1px solid;
}

table {
  width: 30%;
  border-collapse: collapse;
}
</style>
</head>

<body>
	<div align="center">
		<h2>
			User List (Login : ${loginAccount}) &nbsp;&nbsp;&nbsp;&nbsp; <button type="button" id="logout_btn">Logout</button>
		</h2>
		<form id="search_form" method="post">
			<input type="hidden" id="loginAccount" value="${loginAccount}"/>
			<input type="hidden" id="updateStatus" value="${updateStatus}"/>
			<table>
				<tbody>
					<tr>
						<td>Account : </td>
						<td>
							<input type="text" id="account" name="account" size="20" maxlength="20"/>
						</td>
						<td>Name : </td>
						<td>
							<input type="text" id="name" name="name" size="20" maxlength="20"/>
						</td>
						<td>
							<button type="button" id="search_btn">Search</button>
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
			<tbody id="uTbody">
			</tbody>
		</table>
	</div>
</body>

<script>
var userInfoList = JSON.parse('${userInfoList}');
var loginAccount = $("#loginAccount").val();

$(document).ready(function() {
  checkMsg();
  var bodyHtml = genUserInfoTableBody(userInfoList);
  $("#uTbody").append(bodyHtml);
  
  //do search
  $("#search_btn").click(function() {
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
			success: function(data) {
				console.log(data);
				$("#uTbody").html("");
				var bodyHtml = genUserInfoTableBody(data);
				$("#uTbody").append(bodyHtml);
			}
		})
  });
  
  //do logout
  $("#logout_btn").click(function() {
	  $("#search_form").attr("action", "/");
	  $("#search_form").submit();
  });

});

function genUserInfoTableBody(data) {
	var bodyHtml = "";
	if(data!=null && data.length > 0) {
		for(var i=0; i<data.length; i++) {
			  //console.log('name : ' + userInfoList[i].name + ', password' + userInfoList[i].password);
			  bodyHtml += '<tr>';
			  bodyHtml += '<td align="center">' + (i + 1) + '</td>';
			  bodyHtml += '<td align="center">' + data[i].account + '</td>';
			  bodyHtml += '<td align="center">' + data[i].password + '</td>';
			  bodyHtml += '<td align="center">' + data[i].name + '</td>';
			  if(data[i].account == loginAccount) {
				  bodyHtml += '<td align="center"><a href="#" onclick="editUser(\'' + data[i].account + '\');">Edit</a></td>';
				  bodyHtml += '<td align="center"><a href="#" onclick="deleteUser(\'' + data[i].account + '\');">Delete</a></td>';
			  } else {
				  bodyHtml += '<td align="center"></td>';
				  bodyHtml += '<td align="center"></td>';
			  }
			  
			  bodyHtml += '</tr>';
		  }
	} else {
		bodyHtml += '<tr>';
		bodyHtml += '<td colspan="5">No Data.</td>';
		bodyHtml += '</tr>';
	}
	return bodyHtml;
}

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
