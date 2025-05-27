package com.project.property;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.project.property.dao")
public class PropertyAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(PropertyAdminApplication.class, args);
    }

}
