<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
    <head>
        <title>게시판</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <!-- ckeditor 글 작성할때 일반적으로 글자색깔 크기이런 조정하는거 그 Javascript 쓰려고 import -->
        <script src="//cdn.ckeditor.com/4.12.1/full/ckeditor.js"></script>
        <script type="text/javascript">
        //$(document).ready을 쓴 이유는 CKEDITOR를 먼저 등록을해서 글쓰기 진행 되야 하니까
        //$(document).ready로 만들었습니다.
            $(document).ready(function(){
                
            	//수정한다.CKEDITOR textarea에 추가해주는 명령문
            	CKEDITOR.replace( 'content', {//해당 이름으로 된 textarea에 에디터를 적용
                    width:'100%',
                    height:'400px',
                    filebrowserImageUploadUrl: 'insertImage' //여기 경로로 파일을 전달하여 업로드 시킨다.
                });
                 
                //체크에디터에서 필요 없는 부분을 제거할때 사용하는 명령문 
                CKEDITOR.on('dialogDefinition', function( ev ){
                    var dialogName = ev.data.name;
                    var dialogDefinition = ev.data.definition;
                  
                    switch (dialogName) {
                        case 'image': //Image Properties dialog
                            //dialogDefinition.removeContents('info');
                            dialogDefinition.removeContents('Link'); //링크 탭 제거
                            dialogDefinition.removeContents('advanced');//상세정보 탭제거
                            break;
                    }
                });
            	
                //list버튼 클릭시 실행하는 함수 -> boardList.jsp이동 
                $("#list").click(function(){
                    location.href = "/board/list";
                });
                
                //저장버튼 클리시 실행하는 함수
                $("#save").click(function(){
                     
                    //에디터 내용 가져옴 글 쓴 내용을 가져와서 content 변수에 대입
                    var content = CKEDITOR.instances.content.getData();
                     
                    //널 검사 유효성 검사
                    //제목을 입력 안한하면 실행되는 명령문
                    if($("#subject").val().trim() == ""){
                        alert("제목을 입력하세요.");
                        $("#subject").focus();
                        return false;
                    }
                    //작성자를 입력을 안하면 실행되는 명령문 
                    //원래는 로그인 세션을 유지하기 때문에 로그인 안돼면 글을 쓸 수가 없습니다.
                    //작성자 유효성 검사가 필요가 없습니다.
                    //하지만 join0709에는 session 기능이 없어서 아래 명령문을 추가 했습니다.
                    if($("#writer").val().trim() == ""){
                        alert("작성자를 입력하세요.");
                        $("#writer").focus();
                        return false;
                    }
                    //비밀번호를 입력을 안하면 실행되는 명령문 
                    if($("#password").val().trim() == ""){
                        alert("비밀번호를 입력하세요.");
                        $("#password").focus();
                        return false;
                    }
                    
                    //유효성 검사는 OK
                    
                    //값 셋팅
                    //Json 형식 변수이름 objParams
                    // boardView.id이가 null아니면 수정 이면 id          : $("#board_id").val() 추가를 합니다. 
                    //boardView.id이가 null이면 등록 이면 id          : $("#board_id").val() 추가를 안합니다.
                    var objParams = {
                            <c:if test="${boardView.id != null}"> //있으면 수정 없으면 등록
                            id          : $("#board_id").val(), //게시판 id
                            </c:if>
                            subject     : $("#subject").val(), //제목
                            writer      : $("#writer").val(),//작성자
                            password    : $("#password").val(),//비밀번호
                            content     : content //글 내용
                    };
                     
                    //ajax 호출
                    $.ajax({
                        url         :   "save", //controller 맵핑 되어있는 save
                        dataType    :   "json", //json 형식
                        contentType :   "application/x-www-form-urlencoded; charset=UTF-8", //글 타입 utf-8
                        type        :   "post",//post형식 암호화
                        data        :   objParams,//위에 있는 var 변수
                        success     :   function(retVal){ //성공하면 실행되는 함수
 
                            if(retVal.code == "OK") {
                                alert(retVal.message); //팝업을 띄어주는 retVal.message가 출력된다.
                                location.href = "list"; //boardList.jsp로 이동
                            } else {
                                alert(retVal.message); //팝업을 띄어주는 retVal.message가 출력된다.
                            }
                             
                        },
                        error       :   function(request, status, error){ //에러가 발생하면 실행되는 함수
                            console.log("AJAX_ERROR"); //콘솔 로그로 AJAX_ERROR가 출력
                        }
                    });
                     
                     
                });
                 
            });
        </script>
    </head>
    <body>
    	<!-- boardView id 값을 출력하는데 숨겨놓습니다. -->
        <input type="hidden" id="board_id" name="board_id" value="${boardView.id}" />
        <div align="center">
            </br>
            </br>
            <!-- 테이블 형식 글쓰기  넓이 1200px-->
            <table width="1200px">
                <tr>
                <!-- 테이블의 하나의 행 -->
                    <td>
                        제목: <input type="text" id="subject" name="subject" style="width:600px;" placeholder="제목" value="${boardView.subject}"/>
                        작성자: <input type="text" id="writer" name="writer" style="width:170px;" maxlength="10" placeholder="작성자" value="${boardView.writer}"/>
                        비밀번호: <input type="password" id="password" name="password" style="width:170px;" maxlength="10" placeholder="패스워드"/>
      <!-- 저장버튼 --><button id="save" name="save">저장</button>                           
                    </td>
                </tr>
                <tr>
                <!-- textarea 글쓰는 행 -->
                    <td>
                        <textarea name="content" id="content" rows="10" cols="80">${boardView.content}</textarea>
                    </td>
                </tr>
                <tr>
                <!-- 게시판으로 이동하는 버튼 -->
                    <td align="right">
                        <button id="list" name="list">게시판</button>
                    </td>
                </tr>
            </table>
        </div>
        
    </body>
</html>