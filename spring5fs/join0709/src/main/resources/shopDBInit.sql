CREATE SCHEMA `shopDB`;
use shopDB;
CREATE TABLE `shopDB`.`board` (
	`id` bigint NOT NULL AUTO_INCREMENT,
    `subject` varchar(300) NOT NULL,
    `content` text,
    `writer` varchar(100) NOT NULL,
    `password` varchar(300) NOT NULL,
    `register_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`)
)ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
CREATE TABLE `shopDB`.`board_reply` (
	`reply_id` bigint NOT NULL AUTO_INCREMENT,
    `board_id` bigint,
    `parent_id` bigint,
    `depth` int,
    `reply_content` text,
    `reply_writer` varchar(100) NOT NULL,
    `reply_password` varchar(300) NOT NULL,
    `register_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`reply_id`)
)ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
CREATE TABLE `shopDB`.`user` (
	`email` varchar(200) ,
    `pw` varchar(300) ,
    `name` varchar(100),
    PRIMARY KEY (`email`)
)ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
grant all privileges on shopDB.* to 'spring5'@'localhost';