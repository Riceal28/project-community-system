package com.project.property.controller;

import com.project.property.entity.PropertyPayVisit;
import com.project.property.entity.ResultMessage;
import com.project.property.service.PropertyPayVisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/propertyPayVisit")
public class PropertyPayVisitController {

    /**
     * 业务对象
     */
    @Autowired
    private PropertyPayVisitService propertyPayVisitService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param propertyPayVisit     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(PropertyPayVisit propertyPayVisit, Integer page, Integer limit) {
        // 查询数据
        try {
            List<PropertyPayVisit> dataList = propertyPayVisitService.selectDataByPage(propertyPayVisit, page, limit);
            Integer count = propertyPayVisitService.selectDataCount(propertyPayVisit);
            if(dataList != null && dataList.size() > 0) {
                return new ResultMessage(0, "Query successful!", dataList, count, limit);
            } else {
                return new ResultMessage(1, "No relevant data yet!");
            }
        } catch(Exception e) {
            return new ResultMessage(1, "The query was abnormal:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     * @param propertyPayVisit 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody PropertyPayVisit propertyPayVisit) {
        try {
            // 执行更新方法
            int result = propertyPayVisitService.insertSelective(propertyPayVisit);
            if(result > 0) {
                return new ResultMessage(0, "Pay successfully!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }
}
