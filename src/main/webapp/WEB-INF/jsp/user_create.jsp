<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<div align="center">
		<h2>Register New User</h2>
		<form id="create_form" method="post">
			<table>
				<tbody>
					<tr>
						<td>Account : </td>
						<td>
							<input type="text" id="account" name="account" size="20" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td>Name : </td>
						<td>
							<input type="text" id="name" name="name" size="20" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td>Password : </td>
						<td>
							<input type="text" id="password" name="password" size="20"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td >
							<button type="button" id="create_btn">Register</button>
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
		//window.history.back();
		$("#create_form").attr("action", "/");
		$("#create_form").submit();
	});
	
	$("#create_btn").click(function() {
		var isDataValPass = ckeckInputData();
		if(isDataValPass) {
			$("#create_form").attr("action", "/create_user");
			$("#create_form").submit();
		} else {
			alert("Account/Name/Password can't be empty.");
		}
		
	});

});

function ckeckInputData() {
	if(!$("#account").val() || !$("#name").val() || !$("#password").val()) {
		return false;
	} else {
		return true;
	}
}
</script>
</html>
