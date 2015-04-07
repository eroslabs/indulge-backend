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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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

/*Table structure for table `forgot_request` */

DROP TABLE IF EXISTS `forgot_request`;

CREATE TABLE `forgot_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL COMMENT 'identifier for user',
  `type` tinyint(1) DEFAULT NULL COMMENT '1=user , 2=merchant',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
  `gender_support` tinyint(1) DEFAULT '2',
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
  `review_rating` float(4,1) DEFAULT '0.0',
  `profile_complete` tinyint(1) DEFAULT '0',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueemailindx` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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

/*Table structure for table `merchant_service` */

DROP TABLE IF EXISTS `merchant_service`;

CREATE TABLE `merchant_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL,
  `service_id` int(6) NOT NULL,
  `description` varchar(800) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0=inactive 1=active',
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

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

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL COMMENT 'Date Of Birth',
  `gender` char(1) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `passphrase` varchar(20) DEFAULT NULL,
  `facebook_id` varchar(50) DEFAULT NULL,
  `profile_photo` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT 'active=1, inactive=0',
  `logged_status` tinyint(1) DEFAULT '0',
  `ref_code` varchar(10) DEFAULT NULL,
  `image_path` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `user_reviews` */

DROP TABLE IF EXISTS `user_reviews`;

CREATE TABLE `user_reviews` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'identifier for user',
  `name` varchar(50) DEFAULT NULL,
  `merchant_id` bigint(20) NOT NULL COMMENT 'identifier for merchant',
  `review_text` varchar(1000) DEFAULT NULL,
  `service` varchar(100) DEFAULT NULL COMMENT 'text to define service',
  `service_rating` float(4,1) DEFAULT NULL,
  `cleanliness_rating` float(4,1) DEFAULT NULL,
  `rating` float(4,1) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/* Procedure structure for procedure `ConfirmCoupon` */

/*!50003 DROP PROCEDURE IF EXISTS  `ConfirmCoupon` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ConfirmCoupon`(IN userId BIGINT(20),IN dealId BIGINT(20),OUT confirmStatus BOOLEAN)
BEGIN
DECLARE rowcount int(2);
update merchant_deal set confirmed=confirmed+1 where id=dealId ;
select ROW_COUNT() into rowcount; 
IF(rowcount >0) THEN
 SET confirmStatus = true;
else
 Set confirmStatus = false;
END IF; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `RedeemCoupon` */

/*!50003 DROP PROCEDURE IF EXISTS  `RedeemCoupon` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `RedeemCoupon`(IN userId BIGINT(20),IN dealId BIGINT(20),OUT couponCode VARCHAR(20))
BEGIN
DECLARE couponId BIGINT(20);
SELECT c.coupon_code ,c.id INTO couponCode,couponId  FROM merchant_coupon c LEFT JOIN merchant_deal d  ON d.id=c.deal_id 
WHERE c.status = 1 AND d.id=dealId AND d.status=1;
IF(couponId IS NOT NULL) THEN
UPDATE `merchant_deal` SET `redemption` = `redemption` +1 WHERE id=dealId;
UPDATE `merchant_coupon` SET `status` = 3 WHERE id=couponId;
INSERT INTO `deal_redemption` (deal_id,user_id,is_redeemed,created_date) VALUES(dealId,userId,1,CURRENT_TIMESTAMP);
END IF; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateMerchantRating` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateMerchantRating` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMerchantRating`(IN merchantId BIGINT(20))
BEGIN
DECLARE averageRating float(2);
select AVG(rating) into averageRating from user_reviews where merchant_id=merchantId;
update merchant set review_rating=averageRating where id=merchantId ;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
