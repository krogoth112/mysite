<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/assets/css/user.css" rel="stylesheet" type="text/css">
<script type = "text/javascript" src = "/assets/js/jquery/jquery-1.9.0.js"></script>
<script>
$(function(){
	//사용자 입력값에 대한 Validation
	$("#join-form").submit(function(){
		//1.이름
		var $name = $("#name");
		var name = $name.val();
		if(name==""){
				alert("이름이 비어있습니다. 필수입력 사항입니다.");
				$name.focus();
				return false;
		}
		//2.이메일 형식체크
		var $email = $("#email");
		var email = $email.val();
		if(email ==""){
			alert("이메일이 비어있습니다. 필수입력 사항입니다.");
			$email.focus();
			return false;
		}
		
	 	//정규표현식 [a-zA-z0-9]
	 	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    	if( re.test(email) ==false){
    		alert("유효한 이메일 형식이 아닙니다.");
			$email.focus();
			return false;
    	} 
    	  // 중복체크 여부
        if($("#email-checked").is(":visible") ==false){
        alert("이메일 중복체크를 하세요");
        return false;
        }
    	
    
	 	
		//3. 페스워드
		var $password = $("#password");
		var password = $password.val();
		if(password==""){
			alert("페스워드가 비어있습니다.. 필수입력 사항입니다.");
			$email.focus();
			return false;
			
		}
		//4. 약관동의
		var $agree = $("#agree-prov");
		var agree = $agree.is(":checked");
		if(agree==false){
			alert("약관동의가 필요합니다.");
			return false;
			
		}
	
		
		return true;
	}) 
		  // 이메일 중복 체크
        $("#email").change(function(){
           $("input[type='button']").show();
           $("#email-checked").hide();
           
        });
	// 이메일 중복 체크
	$("input[type='button']").click(function(){
    var $email = $("#email");
    var email = $email.val();
    if(email==""){
    	return;
    }
    
    //JSON Ajax통신
    $.ajax( {
       url : "/user/checkemail",
       type: "get",
       dataType: "json",
       data: "email="+email,
       contentType: 'application/json',
       success: function( response ){
    	   if( response.result =="exist"){
    		   alert("이미 사용중인 이메일 주소입니다.");
    		   $("#email").focus();
    		   return
    	   }
    	   $("input[type='button']").hide();
    	   $("#email-checked").show();
       },
       error: function( jqXHR, status, e ){
          alert( status + " : " + e );
       }
    });
 });
}) // 이메일 중복 체크





</script>

</head>
<body>
	<div id="container">
		<div id="header">
			<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		</div>
		<div id="content">
			<div id="user">

				<form id="join-form" name="joinForm" method="post" action="join">
					<label class="block-label" for="name">이름</label>
					<input id="name" name="name" type="text" value="">

					<label class="block-label" for="email">이메일</label>
					<input id="email" name="email" type="text" value="">
					<input type="button" value="id 중복체크" >
					<img id="email-checked" src="/assets/images/check.png">
					
					<label class="block-label">패스워드</label>
					<input id="password" name="password" type="password" value="">
					
					<fieldset>
						<legend>성별</legend>
						<label>남</label> <input type="radio" name="gender" value="female" checked="checked">
						<label>여</label> <input type="radio" name="gender" value="male">
					</fieldset>
					
					<fieldset>
						<legend>약관동의</legend>
						<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
						<label>서비스 약관에 동의합니다.</label>
					</fieldset>
					
					<input type="submit" value="가입하기">
					
				</form>
			</div>
		</div>
		<div id="navigation">
			<c:import url="/WEB-INF/views/include/navigation.jsp">
			<c:param name="pageName" value="user"></c:param>
			</c:import>
		</div>
		<div id="footer">
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		</div>
	</div>
</body>
</html>