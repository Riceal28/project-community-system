package com.project.property.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LayuiTableDataInfo {
    private Long count;        // 总记录数
    private List<?> data;      // 列表数据
    private Integer code = 0;  // 状态码，0表示成功
    private String msg = "";   // 提示信息
    
    public LayuiTableDataInfo(Long count, List<?> data) {
        this.count = count;
        this.data = data;
    }
}