package com.project.property.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.extra.mail.MailAccount;
import cn.hutool.extra.mail.MailUtil;
import com.project.property.entity.PropertyChargeItem;
import com.project.property.entity.PropertyChargeVisit;
import com.project.property.entity.ResultMessage;
import com.project.property.entity.User;
import com.project.property.service.PropertyChargeVisitService;
import com.project.property.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping("/propertyChargeVisit")
public class PropertyChargeVisitController {

    /**
     * 业务对象
     */
    @Autowired
    private PropertyChargeVisitService propertyChargeVisitService;

    @Autowired
    private UserService userService;

    @Autowired
    private MailAccount mailAccount;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param propertyChargeVisit     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(PropertyChargeVisit propertyChargeVisit, Integer page, Integer limit) {
        // 查询数据
        try {
            List<PropertyChargeVisit> dataList = propertyChargeVisitService.selectDataByPage(propertyChargeVisit, page, limit);
            Integer count = propertyChargeVisitService.selectDataCount(propertyChargeVisit);
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
     * @param propertyChargeVisit 更新的对象
     * @return ResultMessage
     */
    @PutMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody PropertyChargeVisit propertyChargeVisit) {
        try {
            // 执行方法
            int result = propertyChargeVisitService.updateByPrimaryKeySelective(propertyChargeVisit);
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
     * @param propertyChargeVisit 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody PropertyChargeVisit propertyChargeVisit) {
        try {
            // 执行方法
            int result = propertyChargeVisitService.insertSelective(propertyChargeVisit);
            if(result > 0) {
                // 向用户发送缴费邮件  根据用户名和手机号查询到该用户的信息
                User user = new User();
                user.setUserName(propertyChargeVisit.getUserName());
                user.setPhone(propertyChargeVisit.getPhone());
                User findResult = userService.selectByParam2(user);
                System.out.println("Sending email...");
                // 发送邮件
                ArrayList<String> target = CollUtil.newArrayList(findResult.getEmail());
                MailUtil.send(mailAccount, target, "Community Property",
                        "[Community Property] Dear owner, the bill you need to pay this month has been settled. " +
                                "Please go to the property office to pay it in time. Thank you for your cooperation!", true);
                System.out.println("Sent successfully!");
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
     * @param ids 要删除的ID, 多个用逗号隔开
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String ids) {
        return null;
    }
}
