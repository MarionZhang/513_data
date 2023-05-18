CREATE DATABASE newDB;
USE newDB;

CREATE TABLE order_table(
	id int,
    user_id CHARACTER(1),
    city VARCHAR(20),
    order_time TIMESTAMP,
    PRIMARY KEY (id)
);


INSERT INTO order_table(id,user_id,city,order_time)
VALUES (1, 'A', '深圳', '2018-01-01 10:10:30'),
	   (2, 'B', '上海', '2018-07-10 10:10:30'),
       (3, 'C', '北京', '2018-02-01 12:10:30'),
       (4, 'A', '重庆', '2018-01-14 21:10:30'),
       (5, 'C', '成都', '2018-01-18 10:10:30'),
       (6, 'D', '广州', '2018-01-22 10:10:30'),
       (7, 'Y', '南宁', '2018-03-16 04:10:30'),
       (8, 'F', '吉林', '2018-03-29 09:10:30'),
       (10, 'F', '天津', '2018-01-01 09:10:30'),
       
       (9, 'T', '上海', '2018-01-20 12:10:30'),
       (11, 'C', '上海', '2019-02-01 12:10:30'),
       (12, 'B', '北京', '2019-07-10 10:10:30'),
       (13, 'B', '北京', '2019-08-10 10:10:30'),
       (14, 'B', '北京', '2020-07-10 10:10:30'),
       (15, 'C', '上海', '2019-08-10 10:10:30'),
       (16, 'A', '深圳', '2018-07-10 10:10:30'),
       (17, 'B', '重庆', '2020-09-10 12:10:30')
       ;


CREATE TABLE user_table(
	user_id CHARACTER(1),
    user_name VARCHAR(20),
    PRIMARY KEY (user_id)
);


INSERT INTO user_table(user_id,user_name)
VALUES('A', "张三"),
	  ('B', "李四"),
      ('C', "王五"),
      ('D', "刘六"),
      ('F', "陈俊"),
      ('T', "韩雪"),
      
      ('Y', "陈雪");


SELECT o.city,
    SUM(CASE WHEN u.user_name = '张三' THEN 1 ELSE 0 END) AS 张三订单量,
    SUM(CASE WHEN u.user_name = '李四' THEN 1 ELSE 0 END) AS 李四订单量,
    SUM(CASE WHEN u.user_name = '王五' THEN 1 ELSE 0 END) AS 王五订单量
FROM order_table o
INNER JOIN user_table u ON o.user_id = u.user_id
WHERE u.user_name IN ('张三', '李四', '王五')
GROUP BY o.city;



