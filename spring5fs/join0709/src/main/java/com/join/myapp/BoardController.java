package com.join.myapp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

import com.google.gson.JsonObject;
import com.join.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	   @Inject
	   BoardService boardService;
	 
	    // 게시글 리스트 조회
	    @RequestMapping(value = "list")
	    public String boardList(@RequestParam Map<String, Object> paramMap, Model model) {
	 
	        // 조회 하려는 페이지
	        int startPage = (paramMap.get("startPage")!=null?Integer.parseInt(paramMap.get("startPage").toString()):1);
	        // 한페이지에 보여줄 리스트 수
	        int visiblePages = (paramMap.get("visiblePages")!=null?Integer.parseInt(paramMap.get("visiblePages").toString()):10);
	        // 일단 전체 건수를 가져온다. 게시판에 전체 글 카운터
	        int totalCnt = boardService.getContentCnt(paramMap);
	 
	 
	        // 아래 1,2는 실제 개발에서는 class로 빼준다. (여기서는 이해를 위해 직접 적음)
	        // 1.하단 페이지 네비게이션에서 보여줄 리스트 수를 구한다.
	        BigDecimal decimal1 = new BigDecimal(totalCnt);
	        BigDecimal decimal2 = new BigDecimal(visiblePages);
	        BigDecimal totalPage = decimal1.divide(decimal2, 0, BigDecimal.ROUND_UP);
	 
	        int startLimitPage = 0;
	        // 2.mysql limit 범위를 구하기 위해 계산
	        if(startPage==1){
	            startLimitPage = 0;
	        }else{
	            startLimitPage = (startPage-1)*visiblePages;
	        }
	 
	        
	        // Map에다가 키 값을 추가 하고 있다.
	        paramMap.put("start", startLimitPage);
	        paramMap.put("end", visiblePages);
	 
	        // ORACLE
	        // paramMap.put("end", startLimitPage+visiblePages);
	 
	        //jsp 에서 보여줄 정보 추출
	        model.addAttribute("startPage", startPage+"");//현재 페이지      
	        model.addAttribute("totalCnt", totalCnt);//전체 게시물수
	        model.addAttribute("totalPage", totalPage);//페이지 네비게이션에 보여줄 리스트 수
	        //이게 실직적으로 DB까지 내려갔다 옴
	        model.addAttribute("boardList", boardService.getContentList(paramMap));//검색
	 
	        return "boardList";
	 
	    }
	 
	    // 게시글 상세 보기
	    @RequestMapping(value = "view")
	    public String boardView(@RequestParam Map<String, Object> paramMap, Model model) {
	 
	        model.addAttribute("replyList", boardService.getReplyList(paramMap));
	        model.addAttribute("boardView", boardService.getContentView(paramMap));
	 
	        return "boardView";
	 
	    }
	 
	    // 게시글 등록 및 수정
	    @RequestMapping(value = "edit")
	    public String boardEdit(HttpServletRequest request, @RequestParam Map<String, Object> paramMap, Model model) {
	 
	    	System.out.println("Edit");
	    	
	        // Referer 검사
	        String Referer = request.getHeader("referer");
	 
	        if(Referer!=null){// URL로 직접 접근 불가
	            if(paramMap.get("id") != null){ //게시글 수정
	                if(Referer.indexOf("/board/view") > -1){
	 
	                    // 정보를 가져온다.
	                    model.addAttribute("boardView", boardService.getContentView(paramMap));
	                    return "boardEdit";
	                }else{
	                    return "redirect:/board/list";
	                }
	            }else{ // 게시글 등록
	                if(Referer.indexOf("/board/list") > -1){
	                    return "boardEdit";
	                }else{
	                    return "redirect:/board/list";
	                }
	            }
	        }else{
	            return "redirect:/board/list";
	        }
	 
	    }
	 
	    // AJAX 호출 (게시글 등록, 수정)
	    @RequestMapping(value="save", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardSave(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("password").toString(), null);
	        paramMap.put("password", password);
	 
	        // 정보입력
	        int result = boardService.regContent(paramMap);
	 
	        if(result>0){
	            retVal.put("code", "OK");
	            retVal.put("message", "등록에 성공 하였습니다.");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "등록에 실패 하였습니다.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (게시글 삭제)
	    @RequestMapping(value="del", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardDel(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("password").toString(), null);
	        paramMap.put("password", password);
	 
	        // 정보입력
	        int result = boardService.delBoard(paramMap);
	 
	        if(result>0){
	            retVal.put("code", "OK");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "패스워드를 확인해주세요.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (게시글 패스워드 확인)
	    @RequestMapping(value="check", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardCheck(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("password").toString(), null);
	        paramMap.put("password", password);
	 
	        // 정보입력
	        int result = boardService.getBoardCheck(paramMap);
	 
	        if(result>0){
	            retVal.put("code", "OK");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "패스워드를 확인해주세요.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (댓글 등록)
	    @RequestMapping(value="reply/save", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardReplySave(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
	        paramMap.put("reply_password", password);
	 
	        // 정보입력
	        int result = boardService.regReply(paramMap);
	 
	        if(result>0){
	            retVal.put("code", "OK");
	            retVal.put("reply_id", paramMap.get("reply_id"));
	            retVal.put("parent_id", paramMap.get("parent_id"));
	            retVal.put("message", "등록에 성공 하였습니다.");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "등록에 실패 하였습니다.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (댓글 삭제)
	    @RequestMapping(value="reply/del", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardReplyDel(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
	        paramMap.put("reply_password", password);
	 
	        // 정보입력
	        int result = boardService.delReply(paramMap);
	 
	        if(result>0){
	            retVal.put("code", "OK");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "삭제에 실패했습니다. 패스워드를 확인해주세요.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (댓글 패스워드 확인)
	    @RequestMapping(value="reply/check", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardReplyCheck(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
	        paramMap.put("reply_password", password);
	 
	        // 정보입력
	        boolean check = boardService.checkReply(paramMap);
	 
	        if(check){
	            retVal.put("code", "OK");
	            retVal.put("reply_id", paramMap.get("reply_id"));
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "패스워드를 확인해 주세요.");
	        }
	 
	        return retVal;
	 
	    }
	 
	    // AJAX 호출 (댓글 수정)
	    @RequestMapping(value="reply/update", method=RequestMethod.POST)
	    @ResponseBody
	    public Object boardReplyUpdate(@RequestParam Map<String, Object> paramMap) {
	 
	        // 리턴값
	        Map<String, Object> retVal = new HashMap<String, Object>();
	 
	        // 패스워드 암호화
	        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
	        String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
	        paramMap.put("reply_password", password);
	 
	        System.out.println(paramMap);
	 
	        // 정보입력
	        boolean check = boardService.updateReply(paramMap);
	 
	        if(check){
	            retVal.put("code", "OK");
	            retVal.put("reply_id", paramMap.get("reply_id"));
	            retVal.put("message", "수정에 성공 하였습니다.");
	        }else{
	            retVal.put("code", "FAIL");
	            retVal.put("message", "수정에 실패 하였습니다.");
	        }
	 
	        return retVal;
	 
	    }
	    
	    @RequestMapping(value="insertImage", method=RequestMethod.POST)
	    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
	    	
	    	
	    	JsonObject json = new JsonObject();
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html;charset=utf-8");
	 
	        try{
	 
	            String fileName = upload.getOriginalFilename();
	            byte[] bytes = upload.getBytes();
	            String uploadPath = "D:\\upload\\" + fileName;//저장경로
	 
	            System.out.println(uploadPath);
	            
	            out = new FileOutputStream(new File(uploadPath));
	            out.write(bytes);
	            
	            printWriter = response.getWriter();
	            String fileUrl = "/img/" + fileName;//url경로
	 
	            System.out.println(fileUrl);
	            
//	            printWriter.println("{"
//	            		+ "'uploaded' : 1,"
//	                    + "'fileName' :"
//	                    + fileName
//	                    + ","
//	                    +"'url' :"
//	                    + fileUrl
//	                    + "}");
	            
	            
	            json.addProperty("uploaded", 1);
                json.addProperty("fileName", fileName);
                json.addProperty("url", fileUrl);
                printWriter.println(json);
	            printWriter.flush();
	            
	            
	 
	        }catch(IOException e){
	            e.printStackTrace();
	        } finally {
	            try {
	                if (out != null) {
	                    out.close();
	                }
	                if (printWriter != null) {
	                    printWriter.close();
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	 
	        return;
	    }

}
