<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<html>
    <head>
        <title>게시판</title>
        <!-- jquery만 import -->
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <script type="text/javascript">
        	/*
        	fuction(a)
        	{
        		return "hello";
        	}
        	 $(document).ready -> 문서 준비작업을 하는 함수인 
        	 function을 만들어서 기능을 추가해주는 것을 해서 기능을 실행
        	 
        	*/
        	//documnet ready -> function Login 어떤 데이터도 받아서 뿌려줘야 하는 기능 자체가 없어서
        	//function 함수등록만 하면 되지만
        	//boardList같은 경우에는 DB에 있는 게시판 데이터를 가져와서 세팅을 우선 한 이후에 화면이 출력이 되야 합니다.
        	//documnet ready를 사용을 해야합니다.
            $(document).ready(function(){
                 
                //--페이지 셋팅
                var totalPage = ${totalPage}; //전체 페이지 ${tatalPage} -> Java에서 데이터를 넘겨준 데이터
                var startPage = ${startPage}; //현재 페이지 ${startPage} -> Java에서 데이터를 넘겨준 데이터
                
                alert(totalPage); //팝업 출력
                
                //Javascript 자료형 var -> 문자열이던 문자던 정수던 실수던 다 받을 수 있는 자료형
                var pagination = "";
                 
                //--페이지네이션에 항상 10개가 보이도록 조절
                var forStart = 0;
                var forEnd = 0;
                 
                if((startPage-5) < 1){
                    forStart = 1;
                }else{
                    forStart = startPage-5;
                }
                 
                if(forStart == 1){
                     
                    if(totalPage>9){
                        forEnd = 10;
                    }else{
                        forEnd = totalPage;
                    }
                     
                }else{
                     
                    if((startPage+4) > totalPage){
                         
                        forEnd = totalPage;
                         
                        if(forEnd>9){
                            forStart = forEnd-9
                        }
                         
                    }else{
                        forEnd = startPage+4;
                    }
                }
                //--페이지네이션에 항상 10개가 보이도록 조절
                //★///////////////////////////////////////////////////////////////★ 
                //전체 페이지 수를 받아 돌린다.
                for(var i = forStart ; i<= forEnd ; i++){
                    if(startPage == i){
                    	//버튼을 추가하는 HTML 태그 문장을 pagination에 추가 해준다.
                    	//HTML태그 자체를 문자열로 받아서 추가해주는 형식
                    	//여기서 버튼을 만들때라 댓글 또는 대댓글 이런 패턴이 쓰입니다.
                        pagination += ' <button name="page_move" start_page="'+i+'" disabled>'+i+'</button>';
                    }else{
                        pagination += ' <button name="page_move" start_page="'+i+'" style="cursor:pointer;" >'+i+'</button>';
                    }
                }
                 
                //하단 페이지 부분에 붙인다. pagination이 추가 된다.
                $("#pagination").append(pagination);
                //--페이지 셋팅
                //★///////////////////////////////////////////////////////////////////★ 
                
                //제목을 클릭시 그 게시물로 이동하는 함수 boardView로 이동 contend_id 어떤 게시판 글인지 id를 추출해서
                //db에서 값을 받아서 boardView로 이동시 그 id 게시판 글에 대한 정보를 받아서 출력이 됩니다.
                $("a[name='subject']").click(function(){
                    // location.href이게 화면 이동 view?id 3번인 게시글로 이동
                    location.href = "view?id="+$(this).attr("content_id");
                     
                });
                
                 //게시글을 쓰러 이동하는 함수
                // $("#write").click(명령어); => write가 클리이되면 소괄호 안에 있는 명령어를 실행한다. 
                //boardEdit로 이동
                $("#write").click(function(){
                    location.href = "edit";
                });
                
                //게사판 맨 밑에 페이지 이동 버튼을 클릭시 수행하는 함수
                //밑에 있는 번호 버튼을 누르면 그 그룹에 있는 게시판 내용일 출력이 되도록 하는 함수
                //Java -> DB -> Java -> DB boardList가 재호출이 됩니다.
                $(document).on("click","button[name='page_move']",function(){
                    
                	/*
                	예를들어서 버튼 2를 눌렀습니다.
                	#StartPage ->2
                	#visiblePages ->10
                	submit 호출 하니까 boardController -> list 맵핑된 함수가 호출이 됩니다.
                	startPage와 visiblePages를 가지고 service -> dao -> 바티스를 거쳐서
                	select 쿼리를 호출해서 11번째 글부터 20번째 글까지 가지고 올라와서
                	데이터를 Java에 추가를 해주고 다시 boardList가 호출되서
                	게시판 리스트가 보여집니다.
                	*/
                	
                	
                    var visiblePages = 10;//리스트 보여줄 페이지
                    /*
                    $('#startPage').val -> id startPage의 값을 세팅한다. 밑에 값으로 한다.
                    $(this).attr("start_page")
                    this 자기자신에 attr "start_page 값으로 세팅을 한다.
                    $('#startPage')값이 꼭 필요한 이유는 Controller에서 이 값을 활용해서
                    게시판 목록을 바꿔야한다.
                    */ 
                    $('#startPage').val($(this).attr("start_page"));//보고 싶은 페이지 start_page 값 2가되고
                    $('#visiblePages').val(visiblePages); //10개 페이지
                    /*
                    $('#visiblePages').val -> id visiblePages의 값을
                    visiblePages의 값으로 세팅한다. => 10으로 세팅한다.
                    $('#visiblePages')값이 꼭 필요한 이유는 Controller에서 이 값을 활용해서
                    게시판 목록을 바꿔야한다.
                    */
                    
                    
                    $("#frmSearch").submit(); 
                    //form태그 submit 실행 -> Controller에 list로 맵핑되어있는 함수가 호출되서 
                    //게시판 목록을 새로 받아와서 다시 boardList.jsp가 호출된다.
                     
                });
                 
            });
        </script>
        <style>
        <!-- css -->
            .mouseOverHighlight {
                   border-bottom: 1px solid blue;
                   cursor: pointer !important;
                   color: blue;
                   pointer-events: auto;
                }
        </style>
    </head>
    <body>
        <form class="form-inline" id="frmSearch" action="list">
            <input type="hidden" id="startPage" name="startPage" value=""><!-- 페이징을 위한 hidden타입 추가 -->
            <input type="hidden" id="visiblePages" name="visiblePages" value=""><!-- 페이징을 위한 hidden타입 추가 -->
            <div align="center">
            <!-- 테이블 -->
                <table width="1200px">
                    <tr>
                        <td align="right">
                            <button type="button" id="write" name="write">글 작성</button>
                        </td>
                    </tr>
                </table>
                <table border="1" width="1200px">
                <!-- 테이블 헤드 -->
                    <tr>
                        <th width="50px">
                            No
                        </th>
                        <th width="850px">
                            제목
                        </th>
                        <th width="100px">
                            작성자
                        </th>
                        <th width="200px">
                            작성일
                        </th>
                    </tr>
                    <!-- 조건문 -->
                    <c:choose> <!-- 나 조건문을 쓸께 -->
                    <!-- 게시판에 글이 없을때 -->
                        <c:when test="${fn:length(boardList) == 0}"><!-- if문 -->
                            <tr>
                                <td colspan="4" align="center">
                                    조회결과가 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise><!-- else문 -->
                        <!-- 게시판에 글이 있을때 ${}형식으로 java에서 데이터를 가져와서 반복문을 이용해서 테이블 행을 추가 -->
               <!-- 반복문 --><c:forEach var="boardList" items="${boardList}" varStatus="status">
                                <tr>
                                    <td align="center">${boardList.id}</td>
                                    <td>
                                        <a name="subject" class="mouseOverHighlight" content_id="${boardList.id}">${boardList.subject}</a>
                                    </td>
                                    <td align="center">${boardList.writer}</td>
                                    <td align="center">${boardList.register_datetime}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise> 
                    </c:choose>
                </table>
                <br>
                <!-- 게시판의 글의 수에 따라서 그룹화 하는 버튼이 생성될 곳 -->
                <div id="pagination"></div><!-- 아무것도 없는 div 태그 -->
            </div>
        </form>
    </body>
</html>