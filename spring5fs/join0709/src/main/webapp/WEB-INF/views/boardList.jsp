<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en">
    <head>
        <title>게시판</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <script type="text/javascript">
            $(document).ready(function(){
                 
                //--페이지 셋팅
                var totalPage = ${totalPage}; //전체 페이지
                var startPage = ${startPage}; //현재 페이지
                 
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
                 
                //전체 페이지 수를 받아 돌린다.
                for(var i = forStart ; i<= forEnd ; i++){
                    if(startPage == i){
                        pagination += ' <button name="page_move" start_page="'+i+'" disabled type="button" class="btn btn-secondary">'+i+'</button>';
                    }else{
                        pagination += ' <button name="page_move" start_page="'+i+'" style="cursor:pointer;" type="button" class="btn btn-secondary">'+i+'</button>';
                    }
                }
                 
                //하단 페이지 부분에 붙인다.
                $("#pagination").append(pagination);
                //--페이지 셋팅
                 
                 
                $("a[name='subject']").click(function(){
                     
                    location.href = "view?id="+$(this).attr("content_id");
                     
                });
                 
                $("#write").click(function(){
                    location.href = "edit";
                });
                                 
                $(document).on("click","button[name='page_move']",function(){
                     
                    var visiblePages = 10;//리스트 보여줄 페이지
                     
                    $('#startPage').val($(this).attr("start_page"));//보고 싶은 페이지
                    $('#visiblePages').val(visiblePages);
                     
                    $("#frmSearch").submit();
                     
                });
                 
            });
        </script>
        <style>
            .mouseOverHighlight {
                cursor: pointer !important;
                color: black;
                pointer-events: auto;
                text-decoration: none;
            }
            .mouseOverHighlight:hover {
            	text-decoration: underline;
            	color: black;
            }
        </style>
    </head>
    <body>
        <form class="form-inline" id="frmSearch" action="list">
            <input type="hidden" id="startPage" name="startPage" value=""><!-- 페이징을 위한 hidden타입 추가 -->
            <input type="hidden" id="visiblePages" name="visiblePages" value=""><!-- 페이징을 위한 hidden타입 추가 -->
            <div align="center">
                <div align="right"><button type="button" id="write" name="write" type="button" class="btn btn-secondary">글 작성</button></div>
                <table class="table table-striped">
                	<thead>
                    	<tr>
                        	<th scope="col">
                        	    #
                        	</th >
                        	<th scope="col">
                        	    제목
                        	</th>
                        	<th scope="col">
                        	    작성자
                        	</th>
                        	<th scope="col">
                        	    작성일
                        	</th>
                    	</tr>
                    </thead>
                    <c:choose>
                        <c:when test="${fn:length(boardList) == 0}">
                        	<tbody>
                            	<tr>
                                	<td colspan="4" align="center">
                                    	조회결과가 없습니다.
                                	</td>
                            	</tr>
                            </tbody>
                        </c:when>
                        <c:otherwise>
                        	<tbody>
                            <c:forEach var="boardList" items="${boardList}" varStatus="status">
                                <tr>
                                    <td>${boardList.id}</td>
                                    <td>
                                        <a name="subject" class="mouseOverHighlight" content_id="${boardList.id}">${boardList.subject}</a>
                                    </td>
                                    <td>${boardList.writer}</td>
                                    <td>${boardList.register_datetime}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </c:otherwise> 
                    </c:choose>
                </table>
                <br>
                <div id="pagination"></div>
            </div>
        </form>
    </body>
</html>