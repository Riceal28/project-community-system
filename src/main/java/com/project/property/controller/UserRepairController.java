package com.project.property.controller;

import cn.hutool.core.util.ObjectUtil;
import com.project.property.entity.*;
import com.project.property.entity.UserRepair;
import com.project.property.service.UserRepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/userRepair")
public class UserRepairController {

    /**
     * 业务对象
     */
    @Autowired
    private UserRepairService userRepairService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param userRepair     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(UserRepair userRepair, Integer page, Integer limit) {
        // 查询数据
        try {
            List<UserRepair> dataList = userRepairService.selectDataByPage(userRepair, page, limit);
            Integer count = userRepairService.selectDataCount(userRepair);
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
     * @param userRepair     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPageWeb")
    public ResultMessage getDataByPageWeb(UserRepair userRepair, Integer page, Integer limit) {
        // 查询数据
        try {
            List<UserRepair> dataList = userRepairService.selectDataByPage(userRepair, page, limit);
            Integer count = userRepairService.selectDataCount(userRepair);
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
    @GetMapping("/updateInfo")
    public ResultMessage updateInfo(String id) {
        try {
            UserRepair userRepair = new UserRepair();
            userRepair.setId(Integer.parseInt(id));
            userRepair.setIsSolve("1");
            // 执行更新方法
            int result = userRepairService.updateByPrimaryKeySelective(userRepair);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful！");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 更新方法
     * @return ResultMessage
     */
    @RequestMapping("/updateInfoByObject")
    public ResultMessage updateInfoByObject(@RequestBody UserRepair repair) {
        try {
            // 执行更新方法
            int result = userRepairService.updateByPrimaryKeySelective(repair);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful！");
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
     * @param userRepair 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody UserRepair userRepair, HttpServletRequest request) {
        try {
            User webUser = (User) request.getSession().getAttribute("webUser");
            if(webUser == null) {
                return new ResultMessage(207, "You are not logged in!");
            }
            // 执行更新方法
            int result = userRepairService.insertSelective(userRepair);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful！");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
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
            int result = userRepairService.deleteByPrimaryKey(ids);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful！");
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
            Map dataList = userRepairService.statisticAnalysis();

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
