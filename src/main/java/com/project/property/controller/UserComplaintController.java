package com.project.property.controller;

import cn.hutool.core.util.ObjectUtil;
import com.project.property.entity.*;
import com.project.property.service.UserComplaintService;
import com.project.property.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/userComplaint")
public class UserComplaintController {

    /**
     * 业务对象
     */
    @Autowired
    private UserComplaintService userComplaintService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param userComplaint     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(UserComplaint userComplaint, Integer page, Integer limit) {
        // 查询数据
        try {
            List<UserComplaint> dataList = userComplaintService.selectDataByPage(userComplaint, page, limit);
            Integer count = userComplaintService.selectDataCount(userComplaint);
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
     * 条件 分页查询  适用于Layui数据表格
     * @param userComplaint     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPageWeb")
    public ResultMessage getDataByPageWeb(UserComplaint userComplaint, Integer page, Integer limit) {
        // 查询数据
        try {
            List<UserComplaint> dataList = userComplaintService.selectDataByPage(userComplaint, page, limit);
            Integer count = userComplaintService.selectDataCount(userComplaint);
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
     * @param id 更新的对象ID
     * @return ResultMessage
     */
    @RequestMapping("/updateInfo")
    public ResultMessage updateInfo(String id) {
        try {
            UserComplaint userComplaint = new UserComplaint();
            userComplaint.setId(Integer.parseInt(id));
            userComplaint.setIsSolve("1");
            // 执行更新方法
            int result = userComplaintService.updateByPrimaryKeySelective(userComplaint);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 更新方法
     * @return ResultMessage
     */
    @RequestMapping("/updateInfoByObject")
    public ResultMessage updateInfoByObject(@RequestBody UserComplaint complaint) {
        try {
            // 执行更新方法
            int result = userComplaintService.updateByPrimaryKeySelective(complaint);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     * @param userComplaint 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody UserComplaint userComplaint, HttpServletRequest request) {
        try {
            User webUser = (User) request.getSession().getAttribute("webUser");
            if(webUser == null) {
                return new ResultMessage(207, "Sorry, you are not logged in!");
            }
            userComplaint.setUserName(webUser.getUserName());
            // 执行更新方法
            int result = userComplaintService.insertSelective(userComplaint);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            e.printStackTrace();
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 删除方法
     * @param ids 要删除的ID, 多个用逗号隔开
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String ids) {
        try {
            // 执行更新方法
            int result = userComplaintService.deleteByPrimaryKey(ids);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed! The selected information contains unprocessed information!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 数据分析统计接口
     *
     * @return
     */
    @GetMapping("/statistic")
    public ResultMessage getDataByPage2() {
        // 查询数据
        try {
            Map dataList = userComplaintService.statisticAnalysis();

            if (ObjectUtil.isNotEmpty(dataList)) {
                return new ResultMessage(0, "Query successful!", dataList, null, null);
            } else {
                return new ResultMessage(1, "There is no data to analyze!");
            }
        } catch (Exception e) {
            return new ResultMessage(1, "The query was abnormal:" + e.getMessage());
        }
    }
}
