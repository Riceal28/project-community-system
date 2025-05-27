package com.project.property.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccessRecord {
    private Integer id;
    private String userName;
    private String phone;
    private String healthCodePath;
    private String travelCodePath;
    private Integer type;        // 是否疑似病例 0否 1是
    private Integer type1;       // 是否隔离 0否 1是
    private String type2;        // 疫苗接种情况
    private String createDate;   // 填报时间
    private String desc;         // 备注信息
}