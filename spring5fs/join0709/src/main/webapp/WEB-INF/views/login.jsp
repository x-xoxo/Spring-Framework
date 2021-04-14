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
	    password: {
	      required: true,
	      minlength: 5
	    }
	  },
	  //For custom messages
	  messages: {
	    username:{
	      required: "Enter a username",
	      minlength: "Enter at least 4 characters"
	    }
	  },
	  errorElement : 'div',
	  errorPlacement: function(error, element) {
	    var placement = $(element).data('error');
	    if (placement) {
	      $(placement).append(error)
	    } else {
	      error.insertAfter(element);
	    }
	  }
	});
});
</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" type="text/css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css"/>
<link rel="stylesheet" href="resources/css/login.css?after" type="text/css"/>
	<title>Login</title>
</head>
<body>
<video autoplay muted loop id="myVideo">
  <source src="resources/a.mp4" type="video/mp4">
</video>
<div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
      <form class="login-form" action="loginCheck" method="post">
        <div class="row">
          <div class="input-field col s12 center">
            <!-- <img src="images/login-logo.png" alt="" class="circle responsive-img valign profile-image-login"/> -->
            <p class="center login-form-text">LOGIN</p>
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-social-person-outline prefix"></i> -->
            <i class="material-icons prefix">account_circle</i>
            <input id="username" name="username" type="text" style= "background: blue" />
            <label for="username" data-error="wrong" class="center-align" data-success="right">Username</label>            
          </div>
        </div>
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-action-lock-outline prefix"></i> -->
            <i class="material-icons prefix">vpn_key</i>
            <input id="password" name="password" type="password" style="background: blue"/>
            <label for="password">Password</label>
          </div>
        </div>
        
        <div class="row">          
          <div class="input-field col s12 login-text">                   
              <input type="checkbox" id="test6" checked="checked" />
              <label for="test6" class="pointer-events">Remember me</label>
          </div>
        </div>
        
        <div class="row">
          <div class="input-field col s12">
            <button type="submit" class="btn waves-effect waves-light col s12">Login</button>
          </div>
          <div class="input-field col s12">
            <a href="board/list" class="btn waves-effect waves-light col s12 light-blue darken-4">게시판</a>
          </div>
        </div>
        
        <div class="row">
          <div class="input-field col s6 m6 l6">
            <p class="margin medium-small"><a href="register">Register Now!</a></p>
          </div>
          <div class="input-field col s6 m6 l6">
              <p class="margin right-align medium-small"><a href="page-forgot-password.html">Forgot password ?</a></p>
          </div>          
        </div>
      </form>
    </div>
  </div>
  
</body>
</html>