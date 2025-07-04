package com.project.property.controller;

import com.project.property.entity.Admin;
import com.project.property.entity.CarPark;
import com.project.property.entity.CarParkCharge;
import com.project.property.entity.ResultMessage;
import com.project.property.service.CarParkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/carPark")
public class CarParkController {

    /**
     * 业务对象
     */
    @Autowired
    private CarParkService carParkService;

    /**
     * 条件 分页查询  适用于Layui数据表格
     *
     * @param carPark 查询条件
     * @param page    当前页
     * @param limit   每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/getDataByPage")
    public ResultMessage getDataByPage(CarPark carPark, Integer page, Integer limit) {
        // 查询数据
        try {
            List<CarPark> dataList = carParkService.selectDataByPage(carPark, page, limit);
            Integer count = carParkService.selectDataCount(carPark);
            if (dataList != null && dataList.size() > 0) {
                return new ResultMessage(0, "Query successful!", dataList, count, limit);
            } else {
                return new ResultMessage(1, "No relevant data yet!");
            }
        } catch (Exception e) {
            return new ResultMessage(1, "The query was abnormal:" + e.getMessage());
        }
    }

    /**
     * 更新方法
     *
     * @param carPark 更新的对象
     * @return ResultMessage
     */
    @PostMapping("/updateInfo")
    public ResultMessage updateInfo(@RequestBody CarPark carPark) {
        try {
            // 执行更新方法
            int result = carParkService.updateByPrimaryKeySelective(carPark);
            if (result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch (Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     *
     * @param carPark 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/insertInfo")
    public ResultMessage insertInfo(@RequestBody CarPark carPark) {
        try {
            // 执行新增方法
            int result = carParkService.insertSelective(carPark);
            if (result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch (Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 删除方法
     *
     * @param ids 要删除的ID, 多个用逗号隔开
     * @return ResultMessage
     */
    @GetMapping("/deleteInfo")
    public ResultMessage deleteInfo(String ids) {
        try {
            // 执行新增方法
            int result = carParkService.deleteByPrimaryKey(ids);
            if (result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else if (result == -500) {
                return new ResultMessage(207, "Operation failed! There are still referenced information in the deleted information!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch (Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 插入方法
     *
     * @param carPark 插入的对象
     * @return ResultMessage
     */
    @PostMapping("/charge/insertInfo")
    public ResultMessage insertInfo2(@RequestBody CarParkCharge carPark) {
        try {
            // 执行新增方法
            carPark.setChargeDate(new Date());
            int result = carParkService.insertCharge(carPark);
            if (result > 0) {
                return new ResultMessage(0, "Operation successful!");
            } else {
                return new ResultMessage(207, "Operation failed! Please try again later!");
            }
        } catch (Exception e) {
            return new ResultMessage(500, "Operation exception:" + e.getMessage());
        }
    }

    /**
     * 条件 分页查询  适用于Layui数据表格
     *
     * @param carPark 查询条件
     * @param page    当前页
     * @param limit   每页显示的条数
     * @return ResultMessage
     */
    @GetMapping("/charge/getDataByPage")
    public ResultMessage getDataByPage2(CarParkCharge carPark, Integer page, Integer limit) {
        // 查询数据
        try {
            List<CarParkCharge> dataList = carParkService.selectChargeDataByPage(carPark, page, limit);
            Integer count = carParkService.selectDataCount2(carPark);
            if (dataList != null && dataList.size() > 0) {
                return new ResultMessage(0, "Query successful!", dataList, count, limit);
            } else {
                return new ResultMessage(1, "No relevant data yet!");
            }
        } catch (Exception e) {
            return new ResultMessage(1, "The query was abnormal:" + e.getMessage());
        }
    }
}
