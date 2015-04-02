/*
SQLyog Community v9.30 
MySQL - 5.5.29 : Database - indulge
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`indulge` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `indulge`;

/*Table structure for table `admin_config` */

DROP TABLE IF EXISTS `admin_config`;

CREATE TABLE `admin_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prop_name` varchar(20) NOT NULL,
  `prop_value` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin_config` */

/*Table structure for table `deal_redemption` */

DROP TABLE IF EXISTS `deal_redemption`;

CREATE TABLE `deal_redemption` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deal_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `is_redeemed` tinyint(1) DEFAULT '0',
  `is_confirmed` tinyint(1) DEFAULT '0',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `deal_redemption` */

/*Table structure for table `deal_request` */

DROP TABLE IF EXISTS `deal_request`;

CREATE TABLE `deal_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `merchant_id` int(2) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `deal_request` */

insert  into `deal_request`(`id`,`user_id`,`merchant_id`,`created_date`,`updated_date`) values (3,1,6,'2015-04-15 11:40:50','2015-04-01 11:40:56');

/*Table structure for table `deal_service_request` */

DROP TABLE IF EXISTS `deal_service_request`;

CREATE TABLE `deal_service_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `request_id` bigint(20) NOT NULL,
  `service_id` int(2) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `deal_service_request` */

insert  into `deal_service_request`(`id`,`request_id`,`service_id`,`created_date`,`updated_date`) values (3,3,2,'2015-04-14 11:41:28','2015-04-01 11:41:21'),(4,3,3,'2015-04-15 11:41:34','2015-04-01 11:41:28');

/*Table structure for table `digital_menu_image` */

DROP TABLE IF EXISTS `digital_menu_image`;

CREATE TABLE `digital_menu_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '''SERVICE''',
  `status` tinyint(1) DEFAULT '0' COMMENT '0=unapproved 1=approved',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `digital_menu_image` */

insert  into `digital_menu_image`(`id`,`merchant_id`,`image`,`type`,`status`,`created_date`,`updated_date`) values (4,6,'6\\th.jpg','\'SERVICE\'',0,'2015-04-02 12:01:43','2015-04-02 12:01:43'),(5,6,'6\\ab.jpg','\'SERVICE\'',0,'2015-04-02 12:01:43','2015-04-02 12:01:43');

/*Table structure for table `merchant` */

DROP TABLE IF EXISTS `merchant`;

CREATE TABLE `merchant` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `passphrase` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `lat` decimal(10,2) DEFAULT NULL,
  `lng` decimal(10,2) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `separate_rate_card` tinyint(1) DEFAULT '0',
  `service_radius` int(2) DEFAULT '0',
  `cc_accepted` tinyint(1) DEFAULT '1',
  `unit_no` varchar(100) DEFAULT NULL,
  `floor` varchar(100) DEFAULT NULL,
  `building` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `landmark` varchar(500) DEFAULT NULL,
  `state` varchar(500) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `home_service` tinyint(1) DEFAULT '0',
  `country` char(20) DEFAULT 'INDIA',
  `phone` varchar(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `software` varchar(100) DEFAULT NULL,
  `review_rating` float(1,1) DEFAULT '0.0',
  `profile_complete` tinyint(1) DEFAULT '0',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `merchant` */

insert  into `merchant`(`id`,`email`,`passphrase`,`name`,`city`,`lat`,`lng`,`image`,`separate_rate_card`,`service_radius`,`cc_accepted`,`unit_no`,`floor`,`building`,`street`,`landmark`,`state`,`pincode`,`home_service`,`country`,`phone`,`status`,`software`,`review_rating`,`profile_complete`,`created_date`,`updated_date`) values (6,'vikas31121978@gmail.com','123456','abc','asd','28.90','23.40','6\\ab.jpg',1,10,1,'a block','asdasdsad','sad','sdsa','das','Delhi','201012',1,'INDIA','9811435036',1,'sdasda',0.0,0,'2015-03-30 18:21:38','2015-04-02 12:13:34'),(7,'vikas31@gmail.com','123456','abc','delhi','28.90','23.40','7\\578292_10150684360970807_1075386497_n.jpg',0,0,1,'a block',NULL,NULL,NULL,NULL,'Delhi',NULL,0,'INDIA','9811435036',1,NULL,0.0,0,'2015-03-31 16:58:30','2015-03-31 16:59:20');

/*Table structure for table `merchant_coupon` */

DROP TABLE IF EXISTS `merchant_coupon`;

CREATE TABLE `merchant_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `coupon_code` varchar(20) NOT NULL,
  `deal_id` bigint(20) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0=inactive 1=active 3=used',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `merchant_coupon` */

/*Table structure for table `merchant_deal` */

DROP TABLE IF EXISTS `merchant_deal`;

CREATE TABLE `merchant_deal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `description` varchar(800) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0=inactive 1=active',
  `valid_from` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `valid_till` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `flat_off` int(5) DEFAULT NULL,
  `percent_off` int(3) DEFAULT NULL,
  `weekdays_schedule` varchar(7) NOT NULL DEFAULT '1111111',
  `recurring` tinyint(1) DEFAULT '0',
  `redemption` int(5) DEFAULT '0',
  `confirmed` int(5) DEFAULT '0',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_deal` */

insert  into `merchant_deal`(`id`,`merchant_id`,`description`,`status`,`valid_from`,`valid_till`,`flat_off`,`percent_off`,`weekdays_schedule`,`recurring`,`redemption`,`confirmed`,`created_date`,`updated_date`) values (1,6,'sadsadasdsa',1,'2014-12-11 00:00:00','2014-12-11 00:00:00',20,10,'1100111',NULL,0,0,'2015-03-31 14:12:18','2015-03-31 14:12:18'),(2,6,'sadsadasdsa',1,'2014-12-11 00:00:00','2014-12-11 00:00:00',20,10,'1100111',NULL,0,0,'2015-03-31 14:17:37','2015-03-31 14:17:37'),(3,6,'sadsadasdsa',1,'2014-12-11 00:00:00','2014-12-11 00:00:00',20,10,'1100111',NULL,0,0,'2015-03-31 14:40:55','2015-03-31 14:40:55');

/*Table structure for table `merchant_deal_service` */

DROP TABLE IF EXISTS `merchant_deal_service`;

CREATE TABLE `merchant_deal_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deal_id` bigint(20) NOT NULL,
  `service_id` int(2) NOT NULL,
  `service_name` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_deal_service` */

insert  into `merchant_deal_service`(`id`,`deal_id`,`service_id`,`service_name`,`created_date`,`updated_date`) values (1,1,1,NULL,'2015-03-31 14:41:21','2015-03-31 14:41:21'),(2,1,2,NULL,'2015-03-31 14:41:21','2015-03-31 14:41:21');

/*Table structure for table `merchant_phone` */

DROP TABLE IF EXISTS `merchant_phone`;

CREATE TABLE `merchant_phone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `type` char(1) DEFAULT NULL COMMENT 'm=mobile l=landline',
  `status` tinyint(1) DEFAULT '1',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_phone` */

insert  into `merchant_phone`(`id`,`merchant_id`,`phone_number`,`type`,`status`,`created_date`,`updated_date`) values (1,1,'9811435036','H',1,'2015-03-26 22:30:09','2015-03-26 22:31:46'),(2,2,'9811435036','O',1,'0000-00-00 00:00:00','2015-03-30 15:22:46'),(3,2,'9811435036','O',1,'0000-00-00 00:00:00','2015-03-30 15:22:46'),(4,2,'2132133212','O',1,'0000-00-00 00:00:00','2015-03-30 15:22:46'),(5,2,'9811435036','O',1,'0000-00-00 00:00:00','2015-03-30 15:29:49'),(6,2,'9811435036','O',1,'0000-00-00 00:00:00','2015-03-30 15:29:49'),(7,6,'9811435036','O',1,'0000-00-00 00:00:00','2015-03-30 15:50:33');

/*Table structure for table `merchant_photo` */

DROP TABLE IF EXISTS `merchant_photo`;

CREATE TABLE `merchant_photo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0=unapproved 1=approved',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_photo` */

insert  into `merchant_photo`(`id`,`merchant_id`,`image`,`status`,`created_date`,`updated_date`) values (1,1,'a',1,'2015-03-26 19:33:36','2015-03-26 19:33:36'),(2,1,'b',0,'2015-03-26 19:33:36','2015-03-26 19:33:43'),(3,2,'c',1,'2015-03-26 19:33:36','2015-03-26 19:33:59');

/*Table structure for table `merchant_schedule` */

DROP TABLE IF EXISTS `merchant_schedule`;

CREATE TABLE `merchant_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `opening_time` varchar(8) NOT NULL DEFAULT '09:00:00',
  `closing_time` varchar(8) NOT NULL DEFAULT '20:00:00',
  `days` varchar(7) DEFAULT NULL COMMENT 'week days starting with Monday. 1111110 means sunday off',
  `status` tinyint(1) DEFAULT '1',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_schedule` */

insert  into `merchant_schedule`(`id`,`merchant_id`,`opening_time`,`closing_time`,`days`,`status`,`created_date`,`updated_date`) values (3,2,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-03-30 14:43:47'),(4,2,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-03-30 14:45:14'),(5,4,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-03-30 15:54:54'),(6,5,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-03-30 18:09:34'),(7,6,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-03-30 18:22:38'),(8,6,'08:30','20:30','1100110',1,'0000-00-00 00:00:00','2015-04-02 12:14:13');

/*Table structure for table `merchant_service` */

DROP TABLE IF EXISTS `merchant_service`;

CREATE TABLE `merchant_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `service_id` int(6) NOT NULL,
  `description` varchar(800) DEFAULT NULL,
  `price` float(4,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0=inactive 1=active',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_service` */

insert  into `merchant_service`(`id`,`merchant_id`,`service_id`,`description`,`price`,`status`,`created_date`,`updated_date`) values (1,1,1,'mass',99.99,1,'2015-03-26 22:30:09','2015-03-26 22:29:30'),(2,1,1,NULL,2.00,1,'2015-04-01 19:28:12','2015-04-01 19:28:12'),(3,6,1,NULL,NULL,1,'2015-04-01 21:53:18','2015-04-01 21:53:18'),(4,6,1,NULL,10.00,1,'2015-04-01 21:56:40','2015-04-01 21:56:40'),(5,6,1,NULL,10.00,1,'2015-04-01 21:57:47','2015-04-01 21:57:47'),(6,6,1,NULL,20.00,1,'2015-04-02 10:59:04','2015-04-02 10:59:04');

/*Table structure for table `password_request` */

DROP TABLE IF EXISTS `password_request`;

CREATE TABLE `password_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `identifier` varchar(10) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `password_request` */

/*Table structure for table `service` */

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `service_category_id` int(8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'ACTIVE=1,INACTIVE=0',
  `image` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `service` */

insert  into `service`(`id`,`name`,`description`,`service_category_id`,`status`,`image`,`created_date`,`updated_date`) values (1,'massage','full body',1,1,'vikas','2015-03-26 22:30:09','2015-03-26 22:31:07'),(2,'cutting','dd',2,1,'ff','0000-00-00 00:00:00','2015-03-31 11:42:22'),(3,'hair spa','kjhjk',2,1,'gg','0000-00-00 00:00:00','2015-03-31 11:42:38'),(4,'foot spa','sd',3,1,'dd','0000-00-00 00:00:00','2015-03-31 11:43:21');

/*Table structure for table `service_category` */

DROP TABLE IF EXISTS `service_category`;

CREATE TABLE `service_category` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'ACTIVE=1,INACTIVE=0',
  `image` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `service_category` */

insert  into `service_category`(`id`,`name`,`description`,`status`,`image`,`created_date`,`updated_date`) values (1,'massage','abs',1,'cd','2015-03-26 22:30:09','2015-03-26 22:30:54'),(2,'hair','hair',1,'sdsd','0000-00-00 00:00:00','2015-03-31 11:41:51'),(3,'legs','leg',1,'sd','0000-00-00 00:00:00','2015-03-31 11:52:55');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL COMMENT 'Date Of Birth',
  `gender` char(1) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `passphrase` varchar(20) DEFAULT NULL,
  `facebook_id` varchar(50) DEFAULT NULL,
  `profile_photo` varchar(50) DEFAULT NULL,
  `status` smallint(1) DEFAULT NULL COMMENT 'active=1, inactive=0',
  `ref_code` varchar(10) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`dob`,`gender`,`mobile`,`passphrase`,`facebook_id`,`profile_photo`,`status`,`ref_code`,`created_date`,`updated_date`) values (1,'vix','2015-03-16','n','sad','dsa','sd','sad',1,NULL,'0000-00-00 00:00:00','2015-03-30 17:10:03');

/*Table structure for table `user_reviews` */

DROP TABLE IF EXISTS `user_reviews`;

CREATE TABLE `user_reviews` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'identifier for user',
  `merchant_id` bigint(20) NOT NULL COMMENT 'identifier for merchant',
  `review_text` varchar(1000) DEFAULT NULL,
  `service` varchar(100) DEFAULT NULL COMMENT 'text to define service',
  `rating` int(1) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `user_reviews` */

insert  into `user_reviews`(`id`,`user_id`,`merchant_id`,`review_text`,`service`,`rating`,`created_date`,`updated_date`) values (1,1,6,'asd',NULL,1,'0000-00-00 00:00:00','2015-03-30 17:09:04'),(2,1,6,'sdf',NULL,2,'0000-00-00 00:00:00','2015-03-30 17:16:33');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
