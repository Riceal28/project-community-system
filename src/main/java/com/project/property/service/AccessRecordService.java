package com.project.property.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.project.property.dao.AccessRecordMapper;
import com.project.property.entity.AccessRecord;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AccessRecordService {
    
    @Resource
    private AccessRecordMapper accessRecordMapper;
    
    public int insertSelective(AccessRecord record) {
        return accessRecordMapper.insertSelective(record);
    }
    
    public PageInfo<AccessRecord> getAccessList(String userName, String createDate, 
                                              Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<AccessRecord> list = accessRecordMapper.selectDataByParam(userName, createDate);
        return new PageInfo<>(list);
    }
    
    public int deleteByPrimaryKey(String ids) {
        return accessRecordMapper.deleteByPrimaryKey(ids);
    }
}