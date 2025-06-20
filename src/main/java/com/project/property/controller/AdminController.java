package com.project.property.controller;

import com.project.property.entity.Admin;
import com.project.property.entity.ResultMessage;
import com.project.property.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@RestController
@RequestMapping("/adminInfo")
public class AdminController {

    /**
     * 业务对象
     */
    @Autowired
    private AdminService adminService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param admin     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(Admin admin, Integer page, Integer limit) {
        // 查询数据
        try {
            List<Admin> dataList = adminService.selectDataByPage(admin, page, limit);
            Integer count = adminService.selectDataCount(admin);
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
     * @param admin 更新的对象
     * @return ResultMessage
     */
    @PutMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody Admin admin, HttpSession session) {
        try {
            // 执行更新方法
            int result = adminService.updateByPrimaryKeySelective(admin);
            if(result > 0) {
                session.invalidate();
                return new ResultMessage(0, "Operation successful");
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
     * 插入方法
     * @param admin 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody Admin admin) {
        try {
            // 执行更新方法
            int result = adminService.insertSelective(admin);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful");
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
     * @param id 要删除的ID
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(Integer id) {
        try {
            // 执行更新方法
            int result = adminService.deleteByPrimaryKey(id);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed! At least one administrator!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }
}
