package com.project.property.dao;

import com.project.property.entity.AccessRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper  // 添加这个注解
public interface AccessRecordMapper {
    // 插入记录
    int insertSelective(AccessRecord record);
    
    // 根据条件查询
    List<AccessRecord> selectDataByParam(@Param("userName") String userName, 
                                       @Param("createDate") String createDate);
    
    // 根据id删除
    int deleteByPrimaryKey(String ids);
}