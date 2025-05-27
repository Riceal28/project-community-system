package com.project.property.controller;

import com.github.pagehelper.PageInfo;
import com.project.property.entity.AccessRecord;
import com.project.property.service.AccessRecordService;
import com.project.property.utils.LayuiTableDataInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/access")
public class AccessRecordController {
    
    @Resource
    private AccessRecordService accessRecordService;
    
    @GetMapping("/getDataByPage")
    public LayuiTableDataInfo getDataByPage(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String createDate,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer limit) {
        
        PageInfo<AccessRecord> pageInfo = accessRecordService.getAccessList(
            userName, createDate, page, limit);
        
        return new LayuiTableDataInfo(pageInfo.getTotal(), pageInfo.getList());
    }
    
    @PostMapping("/submit")
    public String submitAccess(@RequestBody AccessRecord record) {
        try {
            accessRecordService.insertSelective(record);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
}