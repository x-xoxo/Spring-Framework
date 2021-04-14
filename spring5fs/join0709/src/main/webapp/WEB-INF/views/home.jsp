<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>


<script type="text/javascript">
$(function (){
	$(".login-form").validate({
		rules: {
			username: {
				required: true,
				minlength: 4
			},     
			email: {
				required: true,
				email:true
			},
			password: {
				required: true,
				minlength: 5
			},
			cpassword: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			}
		},
		//For custom messages
		
		errorElement : 'div',
		errorPlacement: function(error, element) {
			var placement = $(element).data('error');
			if (placement) {
				$(placement).append(error);
			} else {
				error.insertAfter(element);
			}
		}
	});
	
	$(".emailCheck").click(function(){
		
		var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
		 
		if(!emailRule.test($("#email").val())) {            
		            //경고
			$(".result .msg").text("이메일을 올바르게 입력하세요.");
			$(".result .msg").attr("style", "color:#f00");
			return;
		}
		
		var query = {email : $("#email").val()};
		$.ajax({
			url : "emailCheck",
			type : "post",
			data : query,
			dataType : "json",
			success : function(data){
				alert(data);
				if(data == 0){
					$(".result .msg").text("사용 가능");
					$(".result .msg").attr("style", "color:#00f");
					
				}
				else{
					$(".result .msg").text("사용 불가");
					$(".result .msg").attr("style", "color:#f00");
				}
			},
			error:function(request,status,error){
		        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		       }
		});
	});
});

</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" type="text/css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css"/>
<link rel="stylesheet" href="resources/css/register.css" type="text/css"/>
	<title>Home</title>
</head>
<body>
<div id="login-page" class="row">
  <div class="col s12 z-depth-4 card-panel">
    <form class="login-form" action="registerNow" method="post">
      <div class="row">
        <div class="input-field col s12 center">
          <h4>Register</h4>
          <p class="center" style="color: red">Join to our community now !</p>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">account_circle</i>
          <input id="username" name="username" type="text"/>
          <label for="username">Username</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">email</i>
          <input id="email" name="email" type="text" style="cursor: auto;" />
          <label for="email">Email</label>
          <p>
          <button type="button" class="emailCheck">이메일 확인</button>
          </p>
          <p class="result">
          	<span class="msg">이메일을 확인하세요.</span>
          </p>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="password" name="password" type="password" />
          <label for="password">Password</label>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="password_a" name="cpassword" type="password" />
          <label for="password_a">Password again</label>
        </div>
      </div>

      <div class="row">
        <div class="input-field col s12">
          <button type="submit" class="btn waves-effect waves-light col s12">REGISTER NOW</button>
          
        </div>
        <div class="input-field col s12">
          <p class="margin center medium-small sign-up">Already have an account? <a href="/login">Login</a></p>
        </div>
      </div>


    </form>
  </div>
</div>
</body>
</html>
