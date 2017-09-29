/*
Navicat MySQL Data Transfer

Source Server         : connect
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : d_cllxyz

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-09-29 19:08:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `content` text,
  `logo` varchar(500) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjmg0grmlhs0p0hjpgmtkwjmve` (`agency_id`),
  KEY `FKnb9902tpy4nybp8shetwtdmps` (`buildings_id`),
  CONSTRAINT `FKjmg0grmlhs0p0hjpgmtkwjmve` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `FKnb9902tpy4nybp8shetwtdmps` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_activity_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_activity_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` varchar(36) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_admin_role_id` (`role_id`),
  CONSTRAINT `fk_admin_role_id` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ads
-- ----------------------------
DROP TABLE IF EXISTS `t_ads`;
CREATE TABLE `t_ads` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(50) NOT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `ad_url` varchar(500) DEFAULT NULL,
  `show_status` tinyint(4) DEFAULT NULL,
  `show_order` int(11) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_agency
-- ----------------------------
DROP TABLE IF EXISTS `t_agency`;
CREATE TABLE `t_agency` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `leader` varchar(20) DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `checked_status` tinyint(4) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `name` (`name`),
  KEY `FKn2c9747ofdgx3xuk0b83w25d4` (`role_id`),
  CONSTRAINT `FKn2c9747ofdgx3xuk0b83w25d4` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `fk_agency_role_id` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_appointment
-- ----------------------------
DROP TABLE IF EXISTS `t_appointment`;
CREATE TABLE `t_appointment` (
  `id` varchar(36) NOT NULL,
  `emp_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `app_arrive_time` datetime DEFAULT NULL,
  `arrive_time` datetime DEFAULT NULL,
  `house_id` varchar(36) DEFAULT NULL,
  `app_status` varchar(20) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjl1vg8012nigi3dm8x2gfer1w` (`user_id`),
  KEY `FKbg3alrg9dbcw5o7m7sxiug9w4` (`agency_id`),
  KEY `FKlcftab42o6ygd9woavb1sdor6` (`emp_id`),
  KEY `FKafqcuk6ywbunoop2xdk5gyja9` (`house_id`),
  CONSTRAINT `FKafqcuk6ywbunoop2xdk5gyja9` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`),
  CONSTRAINT `FKbg3alrg9dbcw5o7m7sxiug9w4` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `FKjl1vg8012nigi3dm8x2gfer1w` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKlcftab42o6ygd9woavb1sdor6` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `fk_t_appointment_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `fk_t_appointment_house_id` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`),
  CONSTRAINT `fk_t_appointment_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL,
  `abstracts` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `type_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8rcu1gpwec0kmjmjx326somlw` (`type_id`),
  CONSTRAINT `FK8rcu1gpwec0kmjmjx326somlw` FOREIGN KEY (`type_id`) REFERENCES `t_article_type` (`id`),
  CONSTRAINT `fk_t_article_type_id` FOREIGN KEY (`type_id`) REFERENCES `t_article_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_article_type
-- ----------------------------
DROP TABLE IF EXISTS `t_article_type`;
CREATE TABLE `t_article_type` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `des` varchar(500) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_building
-- ----------------------------
DROP TABLE IF EXISTS `t_building`;
CREATE TABLE `t_building` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `total_floor` int(11) NOT NULL,
  `total_lift` int(11) NOT NULL,
  `floor_rooms` int(11) NOT NULL,
  `total_room` int(11) NOT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `agency_id` varchar(255) DEFAULT NULL,
  `room_status` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3gnilnyexm0a06ndvtexx9xge` (`buildings_id`),
  KEY `FK3v8v71s4dah4ps3vbru1cblgr` (`agency_id`),
  CONSTRAINT `FK3gnilnyexm0a06ndvtexx9xge` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `FK3v8v71s4dah4ps3vbru1cblgr` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_building_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_buildings
-- ----------------------------
DROP TABLE IF EXISTS `t_buildings`;
CREATE TABLE `t_buildings` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `floor_area` double DEFAULT NULL,
  `building_area` double DEFAULT NULL,
  `house_type` varchar(20) DEFAULT NULL,
  `building_type` varchar(20) DEFAULT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `avg_price` double NOT NULL,
  `company` varchar(100) DEFAULT NULL,
  `open_date` date DEFAULT NULL,
  `total_rooms` int(11) DEFAULT NULL,
  `reception_address` varchar(100) NOT NULL,
  `tel` varchar(11) NOT NULL,
  `green_ratio` double DEFAULT NULL,
  `plot_ratio` double DEFAULT NULL,
  `property_company` varchar(100) DEFAULT NULL,
  `property_fee` double DEFAULT NULL,
  `car_station` int(11) DEFAULT NULL,
  `traffic` text,
  `equipments` text,
  `logo` varchar(500) DEFAULT '/buildings_logo.jpg',
  `intro` varchar(500) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKshi86g4sd3eligwwhc9kc0499` (`agency_id`),
  CONSTRAINT `FKshi86g4sd3eligwwhc9kc0499` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_buildings_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_buildings_img
-- ----------------------------
DROP TABLE IF EXISTS `t_buildings_img`;
CREATE TABLE `t_buildings_img` (
  `id` varchar(36) NOT NULL,
  `img_path` varchar(500) NOT NULL,
  `img_des` varchar(50) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt97t4yc6s5rtaby131m1pkd9n` (`buildings_id`),
  CONSTRAINT `FKt97t4yc6s5rtaby131m1pkd9n` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_buildings_img_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` varchar(36) NOT NULL,
  `content` text,
  `buildings_id` varchar(36) DEFAULT NULL,
  `comment_time` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `agency_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtamaoacctq4qpko6bvtv0ke1p` (`user_id`),
  KEY `FKdx4i478jqqa2tvj8kr0p4wah4` (`buildings_id`),
  KEY `FKfm80o7k3gj46mah83pilu88wj` (`agency_id`),
  CONSTRAINT `FKdx4i478jqqa2tvj8kr0p4wah4` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `FKfm80o7k3gj46mah83pilu88wj` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `FKtamaoacctq4qpko6bvtv0ke1p` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `fk_t_comment_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer` (
  `id` varchar(36) NOT NULL,
  `name` text,
  `gender` varchar(2) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `identity_id` varchar(18) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  `customer_type` varchar(20) DEFAULT NULL,
  `together` varchar(100) DEFAULT NULL,
  `contract` varchar(500) DEFAULT NULL,
  `archives` varchar(500) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `emp_id` varchar(36) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `FKs60g4yhfst9n7m8u360h33kvh` (`emp_id`),
  KEY `FKitnpf18fh8o1updx02wql0ete` (`agency_id`),
  CONSTRAINT `FKitnpf18fh8o1updx02wql0ete` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `FKs60g4yhfst9n7m8u360h33kvh` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `fk_t_customer_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_customer_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `exp` varchar(50) DEFAULT NULL,
  `des` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `basic_salary` double NOT NULL,
  `headicon` varchar(500) DEFAULT 'logo.jpg',
  `intro` varchar(500) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `FKmj5i68pee3oh4snfh36v818xx` (`agency_id`),
  KEY `FK9w3tpcj06365s4dykyfxxjbqr` (`buildings_id`),
  KEY `FK614dw0owuriq4ryb40by0g5px` (`role_id`),
  CONSTRAINT `FK614dw0owuriq4ryb40by0g5px` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK9w3tpcj06365s4dykyfxxjbqr` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `FKmj5i68pee3oh4snfh36v818xx` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_employee_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_employee_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_history
-- ----------------------------
DROP TABLE IF EXISTS `t_history`;
CREATE TABLE `t_history` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3972xpo0vqmgtm0drmbolij35` (`user_id`),
  KEY `FK7bwfg928hb7pb8c88y29a6hhv` (`buildings_id`),
  CONSTRAINT `FK3972xpo0vqmgtm0drmbolij35` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FK7bwfg928hb7pb8c88y29a6hhv` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_history_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_house
-- ----------------------------
DROP TABLE IF EXISTS `t_house`;
CREATE TABLE `t_house` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL,
  `area` double NOT NULL,
  `unit_price` double NOT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjkllbkrml4liqd639oilck1hb` (`buildings_id`),
  KEY `FKklm51693upsd0gugnec1l775w` (`agency_id`),
  CONSTRAINT `FKjkllbkrml4liqd639oilck1hb` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `FKklm51693upsd0gugnec1l775w` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_house_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_house_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_like
-- ----------------------------
DROP TABLE IF EXISTS `t_like`;
CREATE TABLE `t_like` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `buildings_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc29ct4gq2xipkbguwqkapkv13` (`user_id`),
  KEY `FK5w5vvgv7kae7xf2rgno79v9c4` (`buildings_id`),
  CONSTRAINT `FK5w5vvgv7kae7xf2rgno79v9c4` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `FKc29ct4gq2xipkbguwqkapkv13` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `fk_t_like_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_like_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` varchar(36) NOT NULL,
  `content` text,
  `buildings_id` varchar(36) DEFAULT NULL,
  `reply` text,
  `leave_time` datetime DEFAULT NULL,
  `reply_time` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `agency_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8bywht7ktfktx8qeysmlk5kv2` (`user_id`),
  KEY `FKhq1fw0c11ybj5vdk1x1peqsfj` (`buildings_id`),
  KEY `FKcdxrs3vjcdxm0wmdkokhemole` (`agency_id`),
  CONSTRAINT `FK8bywht7ktfktx8qeysmlk5kv2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKcdxrs3vjcdxm0wmdkokhemole` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `FKhq1fw0c11ybj5vdk1x1peqsfj` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_message_buildings_id` FOREIGN KEY (`buildings_id`) REFERENCES `t_buildings` (`id`),
  CONSTRAINT `fk_t_message_user_id` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_mission
-- ----------------------------
DROP TABLE IF EXISTS `t_mission`;
CREATE TABLE `t_mission` (
  `id` varchar(36) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `monthes` varchar(50) DEFAULT NULL,
  `emp_id` varchar(36) DEFAULT NULL,
  `bonus_percent` double DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1ghy237xubw2xmoqsu64pvqew` (`emp_id`),
  KEY `FK9k0v4a5gbs0n1vktcp114tfxf` (`agency_id`),
  CONSTRAINT `FK1ghy237xubw2xmoqsu64pvqew` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `FK9k0v4a5gbs0n1vktcp114tfxf` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_mission_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` varchar(36) NOT NULL,
  `name` varchar(500) NOT NULL,
  `des` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `des` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `id` varchar(36) NOT NULL,
  `role_id` varchar(500) DEFAULT NULL,
  `permission_id` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_t_role_permission_role_id` (`role_id`),
  KEY `fk_t_role_permission_permission_id` (`permission_id`),
  CONSTRAINT `fk_t_role_permission_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `t_permission` (`id`),
  CONSTRAINT `fk_t_role_permission_role_id` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_room
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room` (
  `id` varchar(36) NOT NULL,
  `house_id` varchar(36) DEFAULT NULL,
  `building_id` varchar(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sale_status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4k927m89wp1svklnr0au7k7u7` (`building_id`),
  KEY `FKsh9jm9riaph5egd32o6cw288t` (`house_id`),
  CONSTRAINT `FK4k927m89wp1svklnr0au7k7u7` FOREIGN KEY (`building_id`) REFERENCES `t_building` (`id`),
  CONSTRAINT `FKsh9jm9riaph5egd32o6cw288t` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`),
  CONSTRAINT `fk_t_room_building_id` FOREIGN KEY (`building_id`) REFERENCES `t_building` (`id`),
  CONSTRAINT `fk_t_room_house_id` FOREIGN KEY (`house_id`) REFERENCES `t_house` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sale
-- ----------------------------
DROP TABLE IF EXISTS `t_sale`;
CREATE TABLE `t_sale` (
  `id` varchar(36) NOT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `sale_time` datetime DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `room_id` varchar(36) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `emp_id` varchar(36) DEFAULT NULL,
  `agency_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1rshjplf2ybyhqyp2kf2enqun` (`emp_id`),
  KEY `FKr9iju14exhdkn0c42k4j2mbpo` (`customer_id`),
  KEY `FKsdrs01ebgw3deyeolfk867mrf` (`agency_id`),
  KEY `FKdc99mkusv37h2kiu3jaurulv5` (`room_id`),
  CONSTRAINT `FK1rshjplf2ybyhqyp2kf2enqun` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`),
  CONSTRAINT `FKdc99mkusv37h2kiu3jaurulv5` FOREIGN KEY (`room_id`) REFERENCES `t_room` (`id`),
  CONSTRAINT `FKr9iju14exhdkn0c42k4j2mbpo` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`id`),
  CONSTRAINT `FKsdrs01ebgw3deyeolfk867mrf` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_sale_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `t_agency` (`id`),
  CONSTRAINT `fk_t_sale_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`id`),
  CONSTRAINT `fk_t_sale_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(36) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `headicon` varchar(500) DEFAULT 'logo.jpg',
  `role_id` varchar(36) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `FK76cs7cu4h4y8vc1vd4qyw36rt` (`role_id`),
  CONSTRAINT `FK76cs7cu4h4y8vc1vd4qyw36rt` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `fk_t_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
