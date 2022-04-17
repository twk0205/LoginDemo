<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<div align="center">
		<h2>Simple Login Demo</h2>
		<form id="login_form" method="post">
			<table>
				<tbody>
				    <input type="hidden" id="registerStatus" value="${registerStatus}"/>
				    <input type="hidden" id="userAccount" value="${userAccount}"/>
				    <input type="hidden" id="loginError" value="${loginError}"/>
					<tr>
						<td>Account : </td>
						<td>
							<input type="text" id="account" name="account" size="20" maxlength="20" value="${account}"/>
						</td>
					</tr>
					<tr>
						<td>Password : </td>
						<td>
							<input type="text" id="password" name="password" size="20" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td >
							<button type="button" id="login_btn">Login</button>
							<button type="button" id="register_btn">Register</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>

<script>
$(document).ready(function() {

  checkMsg();

  //do login
  $("#login_btn").click(function(){
	  if(!$("#account").val() || !$("#password").val()) {
		  alert("Please enter Account and Password.");
		  return false;
	  } else {
		  $("#login_form").attr("action", "/dologin");
		  $("#login_form").submit();
	  }
  });
  
  //do register
  $("#register_btn").click(function() {
	  $("#login_form").attr("action", "/doRegister");
	  $("#login_form").submit();
  });

});

function checkMsg() {
	var loginError = $("#loginError").val();
	var registerStatus = $("#registerStatus").val();
	var userAccount = $("#userAccount").val();
	
	if(registerStatus == "true") {
	    alert("Register [" + userAccount + "] success.");
	} else if(registerStatus == "false") {
	    alert("Register [" + userAccount + "] failed, Account is existed.");
	}
	
	if(loginError == "true") {
	    alert("Login Failed");
	}
}
</script>
</html>
