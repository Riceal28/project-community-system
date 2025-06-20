package com.project.property.controller;

import cn.hutool.core.date.DateUtil;
import com.project.property.entity.ResultMessage;
import com.project.property.entity.Notice;
import com.project.property.service.NoticeService;
import com.project.property.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Description 公告模块控制器
 */
@RestController
@RequestMapping("/notice")
public class NoticeController {

    /**
     * 业务对象
     */
    @Autowired
    private NoticeService noticeService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param notice     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(Notice notice, Integer page, Integer limit) {
        // 查询数据
        try {
            List<Notice> dataList = noticeService.selectDataByPage(notice, page, limit);
            Integer count = noticeService.selectDataCount(notice);
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
     * 更新方法
     * @param notice 更新的对象
     * @return ResultMessage
     */
    @PutMapping("updateInfo")
    public ResultMessage updateInfo(@RequestBody Notice notice) {
        try {
            // 执行更新方法
            notice.setCreateDate(DateUtil.today());
            int result = noticeService.updateByPrimaryKeySelective(notice);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     * @param notice 插入的对象
     * @return ResultMessage
     */
    @PostMapping("insertInfo")
    public ResultMessage insertInfo(@RequestBody Notice notice) {
        try {
            // 执行新增方法
            notice.setCreateDate(DateUtil.today());
            int result = noticeService.insertSelective(notice);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 删除方法
     * @param delIds 要删除的ID, 多个用逗号隔开
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String delIds) {
        try {
            // 执行新增方法
            int result = noticeService.deleteByPrimaryKey(delIds);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed! There are still referenced information in the deleted information!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }
}
