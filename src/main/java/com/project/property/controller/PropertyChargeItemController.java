package com.project.property.controller;

import com.project.property.entity.HouseInfo;
import com.project.property.entity.PropertyChargeItem;
import com.project.property.entity.ResultMessage;
import com.project.property.service.PropertyChargeItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/propertyChargeItem")
public class PropertyChargeItemController {

    /**
     * 业务对象
     */
    @Autowired
    private PropertyChargeItemService propertyChargeItemService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     * @param propertyChargeItem     查询条件
     * @param page      当前页
     * @param limit     每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(PropertyChargeItem propertyChargeItem, Integer page, Integer limit) {
        // 查询数据
        try {
            List<PropertyChargeItem> dataList = propertyChargeItemService.selectDataByPage(propertyChargeItem, page, limit);
            Integer count = propertyChargeItemService.selectDataCount(propertyChargeItem);
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
     * @param propertyChargeItem 更新的对象
     * @return ResultMessage
     */
    @PutMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody PropertyChargeItem propertyChargeItem) {
        try {
            // 执行更新方法
            int result = propertyChargeItemService.updateByPrimaryKeySelective(propertyChargeItem);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Sorry, the property fee item cannot be renamed!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     * @param propertyChargeItem 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody PropertyChargeItem propertyChargeItem) {
        try {
            // 执行更新方法
            int result = propertyChargeItemService.insertSelective(propertyChargeItem);
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
     * @param ids 要删除的ID, 多个用逗号隔开
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String ids) {
        try {
            // 执行方法
            int result = propertyChargeItemService.deleteByPrimaryKey(ids);
            if(result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if(result == -500) {
                return new ResultMessage(207, "Operation failed! There are still referenced information in the deleted information!");
            } else if(result == -600) {
                return new ResultMessage(207, "Property fees are basic fees and cannot be deleted!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch(Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }
}
