package com.project.property.controller;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.property.entity.Notice;
import com.project.property.entity.UserComplaint;
import com.project.property.service.MenuService;
import com.project.property.service.NoticeService;
import com.project.property.service.UserComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;


import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@RestController
@RequestMapping("/ai")
public class AIController {
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private UserComplaintService userComplaintService;
    @Autowired
    private MenuService menuService;


    @GetMapping("/forum")
    public ResponseEntity<InputStreamResource> downloadDocx() throws IOException {
        // 1. 创建 Word 文档并写入内容
        XWPFDocument document = new XWPFDocument();
        XWPFParagraph paragraph = document.createParagraph();
        XWPFRun run = paragraph.createRun();
        List<Notice> aLl = noticeService.getALl();
        String prompting ="需要你快速响应，不需要深度思考。我将给你一段来自MySQL的notice数据列表，每一个子项都是‘Notice’,主要字段有标题title," +
                "内容content,用户名userName。这些数据来源于社区居民的论坛，帮我总结这些子项，并分析社区居民的关注点。下面是具体的英文notice数据"+aLl+
                "使用英文回答，只要英文文本，不需要docx格式";
        System.out.println("Successfully get message from database");
        String result = callDeepSeek(prompting);
        run.setText("Forum Information Analysis");
        run.addBreak();
        run.setText(result);
        System.out.println("Successfully get ai message:"+result);
        // 2. 写入内存输出流
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        document.write(out);
        document.close();

        byte[] docxBytes = out.toByteArray();
        InputStreamResource resource = new InputStreamResource(new ByteArrayInputStream(docxBytes));

        // 3. 设置响应头
        String fileName = URLEncoder.encode("Forum Information Analysis.docx", StandardCharsets.UTF_8.toString());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document"));
        headers.setContentDisposition(
                ContentDisposition.builder("attachment").filename(fileName).build());
        headers.setContentLength(docxBytes.length);

        // 4. 返回 ResponseEntity
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

    @GetMapping("/complaint")
    public ResponseEntity<InputStreamResource> downloadComplaintDocx() throws IOException {
        // 1. 创建 Word 文档并写入内容
        XWPFDocument document = new XWPFDocument();
        XWPFParagraph paragraph = document.createParagraph();
        XWPFRun run = paragraph.createRun();
        List<UserComplaint> aLl = userComplaintService.getAll();
        String prompting ="需要你快速响应，不需要深度思考。我将给你一段来自MySQL的complaint数据列表，每一个子项都是‘UserComplaint ’,主要字段有投诉内容complaintInfo," +
                "内容content,用户名userName,投诉是否被解决isSolveStr,居民的反馈feedbackMsg,python分析的用户情感分score,和投诉的评价等级degree,解决投诉的员工employee。这些数据来源于社区居民的投诉信息，帮我总结这些投诉信息，推断居民们的需求，和对管理员的建议。下面是具体的英文complaint数据："+aLl+
                "使用英文回答，只要英文文本，不需要docx格式";
        System.out.println("try to call ai");
        String result = callDeepSeek(prompting);
        run.setText("Complaint Information Analysis");
        run.addBreak();
        run.setText(result);
        System.out.println("Successfully get ai message:"+result);
        // 2. 写入内存输出流
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        document.write(out);
        document.close();

        byte[] docxBytes = out.toByteArray();
        InputStreamResource resource = new InputStreamResource(new ByteArrayInputStream(docxBytes));

        // 3. 设置响应头
        String fileName = URLEncoder.encode("Complaint Information Analysis.docx", StandardCharsets.UTF_8.toString());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document"));
        headers.setContentDisposition(
                ContentDisposition.builder("attachment").filename(fileName).build());
        headers.setContentLength(docxBytes.length);

        // 4. 返回 ResponseEntity
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

    private String callDeepSeek(String prompting){
        String apiToken = "Bearer sk-bfxsbjucxqfvjpfgzevwfvparnmikkqqyiktrtvynesxqgbr";
        String apiUrl = "https://api.siliconflow.cn/v1/chat/completions";

        RestTemplate restTemplate = new RestTemplate();

        // 构建请求体
        Map<String, Object> requestBody = new LinkedHashMap<>();
        requestBody.put("model", "deepseek-ai/DeepSeek-V3");

        List<Map<String, String>> messages = new ArrayList<>();
        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", prompting);
        messages.add(userMessage);
        requestBody.put("messages", messages);

        requestBody.put("stream", false);
        requestBody.put("max_tokens", 512);
        requestBody.put("stop", Collections.singletonList("null"));
        requestBody.put("temperature", 0.7);
        requestBody.put("top_p", 0.7);
        requestBody.put("top_k", 50);
        requestBody.put("frequency_penalty", 0.5);
        requestBody.put("n", 1);

        Map<String, Object> responseFormat = new HashMap<>();
        responseFormat.put("type", "text");
        requestBody.put("response_format", responseFormat);

        Map<String, Object> tool = new HashMap<>();
        tool.put("type", "function");
        Map<String, Object> function = new HashMap<>();
        function.put("description", "<string>");
        function.put("name", "<string>");
        function.put("parameters", new HashMap<>());
        function.put("strict", false);
        tool.put("function", function);
        requestBody.put("tools", Collections.singletonList(tool));

        // 构建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", apiToken);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        System.out.println("Try to call deepseek-ai");
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode root = mapper.readTree(response.getBody());
                return root.path("choices").get(0).path("message").path("content").asText();
            } else {
                return "AI返回失败，状态码：" + response.getStatusCode();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "AI请求异常：" + e.getMessage();
        }
    }

}
