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
//로그인 입력에 대한 유효성 검사
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
	  //messages를 만들어서 요청이 있거나 길이가 짧으면 출력되는 문장
	  //이놈의 왜나오죠?
	  // jquery.validate정의가 되어있어 따로 안해도 출력이 됩니다.
	  messages: {
	    username:{
	      required: "Enter a username",
	      minlength: "Enter at least 4 characters"
	    }
	  },
	  //에러났을때
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
<!--  CSS  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" type="text/css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css"/>
<link rel="stylesheet" href="resources/css/login.css?after" type="text/css"/>
	<title>Login</title>
</head>
<body>
<!-- 1. 미스터 션샤인 영상 나오게 자동실행 음소거 무한반복 백그라운드 영상-->
<video autoplay muted loop id="myVideo">
  <source src="resources/a.mp4" type="video/mp4">
</video>
<!-- 2번 태그 -->
<div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
      <form class="login-form" action="loginCheck" method="post">
      <!-- LOGIN 글자 나오게하는 div -->
        <div class="row">
          <div class="input-field col s12 center">
            <!-- <img src="images/login-logo.png" alt="" class="circle responsive-img valign profile-image-login"/> -->
            <p class="center login-form-text">LOGIN</p>
          </div>
        </div>
        <!-- Username 입력하는 div -->
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-social-person-outline prefix"></i> -->
            <i class="material-icons prefix">account_circle</i>
            <input id="username" name="username" type="text" style= "background: white" />
            <label for="username" data-error="wrong" class="center-align" data-success="right">Username</label>            
          </div>
        </div>
        <!-- Password 입력하는 div -->
        <div class="row margin">
          <div class="input-field col s12">
            <!-- <i class="mdi-action-lock-outline prefix"></i> -->
            <i class="material-icons prefix">vpn_key</i>
            <input id="password" name="password" type="password" style="background: white"/>
            <label for="password">Password</label>
          </div>
        </div>
        
        <!-- ID를 기억하는 체크버튼 div -->
        <div class="row">          
          <div class="input-field col s12 login-text">                   
              <input type="checkbox" id="test6" checked="checked" />
              <label for="test6" class="pointer-events">Remember me</label>
          </div>
        </div>
        <!-- 로그인을 위한 버튼 div / 게시판으로 이동하기 위한 버튼이 있는 div -->
        <div class="row">
          <div class="input-field col s12">
            <button type="submit" class="btn waves-effect waves-light col s12">Login</button>
          </div>
          <div class="input-field col s12">
            <a href="board/list" class="btn waves-effect waves-light col s12 light-blue darken-4">게시판</a>
          </div>
        </div>
        <!-- 회원가입으로 이동하기 위한 div / 암호를 잊어버렸을때 암호를 찾기 위한 버튼 div -->
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