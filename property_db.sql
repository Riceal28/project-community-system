/*
SQLyog Professional v12.09 (64 bit)
MySQL - 5.7.24-log : Database - property_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`property_db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `property_db`;

/*Table structure for table `access_visit` */

DROP TABLE IF EXISTS `access_visit`;

CREATE TABLE `access_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '用户手机号',
  `create_date` datetime DEFAULT NULL COMMENT '登记时间',
  `type` varchar(2) DEFAULT NULL COMMENT '是否疑似病例',
  `desc` varchar(255) DEFAULT NULL COMMENT '事由',
  `user_id` int(11) DEFAULT NULL COMMENT '登记的用户ID',
  `type1` varchar(2) DEFAULT NULL COMMENT '是否隔离',
  `type2` varchar(2) DEFAULT NULL COMMENT '是否接种疫苗',
  `health_code_path` varchar(60) DEFAULT NULL COMMENT '健康码上传图',
  `travel_code_path` varchar(60) DEFAULT NULL COMMENT '行程码上传图',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='出入登记表';

/*Data for the table `access_visit` */

insert  into `access_visit`(`id`,`user_name`,`phone`,`create_date`,`type`,`desc`,`user_id`,`type1`,`type2`,`health_code_path`,`travel_code_path`) values (8,'张三','15566778899','2022-05-14 16:39:00','0','',1,'0','一针','images\\2022-05\\c8467b35-8979-4e0a-bd2b-8feac7587a9f.jpeg','images\\2022-05\\753e7e49-6372-4ec6-8f5a-ec2d31d14343.jpeg'),(9,'李四','15566889966','2022-05-14 16:56:32','0','都健康的很！',2,'0','二针','images\\2022-05\\562b7b73-235c-48e3-aeaa-5ede8508e4d5.jpeg','images\\2022-05\\86844fc1-f99d-41a9-956e-1eed15050f8b.jpeg');

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用户名',
  `login_name` varchar(32) DEFAULT NULL COMMENT '登录后显示的名字',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码（原密码sha1加密  盐值 sha256加密，之后两个相加再进行MD5加密）',
  `salt` varchar(255) DEFAULT NULL COMMENT '加密的盐值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='系统管理员表 ';

/*Data for the table `admin` */

insert  into `admin`(`id`,`user_name`,`login_name`,`password`,`salt`) values (000001,'admin','超级管理员','ca9c045633b97ad28affb6ba09b2062e','b33cee43-c5f4-4521-aef1-0a508fed2daf'),(000006,'test','测试','68867943fd0f8c0714a682b82f6e8993','12d83eb8-0113-408f-a76c-19e201e2b86e');

/*Table structure for table `car_park` */

DROP TABLE IF EXISTS `car_park`;

CREATE TABLE `car_park` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `owner_name` varchar(32) DEFAULT NULL COMMENT '业主名（如果售出则不可为空）',
  `phone` varchar(32) DEFAULT NULL COMMENT '业主联系电话',
  `park_state` varchar(32) DEFAULT NULL COMMENT '车位状态（0未售出，1已售出）',
  `car_park_type` varchar(64) DEFAULT NULL COMMENT '车位类型',
  `car_park_info` varchar(30) DEFAULT NULL COMMENT '车位信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='停车场表 ';

/*Data for the table `car_park` */

insert  into `car_park`(`id`,`owner_name`,`phone`,`park_state`,`car_park_type`,`car_park_info`) values (000001,'张三','15566778899','1','地下停车位','A-101'),(000002,'','','0','地下停车位','A-102'),(000003,'','','0','地下停车位','A-103'),(000004,'','','0','地下停车位','A-104'),(000006,'','','0','地下停车位','A-202'),(000007,'','','0','地面停车位','F-301'),(000008,NULL,NULL,NULL,'地面停车位','F-101'),(000009,NULL,NULL,NULL,'地面停车位','L-120'),(000010,NULL,NULL,NULL,'地面停车位','F-688');

/*Table structure for table `car_park_charge` */

DROP TABLE IF EXISTS `car_park_charge`;

CREATE TABLE `car_park_charge` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `car_park_id` int(11) NOT NULL COMMENT '车位ID',
  `owner_name` varchar(32) DEFAULT NULL COMMENT '业主名',
  `phone` varchar(32) DEFAULT NULL COMMENT '业主联系电话',
  `fee` decimal(12,2) DEFAULT NULL COMMENT '费用',
  `charge_date` datetime DEFAULT NULL COMMENT '收费日期',
  `read_name` varchar(32) DEFAULT NULL COMMENT '收费人',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '缴费方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='停车场收费记录 ';

/*Data for the table `car_park_charge` */

insert  into `car_park_charge`(`id`,`user_id`,`car_park_id`,`owner_name`,`phone`,`fee`,`charge_date`,`read_name`,`pay_type`) values (000008,1,1,'张三','15566778899','30.00','2022-04-28 04:02:23','管理员','现金'),(000009,2,8,'李四','15566889966','50.00','2022-04-28 04:30:15','管理员','现金'),(000010,8,6,'住户1','15566888811','60.80','2022-04-29 12:32:39','管理员','支付宝'),(000011,8,8,'住户1','15566888811','109.00','2022-04-29 16:33:11','管理员','微信'),(000012,2,3,'李四','15566889966','96.00','2022-05-15 16:34:36','管理员','支付宝'),(000013,1,8,'张三','15566778899','27.90','2022-05-15 16:35:14','管理员','微信'),(000014,8,9,'住户1','15566888811','128.90','2022-05-15 19:35:06','管理员','现金'),(000015,1,4,'张三','15566778899','189.90','2022-05-15 19:43:52','管理员','现金'),(000016,2,6,'李四','15566889966','182.00','2022-05-16 23:12:17','管理员','现金'),(000017,1,10,'张三','15566778899','198.00','2022-05-17 01:03:57','管理员','支付宝');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) DEFAULT NULL COMMENT '评价人ID',
  `content` varchar(2048) DEFAULT NULL COMMENT '评价内容',
  `create_date` datetime DEFAULT NULL COMMENT '评价内容',
  `notice_id` int(11) DEFAULT NULL COMMENT '评价的那条公告',
  `is_delete` varchar(2) DEFAULT '0' COMMENT '0没删除 1用户删除 2管理员删除',
  `score` varchar(32) DEFAULT NULL COMMENT '情感分值',
  `degree` varchar(10) DEFAULT NULL COMMENT '评论等级（好中差）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='评论表';

/*Data for the table `comment` */

insert  into `comment`(`id`,`user_id`,`content`,`create_date`,`notice_id`,`is_delete`,`score`,`degree`) values (10,1,'很棒哦，爱了爱了！','2022-05-13 00:26:50',12,'0','6.48','好'),(11,1,'搞什么嘛，物业费收这么贵！','2022-05-13 00:27:10',13,'0','-5.22','差'),(12,1,'很不错哦！','2022-05-15 19:33:17',12,'0','5.44','中'),(13,1,'这收的都是啥玩意？','2022-05-15 19:33:42',13,'0','-2.92','差');

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `emp_name` varchar(64) DEFAULT NULL COMMENT '员工名',
  `emp_phone` varchar(32) DEFAULT NULL COMMENT '员工电话',
  `emp_sex` varchar(32) DEFAULT NULL COMMENT '员工性别',
  `emp_id_card` varchar(32) DEFAULT NULL COMMENT '员工身份证号',
  `emp_age` int(11) DEFAULT NULL COMMENT '员工年龄',
  `emp_address` varchar(255) DEFAULT NULL COMMENT '员工住址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='员工表';

/*Data for the table `employee` */

insert  into `employee`(`id`,`emp_name`,`emp_phone`,`emp_sex`,`emp_id_card`,`emp_age`,`emp_address`) values (2,'工作人员1','13555667766','男','320724199903195713',23,'辽宁省鞍山市台安县水岸名都'),(3,'工作人员2','15544666655','女','210321199908089008',22,'辽宁省鞍山市台安县水岸名都');

/*Table structure for table `house_info` */

DROP TABLE IF EXISTS `house_info`;

CREATE TABLE `house_info` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `parent_building` varchar(32) DEFAULT NULL COMMENT '所属楼宇',
  `parent_unit` varchar(32) DEFAULT NULL COMMENT '所属单元',
  `parent_floor` varchar(32) DEFAULT NULL COMMENT '所属楼层',
  `house_num` varchar(32) DEFAULT NULL COMMENT '房间号',
  `house_area` varchar(32) DEFAULT NULL COMMENT '房间大小',
  `house_type` varchar(32) DEFAULT NULL COMMENT '房间户型',
  `is_sold` varchar(32) DEFAULT NULL COMMENT '是否售出：0未售出1已售出',
  `owner_name` varchar(32) DEFAULT NULL COMMENT '业主名（如果售出则不可为空）',
  `phone` varchar(32) DEFAULT NULL COMMENT '业主联系电话（如果售出则不可为空）',
  `user_id` int(11) DEFAULT NULL COMMENT '绑定的住户ID（已绑定也代表已售出）',
  `home_state` int(11) DEFAULT NULL COMMENT '房屋状态（0未出租，1出租）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='住房详细信息 ';

/*Data for the table `house_info` */

insert  into `house_info`(`id`,`parent_building`,`parent_unit`,`parent_floor`,`house_num`,`house_area`,`house_type`,`is_sold`,`owner_name`,`phone`,`user_id`,`home_state`) values (000001,'1','1','1','101','110','三室一厅一厨两卫','1','冰冰','13788889999',12,NULL),(000002,'1','1','1','102','110','三室一厅一厨两卫','3','李四','15566889966',2,NULL),(000003,'1','1','2','201','110','三室一厅一厨两卫','1','李四','15566889966',2,NULL),(000006,'1','1','3','302','110','三室一厅一厨两卫','1','张三','15566778899',1,NULL),(000007,'1','1','4','401','110','三室一厅一厨两卫','1','张三','15566778899',1,NULL),(000008,'1','1','4','401','110','三室一厅一厨两卫','1','张三','15566778899',1,NULL),(000009,'1','1','5','501','110','三室一厅一厨两卫','1','张三','15566778899',1,NULL),(000010,'1','1','5','502','110','三室一厅一厨两卫','1','张三','15566778899',1,NULL),(000011,'1','1','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000012,'1','1','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000013,'1','1','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000014,'1','1','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000015,'1','2','1','101','110','三室一厅一厨两卫','1','李四','15566889966',2,NULL),(000016,'1','2','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000017,'1','2','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000018,'1','2','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000019,'1','2','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000020,'1','2','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000021,'1','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000022,'1','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000023,'1','2','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000024,'1','2','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000025,'1','2','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000026,'1','2','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000027,'1','2','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000028,'1','2','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000029,'1','3','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000030,'1','3','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000031,'1','3','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000032,'1','3','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000033,'1','3','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000034,'1','3','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000035,'1','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000036,'1','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000037,'1','3','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000038,'1','3','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000039,'1','3','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000040,'1','3','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000041,'1','3','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000042,'1','3','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000043,'2','1','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000044,'2','1','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000045,'2','1','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000046,'2','1','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000047,'2','1','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000048,'2','1','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000049,'2','1','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000050,'2','1','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000051,'2','1','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000052,'2','1','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000053,'2','1','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000054,'2','1','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000055,'2','1','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000056,'2','1','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000057,'2','2','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000058,'2','2','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000059,'2','2','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000060,'2','2','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000061,'2','2','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000062,'2','2','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000063,'2','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000064,'2','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000065,'2','2','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000066,'2','2','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000067,'2','2','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000068,'2','2','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000069,'2','2','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000070,'2','2','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000071,'2','3','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000072,'2','3','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000073,'2','3','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000074,'2','3','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000075,'2','3','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000076,'2','3','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000077,'2','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000078,'2','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000079,'2','3','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000080,'2','3','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000081,'2','3','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000082,'2','3','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000083,'2','3','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000084,'2','3','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000085,'3','1','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000086,'3','1','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000087,'3','1','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000088,'3','1','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000089,'3','1','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000090,'3','1','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000091,'3','1','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000092,'3','1','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000093,'3','1','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000094,'3','1','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000095,'3','1','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000096,'3','1','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000097,'3','1','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000098,'3','1','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000099,'3','2','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000100,'3','2','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000101,'3','2','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000102,'3','2','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000103,'3','2','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000104,'3','2','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000105,'3','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000106,'3','2','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000107,'3','2','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000108,'3','2','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000109,'3','2','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000110,'3','2','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000111,'3','2','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000112,'3','2','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000113,'3','3','1','101','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000114,'3','3','1','102','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000115,'3','3','2','201','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000116,'3','3','2','202','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000117,'3','3','3','301','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000118,'3','3','3','302','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000119,'3','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000120,'3','3','4','401','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000121,'3','3','5','501','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000122,'3','3','5','502','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000123,'3','3','6','601','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000124,'3','3','6','602','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000125,'3','3','7','701','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000126,'3','3','7','702','110','三室一厅一厨两卫','0',NULL,NULL,NULL,NULL),(000127,'2','1','1','103','126','4房1厅','0',NULL,NULL,NULL,NULL);

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `parent_id` int(6) unsigned zerofill DEFAULT NULL COMMENT '父菜单ID',
  `menu_name` varchar(255) DEFAULT NULL COMMENT '菜单名',
  `url` varchar(512) DEFAULT NULL COMMENT '跳转地址',
  `icon_name` varchar(255) DEFAULT NULL COMMENT '图标名',
  `sort` decimal(10,2) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `menu` */

insert  into `menu`(`id`,`parent_id`,`menu_name`,`url`,`icon_name`,`sort`) values (000001,NULL,'楼宇管理','building/toBuildingPage','&#xe6fc;','8.00'),(000002,NULL,'房屋管理','house/toHousePage','&#xe6fb;','9.00'),(000005,NULL,'物业收费管理','','&#xe726;','3.00'),(000003,NULL,'车位收费管理','carPark/toCarParkPage','&#xe6e3;','2.00'),(000051,000005,'收费项目管理','propertyChargeItem/toPropertyChargeItemPage','&#xe6ab;','3.10'),(000052,000005,'抄表管理','propertyChargeVisit/toPropertyChargeVisitPage','&#xe6a2;','3.20'),(000053,000005,'缴费记录管理','propertyPayVisit/toPropertyPayVisitPage','&#xe70c;','3.30'),(000004,NULL,'住户管理','user/toUserPage','&#xe6b8;','7.00'),(000007,NULL,'投诉信息管理','userComplaint/toUserComplaintPage','&#xe6c7;','4.00'),(000006,NULL,'报修信息管理','userRepair/toUserRepairPage','&#xe6d4;','5.00'),(000011,NULL,'系统管理','','&#xe70b;','13.00'),(000008,NULL,'公告管理',NULL,'&#xe6b3;','1.00'),(000055,NULL,'疫情打卡管理','accessVisit/toDataPage','&#xe744;','6.00'),(000013,000008,'公告评论管理','comment/toDataPage','&#xe69b;','1.20'),(000009,NULL,'员工管理','employee/toDataPage','&#xe6c7;','10.00'),(000056,NULL,'统计分析','asset/statisticAnalysis','&#xe70c;','12.00'),(000058,000008,'公告信息管理','notice/toDataPage','&#xe6b3;','1.10'),(000059,000011,'系统用户管理','adminInfo/toAdminPage',NULL,'13.10'),(000060,000011,'修改信息',NULL,'&#xe82b;','13.20'),(000061,NULL,'车位管理','carPark/toCarParkMainPage','&#xe6e3;','9.90');

/*Table structure for table `menu_admin_relation` */

DROP TABLE IF EXISTS `menu_admin_relation`;

CREATE TABLE `menu_admin_relation` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(6) unsigned zerofill DEFAULT NULL COMMENT '管理员ID',
  `menu_id` int(6) unsigned zerofill DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='菜单与管理员管理表';

/*Data for the table `menu_admin_relation` */

insert  into `menu_admin_relation`(`id`,`user_id`,`menu_id`) values (000001,000001,000001),(000002,000001,000002),(000003,000001,000003),(000004,000001,000005),(000005,000001,000051),(000006,000001,000052),(000007,000001,000053),(000008,000001,000004),(000009,000001,000007),(000010,000001,000006),(000011,000001,000011),(000012,000003,000001),(000013,000003,000002),(000014,000003,000005),(000015,000003,000003),(000016,000003,000051),(000017,000003,000052),(000018,000003,000053),(000019,000003,000004),(000020,000003,000007),(000021,000003,000006),(000022,000003,000011),(000023,000004,000001),(000024,000004,000002),(000025,000004,000005),(000026,000004,000003),(000027,000004,000051),(000028,000004,000052),(000029,000004,000053),(000030,000004,000004),(000031,000004,000007),(000032,000004,000006),(000033,000004,000011),(000034,000005,000001),(000035,000005,000002),(000036,000005,000005),(000037,000005,000003),(000038,000005,000051),(000039,000005,000052),(000040,000005,000053),(000041,000005,000004),(000042,000005,000007),(000043,000005,000006),(000044,000005,000011),(000045,000001,000008),(000046,000001,000055),(000047,000003,000055),(000048,000004,000055),(000049,000005,000055),(000050,000003,000008),(000051,000004,000008),(000052,000005,000008),(000053,000001,000013),(000054,000003,000013),(000055,000004,000013),(000056,000005,000013),(000057,000001,000009),(000058,000006,000001),(000059,000006,000002),(000060,000006,000005),(000061,000006,000003),(000062,000006,000051),(000063,000006,000052),(000064,000006,000053),(000065,000006,000004),(000066,000006,000007),(000067,000006,000006),(000068,000006,000011),(000069,000006,000008),(000070,000006,000055),(000071,000006,000013),(000072,000006,000009),(000073,000001,000056),(000074,000001,000058),(000075,000001,000059),(000076,000001,000060),(000077,000001,000061);

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `title` varchar(255) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(255) DEFAULT NULL COMMENT '公告内容',
  `create_date` date DEFAULT NULL COMMENT '发布时间',
  `news_img` varchar(255) DEFAULT NULL COMMENT '公告图片',
  `user_name` varchar(255) DEFAULT NULL COMMENT '作者',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='公告表';

/*Data for the table `notice` */

insert  into `notice`(`id`,`title`,`content`,`create_date`,`news_img`,`user_name`,`user_id`) values (12,'失物招领','失物招领','2022-04-30','128000dfa4bf4e3ba6c5cf7384558c25.jpg','住户1',8),(13,'交物业费','交物业费','2022-04-30','e42d87bd4d67473391fa6fa6cdb01413.jpg','超级管理员',NULL);

/*Table structure for table `property_charge_item` */

DROP TABLE IF EXISTS `property_charge_item`;

CREATE TABLE `property_charge_item` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `charge_name` varchar(32) DEFAULT NULL COMMENT '收费项目名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `item_price` int(11) DEFAULT NULL COMMENT '项目单价',
  `price_desc` varchar(255) DEFAULT NULL COMMENT '价格描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='物业收费项目信息表 ';

/*Data for the table `property_charge_item` */

insert  into `property_charge_item`(`id`,`charge_name`,`create_date`,`item_price`,`price_desc`) values (000008,'低层住宅物业费','2022-04-29 21:56:32',50,'每平米0.5元'),(000009,'高层住宅物业费','2022-04-29 21:57:21',80,'每平米0.8元'),(000010,'车位费','2022-04-30 01:08:00',8000,NULL),(000011,'测试','2022-05-08 19:35:43',100,'测试'),(000012,'物业','2022-05-08 19:35:54',100,'1');

/*Table structure for table `property_charge_visit` */

DROP TABLE IF EXISTS `property_charge_visit`;

CREATE TABLE `property_charge_visit` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `item_id` int(11) DEFAULT NULL COMMENT '收费项目ID',
  `item_name` varchar(64) DEFAULT NULL COMMENT '收费项名称',
  `house_id` int(11) DEFAULT NULL COMMENT '住房ID',
  `building_num` varchar(32) DEFAULT NULL COMMENT '楼宇号',
  `unit_num` varchar(32) DEFAULT NULL COMMENT '单元号',
  `house_num` varchar(32) DEFAULT NULL COMMENT '房间号',
  `user_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '客户手机号',
  `price` int(11) DEFAULT NULL COMMENT '费用',
  `prev_month_count` int(11) DEFAULT NULL COMMENT '上月读数',
  `curr_month_count` int(11) DEFAULT NULL COMMENT '本月读数',
  `use_count` int(11) DEFAULT NULL COMMENT '本次用量',
  `visit_date` datetime DEFAULT NULL COMMENT '录入时间',
  `read_date` datetime DEFAULT NULL COMMENT '抄表时间',
  `read_name` varchar(32) DEFAULT NULL COMMENT '抄表人',
  `visit_status` varchar(32) DEFAULT NULL COMMENT '记录状态（0已缴费  1未交费）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='物业收费记录信息表 ';

/*Data for the table `property_charge_visit` */

insert  into `property_charge_visit`(`id`,`item_id`,`item_name`,`house_id`,`building_num`,`unit_num`,`house_num`,`user_name`,`phone`,`price`,`prev_month_count`,`curr_month_count`,`use_count`,`visit_date`,`read_date`,`read_name`,`visit_status`) values (000010,10,'车位费',2,'1','1','102','张三','15566778899',8000,0,1,1,NULL,'2022-04-01 00:00:00','11','0'),(000011,11,'测试',2,'1','1','102','张三','15566778899',100,0,1,1,NULL,'2022-04-01 00:00:00','1','0'),(000014,9,'高层住宅物业费',2,'1','1','102','张三','15566778899',8800,NULL,NULL,NULL,NULL,'2022-04-08 19:57:06','张三','0'),(000015,8,'低层住宅物业费',3,'1','1','201','李四','15566889966',5500,NULL,NULL,NULL,NULL,'2022-05-01 00:00:00','管理员','0'),(000016,8,'低层住宅物业费',3,'1','1','201','李四','15566889966',5500,NULL,NULL,NULL,NULL,'2022-05-01 00:00:00','管理员','0'),(000018,8,'低层住宅物业费',2,'1','1','102','李四','15566889966',5500,NULL,NULL,NULL,NULL,'2022-05-01 00:00:00','管理员','1'),(000019,8,'低层住宅物业费',1,'1','1','101','冰冰','13788889999',5500,NULL,NULL,NULL,NULL,'2023-01-01 00:00:00','管理员','0');

/*Table structure for table `property_pay_visit` */

DROP TABLE IF EXISTS `property_pay_visit`;

CREATE TABLE `property_pay_visit` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `charge_id` int(11) NOT NULL COMMENT '对应物业收费记录表的ID',
  `building_num` varchar(32) DEFAULT NULL COMMENT '楼宇号',
  `unit_num` varchar(32) DEFAULT NULL COMMENT '单元号',
  `house_num` varchar(32) DEFAULT NULL COMMENT '房间号',
  `client_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `item_name` varchar(32) DEFAULT NULL COMMENT '收费项目',
  `pay_money` int(11) DEFAULT NULL COMMENT '缴费金额（单位：分）',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '缴费方式',
  `charge_person` varchar(32) DEFAULT NULL COMMENT '收费人员',
  `pay_date` datetime DEFAULT NULL COMMENT '缴费时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='物业缴费记录信息表 ';

/*Data for the table `property_pay_visit` */

insert  into `property_pay_visit`(`id`,`charge_id`,`building_num`,`unit_num`,`house_num`,`client_name`,`item_name`,`pay_money`,`pay_type`,`charge_person`,`pay_date`) values (000005,10,'1','1','102','张三','车位费',8000,'微信','1','2022-04-08 19:09:04'),(000006,14,'1','1','102','张三','高层住宅物业费',8800,'现金','123','2022-04-12 22:27:39'),(000007,11,'1','1','102','张三','测试',100,'支付宝','123','2022-04-12 22:27:49'),(000008,16,'1','1','201','李四','低层住宅物业费',5500,'现金','管理员','2022-05-15 17:09:25'),(000009,15,'1','1','201','李四','低层住宅物业费',5500,'现金','管理员','2022-05-15 19:40:59'),(000010,10,'1','1','102','张三','车位费',8000,'现金','管理员','2022-05-15 19:44:26'),(000011,19,'1','1','101','冰冰','低层住宅物业费',5500,'现金','管理员','2023-01-17 00:57:41');

/*Table structure for table `unit_building` */

DROP TABLE IF EXISTS `unit_building`;

CREATE TABLE `unit_building` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `building_num` int(11) DEFAULT NULL COMMENT '楼宇号',
  `unit_count` int(11) DEFAULT NULL COMMENT '单元数量',
  `floor_count` int(11) DEFAULT NULL COMMENT '楼层',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='楼宇信息表 ';

/*Data for the table `unit_building` */

insert  into `unit_building`(`id`,`building_num`,`unit_count`,`floor_count`) values (000002,2,3,7),(000003,3,3,7),(000004,5,2,21),(000005,6,2,21),(000007,7,3,21),(000008,1,3,10);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_name` varchar(128) DEFAULT NULL COMMENT '用户姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `card_num` varchar(32) DEFAULT NULL COMMENT '身份证号',
  `sex` varchar(32) DEFAULT NULL COMMENT '性别',
  `nation` varchar(32) DEFAULT NULL COMMENT '民族',
  `register_address` varchar(32) DEFAULT NULL COMMENT '户籍地址',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  `password` varchar(255) DEFAULT NULL COMMENT '用户密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='住户信息表 ';

/*Data for the table `user` */

insert  into `user`(`id`,`user_name`,`phone`,`card_num`,`sex`,`nation`,`register_address`,`email`,`password`) values (000001,'张三','15566778899','11010519491231003X','男',NULL,'北京','857685038@qq.com','1234'),(000002,'李四','15566889966','11010519491231004X','女',NULL,'北京','943701114@qq.com','1234'),(000008,'住户1','15566888811','1101052199908080909','男',NULL,NULL,'857685038@qq.com','1234'),(000009,'住户2','15566888822','210321199807115019','男',NULL,'辽宁','857685038@qq.com','1234'),(000010,'琳琳','13782131238','',NULL,NULL,NULL,'','1234'),(000011,'车先生','13978969825','',NULL,NULL,NULL,'','1234'),(000012,'冰冰','13788889999','40928213212xa1234','女',NULL,NULL,'11223648@qq.com','1234');

/*Table structure for table `user_complaint` */

DROP TABLE IF EXISTS `user_complaint`;

CREATE TABLE `user_complaint` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '客户电话',
  `complaint_info` varchar(32) DEFAULT NULL COMMENT '投诉信息',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `is_solve` varchar(4) DEFAULT NULL COMMENT '是否处理 0未处理 1已处理',
  `user_id` int(11) DEFAULT NULL COMMENT '对应的用户ID',
  `emp_id` int(11) DEFAULT NULL COMMENT '对应的员工ID',
  `result_msg` varchar(512) DEFAULT NULL COMMENT '处理结果',
  `feedback_msg` varchar(512) DEFAULT NULL COMMENT '用户反馈',
  `score` varchar(32) DEFAULT NULL COMMENT '分值',
  `degree` varchar(10) DEFAULT NULL COMMENT '等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户投诉信息表 ';

/*Data for the table `user_complaint` */

insert  into `user_complaint`(`id`,`user_name`,`phone`,`complaint_info`,`create_date`,`is_solve`,`user_id`,`emp_id`,`result_msg`,`feedback_msg`,`score`,`degree`) values (000004,'张三','15566778899','楼下太吵','2022-05-05 12:48:44','1',1,2,'已解决','算了算了，暂时解决问题了。哎','-1.11','差');

/*Table structure for table `user_repair` */

DROP TABLE IF EXISTS `user_repair`;

CREATE TABLE `user_repair` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '客户电话',
  `repair_info` varchar(32) DEFAULT NULL COMMENT '报修信息',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `is_solve` varchar(4) DEFAULT NULL COMMENT '是否处理 0未处理 1已处理',
  `user_id` int(11) DEFAULT NULL COMMENT '对应的用户ID',
  `emp_id` int(11) DEFAULT NULL COMMENT '对应的员工ID',
  `result_msg` varchar(512) DEFAULT NULL COMMENT '处理结果',
  `feedback_msg` varchar(512) DEFAULT NULL COMMENT '用户反馈',
  `score` varchar(32) DEFAULT NULL COMMENT '分值',
  `degree` varchar(10) DEFAULT NULL COMMENT '等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户报修信息表 ';

/*Data for the table `user_repair` */

insert  into `user_repair`(`id`,`user_name`,`phone`,`repair_info`,`create_date`,`is_solve`,`user_id`,`emp_id`,`result_msg`,`feedback_msg`,`score`,`degree`) values (000004,'张三','15566778899','一号楼二单元楼梯灯坏了','2022-05-04 12:43:35','1',1,2,'已经维修','工作给力，点赞！','1.29','中'),(000005,'张三','15566778899','楼梯灯坏了','2022-05-05 12:55:44','1',1,2,'已经维修','好的谢谢','5.05','中'),(000006,'张三','15566778899','二号楼三单元单元门坏了','2022-05-05 18:26:12','1',1,3,'没解决！','搞什么嘛，差评，体验非常差！','-2','差');

/*Table structure for table `user_unit_relation` */

DROP TABLE IF EXISTS `user_unit_relation`;

CREATE TABLE `user_unit_relation` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `unit_id` int(11) DEFAULT NULL COMMENT '住房ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `is_house_holder` varchar(4) DEFAULT NULL COMMENT '是否是户主 1是  0否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='用户与住房关系对应表 ';

/*Data for the table `user_unit_relation` */

insert  into `user_unit_relation`(`id`,`user_id`,`unit_id`,`create_date`,`is_house_holder`) values (000009,2,3,'2022-05-14 17:24:48','1'),(000012,1,8,'2022-04-29 21:52:29','1'),(000013,1,9,'2022-04-29 22:02:55','1'),(000014,2,15,'2022-05-14 17:23:40','1'),(000015,1,6,'2022-04-29 21:52:13','1'),(000016,1,10,'2021-11-17 09:29:29','1'),(000017,8,1,'2022-04-30 00:41:13','0'),(000019,1,7,'2022-05-14 17:27:15','1'),(000021,2,2,'2022-05-16 21:58:11','1'),(000022,12,1,'2023-01-17 00:56:23','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
