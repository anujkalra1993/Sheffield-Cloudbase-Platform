CREATE DATABASE CLOUDBASE;
use CLOUDBASE;
show Tables;

CREATE TABLE USER(
userid integer primary key auto_increment,
fullname varchar(50),
emailID varchar(50) not null,
accountType varchar(50) NOT NULL,
Peanuts int(5) NOT NULL DEFAULT 5000
);

CREATE TABLE appinfo( id integer primary key auto_increment, owner varchar(50) not null, appName varchar(50) not null, appDescription text, iconName varchar(50) not null, warFileName varchar(50) not null, price integer not null default 0, filePath text, imagePath text, userCount integer not null default 0, buyCount integer not null default 0 ); 
Query OK, 0 rows affected (0.02 sec)


CREATE TABLE app_buy_info( id integer primary key auto_increment, appID integer not null, price integer not null, buyer varchar(50) not null, date_buy timestamp not null, owner varchar(50) not null, FOREIGN KEY (appID) REFERENCES appinfo(id) );