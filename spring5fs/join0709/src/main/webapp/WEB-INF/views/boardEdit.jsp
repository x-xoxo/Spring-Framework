<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
    <head>
        <title>게시판</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <script src="//cdn.ckeditor.com/4.12.1/full/ckeditor.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                
            	CKEDITOR.replace( 'content', {//해당 이름으로 된 textarea에 에디터를 적용
                    width:'100%',
                    height:'400px',
                    filebrowserImageUploadUrl: 'insertImage' //여기 경로로 파일을 전달하여 업로드 시킨다.
                });
                 
                 
                CKEDITOR.on('dialogDefinition', function( ev ){
                    var dialogName = ev.data.name;
                    var dialogDefinition = ev.data.definition;
                  
                    switch (dialogName) {
                        case 'image': //Image Properties dialog
                            //dialogDefinition.removeContents('info');
                            dialogDefinition.removeContents('Link');
                            dialogDefinition.removeContents('advanced');
                            break;
                    }
                });
            	
                 
                $("#list").click(function(){
                    location.href = "/board/list";
                });
                 
                $("#save").click(function(){
                     
                    //에디터 내용 가져옴
                    var content = CKEDITOR.instances.content.getData();
                     
                    //널 검사
                    if($("#subject").val().trim() == ""){
                        alert("제목을 입력하세요.");
                        $("#subject").focus();
                        return false;
                    }
                     
                    if($("#writer").val().trim() == ""){
                        alert("작성자를 입력하세요.");
                        $("#writer").focus();
                        return false;
                    }
                     
                    if($("#password").val().trim() == ""){
                        alert("비밀번호를 입력하세요.");
                        $("#password").focus();
                        return false;
                    }
                     
                    //값 셋팅
                    var objParams = {
                            <c:if test="${boardView.id != null}"> //있으면 수정 없으면 등록
                            id          : $("#board_id").val(),
                            </c:if>
                            subject     : $("#subject").val(),
                            writer      : $("#writer").val(),
                            password    : $("#password").val(),
                            content     : content
                    };
                     
                    //ajax 호출
                    $.ajax({
                        url         :   "save",
                        dataType    :   "json",
                        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
                        type        :   "post",
                        data        :   objParams,
                        success     :   function(retVal){
 
                            if(retVal.code == "OK") {
                                alert(retVal.message);
                                location.href = "list";  
                            } else {
                                alert(retVal.message);
                            }
                             
                        },
                        error       :   function(request, status, error){
                            console.log("AJAX_ERROR");
                        }
                    });
                     
                     
                });
                 
            });
        </script>
    </head>
    <body>
        <input type="hidden" id="board_id" name="board_id" value="${boardView.id}" />
        <div align="center">
            </br>
            </br>
            <table width="1200px">
                <tr>
                    <td>
                        제목: <input type="text" id="subject" name="subject" style="width:600px;" placeholder="제목" value="${boardView.subject}"/>
                        작성자: <input type="text" id="writer" name="writer" style="width:170px;" maxlength="10" placeholder="작성자" value="${boardView.writer}"/>
                        비밀번호: <input type="password" id="password" name="password" style="width:170px;" maxlength="10" placeholder="패스워드"/>
                        <button id="save" name="save">저장</button>                           
                    </td>
                </tr>
                <tr>
                    <td>
                        <textarea name="content" id="content" rows="10" cols="80">${boardView.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <button id="list" name="list">게시판</button>
                    </td>
                </tr>
            </table>
        </div>
        
    </body>
</html>