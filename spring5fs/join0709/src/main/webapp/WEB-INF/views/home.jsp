<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- c태그를 쓰기 위해서 import -->
<html>
<head>
<!-- import -->
<!-- jquery :  HTML의 클라이언트 사이드 조작을 단순화 하도록 설계된 크로스 플랫폼의 자바스크립트 라이브러리다. -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!--materialize 디자인  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<!--validate 유효성검사  -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>

<!-- 위에 import한 것을 가지고 만드는 javascript -->
<script type="text/javascript">
$(function (){
	//login-form 관련 유효성검사
	$(".login-form").validate({
		rules: {
			//username 4글자를 넘어야 한다.
			username: {
				required: true,
				minlength: 4
			},
			//email은 email 형식에 맞아야 한다.
			email: {
				required: true,
				email:true
			},
			//password 5글자를 넘어야한다.
			password: {
				required: true,
				minlength: 5
			},
			//패스워드 확인은 패스워드와 같고 5글자를 넘어야한다.
			cpassword: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			}
		},
		//For custom messages
		//위에 룰을 위반시에는 밑에 명령어들 실행이 됩니다.
		//jquery validate에 정의가 되어있습니다.
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
	///////////////////////////////////////////////////////////////////////////////////
	//emailCheck가 클릭이 되면 실행되는 함수
	$(".emailCheck").click(function(){
		
		//기본적이 email유효성 검사를 하기 위한 문자열
		var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
		
		//emailRule 테스트하는 #email에 있는 값이랑 비교 해서 거짓이 나오면 실행 
		if(!emailRule.test($("#email").val())) {            
		    //경고
		    //이메일 유효성 검사를 했는데 실패 했기때문에
		    //result msg에 text -> "이메일을 올바르게 입력하세요."
		    //result msg에 attr(속석) -> "style", "color:#f00" 색깔이 빨간색이 된다.
		    //return을 해서 함수를 종료 한다.
			$(".result .msg").text("이메일을 올바르게 입력하세요.");
			$(".result .msg").attr("style", "color:#f00");
			return;
		}
		
		//위에 유효성 검사가 완료가 되서 문제가 없으면 아래 명령어 실행
		var query = {email : $("#email").val()}; //json형식
		$.ajax({
			url : "emailCheck", //controller Mapping 주소
			type : "post", // 보내는 형식
			data : query, // 보내는 데이터
			dataType : "json", // 데이터 형식
/*성공했을 경우*/success : function(data){ //자바 -> DB -> 자바와서 문제가 없으면 실행 되는 함수
				alert(data);
				//data 값이 0이면
				if(data == 0){
				    //result msg에 text -> "사용 가능"
				    //result msg에 attr(속석) -> "style", "color:#00f" 색깔이 파란색이 된다.
					$(".result .msg").text("사용 가능");
					$(".result .msg").attr("style", "color:#00f");
					
				}
				//data 값이 0이 아니면 
				else{
					//result msg에 text -> "사용 불가"
				    //result msg에 attr(속석) -> "style", "color:#f00" 색깔이 빨간색이 된다.
					$(".result .msg").text("사용 불가");
					$(".result .msg").attr("style", "color:#f00");
				}
			},
/*Ajax기능이 실패하면*/	error:function(request,status,error){
		        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); 
		        // 실패 시 처리 팝업을 띄우는데 code, message, error를 띄워서 무슨 문제인지 확인을 한다.
		       }
		});
	});
});

</script>

<!-- materialize 디자인을 사용하는 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" type="text/css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css"/>
<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="resources/css/register.css" type="text/css"/>
	<title>Home</title>
</head>
<body>
<!-- class 명이 요상한 이유는 materialize에 기준으로 화면을 꾸미고 싶어서 정해져있는 class이름을 사용 하는 겁니다. -->
<div id="login-page" class="row">
  <div class="col s12 z-depth-4 card-panel">
    <form class="login-form" action="registerNow" method="post">
    <!-- Register. 글자 아주 큼직하게 나오게 하려고 -->
      <div class="row">
        <div class="input-field col s12 center">
          <h4>Register</h4>
          <p class="center" style="color: red">Join to our community now !</p>
        </div>
      </div>
	<!-- UserName 입력받는 div -->
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">account_circle</i>
          <input id="username" name="username" type="text"/>
          <label for="username">Username</label>
        </div>
      </div>
<!-- Email 입력받는 div -->
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
<!-- Password 입력받는 div -->
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="password" name="password" type="password" />
          <label for="password">Password</label>
        </div>
      </div>

<!-- 비밀번호 확인 입력받는 div -->
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="password_a" name="cpassword" type="password" />
          <label for="password_a">Password again</label>
        </div>
      </div>

<!-- 회원가입 버튼 로그인으로 이동을 할 수 있는 부분이 있는 div -->
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
