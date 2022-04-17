<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<div align="center">
		<h2>Edit User Data</h2>
		<form id="update_form" method="post">
			<table>
				<tbody>
					<input type="hidden" id="account" name="account" value="${userAccount}"/>
					<tr>
						<td>Account : </td>
						<td>
							<!-- <input type="text" id="account" name="account" size="20" maxlength="20" value="${userAccount}"/> -->
							<label>${userAccount}</label>
						</td>
					</tr>
					<tr>
						<td>Name : </td>
						<td>
							<input type="text" id="name" name="name" size="20" maxlength="20" value="${userName}"/>
						</td>
					</tr>
					<tr>
						<td>Password : </td>
						<td>
							<input type="text" id="password" name="password" size="20" value="${userPassword}"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td >
							<button type="button" id="update_btn">Update</button>
							<button type="button" id="cancel_btn">Cancel</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>

<script>
$(document).ready(function() {
	
	$("#cancel_btn").click(function() {
		window.history.back();
	});
	
	$("#update_btn").click(function() {
		var isDataValPass = ckeckInputData();
		if(isDataValPass) {
			$("#update_form").attr("action", "/update_user");
			$("#update_form").submit();
		} else {
			alert("Account/Name/Password can't be empty.");
		}
		
	});

});

function ckeckInputData() {
	if(!$("#name").val() || !$("#password").val()) {
		return false;
	} else {
		return true;
	}
}
</script>
</html>
