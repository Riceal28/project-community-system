package com.project.property.controller;

import cn.hutool.core.util.ObjectUtil;
import com.project.property.entity.CarParkCharge;
import com.project.property.entity.ResultMessage;
import com.project.property.service.CarParkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @Since 2022/5/15 14:32
 * @Author Lizuxian
 */
@RestController
@RequestMapping("/asset")
public class AnalysisController {
    /**
     * 业务对象
     */
    @Autowired
    private CarParkService carParkService;

    /**
     * 数据分析统计接口
     *
     * @param carPark
     * @return
     */
    @GetMapping("/charge/analysis")
    public ResultMessage getDataByPage2(CarParkCharge carPark) {
        // 查询数据
        try {
            Map dataList = carParkService.statisticAnalysis();

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
