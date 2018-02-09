other sql files...
/tmstack/hsc/sql/sql.sql

------------------- IOTbroker2.0 queries---------------
SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid='CYURD002' AND (dow=4 OR dow=0) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel 

SELECT * FROM scheds a 
INNER JOIN (
  SELECT MAX(dow)as mdow, senrel 
  FROM scheds 
  WHERE devid='CYURD002' 
  AND (dow=2 OR dow=0) GROUP BY senrel) b 
ON a.dow=b.mdow AND a.senrel=b.senrel 

DROP TABLE IF EXISTS `holds`;
CREATE TABLE IF NOT EXISTS `holds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `until` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sched` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`devid`,`senrel`,`until`) USING BTREE,
  KEY `devid` (`devid`),
  KEY `senrel` (`senrel`),
  KEY `until` (`until`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `holds`(`devid`, `senrel`, `until`, `sched`) 
VALUES ('CYURD001',0,'2018-02-15 00:00','[[0,0,72,74]]')
-------------------new IOTexress2.0 tables---------------
/*
locations, devs, user-app-loc
*/

DROP TABLE IF EXISTS `app_loc`;
CREATE TABLE `app_loc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `devs` varchar(300) DEFAULT NULL,
  `zones` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locid` (`locid`),
  KEY `appid` (`appid`),
  UNIQUE KEY `main` (`appid`, `locid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;

INSERT INTO app_loc (appid, locid, devs, zones)
  VALUES (
    'hvac',
    '12ParleyVale',
    '{"CYURD003": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD006": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}',
    '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]'
  )

INSERT INTO app_loc (appid, locid, devs, zones)
  VALUES (
    'hvac',
    '255ChestnutAve',
    '{"CYURD013": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD016": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}',
    '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]'
  )

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locid` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `latlng` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locid` (`locid`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1000 ;

INSERT INTO locations (locid, address, latlng, timezone)
  VALUES (
    '12ParleyVale',
    '12 Parley Vale, Boston, MA 02130, USA',
    '{"lat":42.3150229,"lng":-71.111138}',
    'America/New_York'
  )
  INSERT INTO locations (locid, address, latlng, timezone)
    VALUES (
      '255Chestnut',
      '255 Chestnut Ave, Jamaica Plain, MA 02130, USA',
      '{"lat":42.31381409999999,"lng":-71.10874749999999}',
      'America/New_York'
    )
    INSERT INTO locations (locid, address, latlng, timezone)
      VALUES (
        '794048thS',
        '7940 48th Ave S, Seattle, WA 98118, USA',
        '{"lat":47.5303635,"lng":-122.2724899}',
        'America/Los_Angeles'
      )
      INSERT INTO locations (locid, address, latlng, timezone)
        VALUES (
          '4505NHaight',
          '4505 N Haight Ave, Portland, OR 97217, USA',
          '{"lat":45.5555363,"lng":-122.6703647}',
          'America/Los_Angeles'
        )

DROP TABLE IF EXISTS `devs`;
CREATE TABLE IF NOT EXISTS `devs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `locid` varchar(20) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `locid` (`locid`),
  KEY `owner` (`owner`),
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

INSERT INTO `devs` (`devid`, devpwd, description, bizid, server,specs,owner)
SELECT `devid`,
       devpwd,
       description,
       bizid,
       server,
       specs,
       owner
FROM `devices`;

TRUNCATE TABLE devs;

UPDATE devs SET locid='12ParleyVale'


DROP TABLE IF EXISTS `user_app_loc_dev`;
DROP TABLE IF EXISTS `user_app_dev`;
CREATE TABLE IF NOT EXISTS `user_app_dev` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `devid` varchar(30) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `appid` (`appid`),
  KEY `devid` (`devid`),
  KEY `role` (`role`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

select locids for user and app
select devices for locid and user and app

CREATE TABLE user_app_loc AS
SELECT DISTINCT userid,
                appid,
                ROLE
FROM user_app_dev;


ALTER TABLE user_app_loc ADD id int(11) NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);

ALTER TABLE `user_app_loc` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE user_app_loc ADD locid varchar(40), ADD KEY (locid);
ALTER TABLE user_app_loc ADD devid varchar(40), ADD KEY (devid);

ALTER TABLE user_app_loc CHANGE `rolle` `role` VARCHAR(20);

UPDATE user_app_loc SET locid =
 ELT(1 + FLOOR(RAND()*4), '12ParleyVale', '255Chestnut', '4505NHaight', '794048thAvS');

 SELECT userid,
        appid,
        locid
 FROM user_app_loc
 WHERE userid = 'tim@sitebuilt.net'
   AND appid= 'hvac';

SELECT *
FROM user_app_loc
WHERE userid = 'tim@sitebuilt.net'
 AND appid= 'hvac';


SELECT u.userid, u.appid, u.locid, d.devid
FROM user_app_loc u
LEFT JOIN devs d ON d.locid= u.locid
WHERE u.userid = 'tim@sitebuilt.net'
  AND u.appid= 'hvac';

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale')

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale')

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '255Chestnut')
   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`, `devid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '255Chestnut', 'CYURD050')

UPDATE user_app_loc
SET locid = '4505NHaight'
WHERE locid = '4505N Haight'


UPDATE user_app_loc
SET devid = 'CYURD003'
WHERE appid = 'hvac'
AND locid = '12ParleyVale'
AND userid = 'tim@sitebuilt.net'

UPDATE user_app_loc
SET locid = '12ParleyVale'
WHERE locid = '12parleyVale'

INSERT into user_app_loc (userid, appid, role, locid, devid)
VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12parleyVale', 'CYURD003')
---------------end of IOTexpress2.0 table creation------------
---------------- exploratory queries--------
SELECT *
FROM user_app_loc
WHERE userid ='mckenna.tim@gmail.com'

SELECT *
FROM user_app_loc
WHERE userid ='tim@sitebuilt.net'
AND devid IS NOT null

SELECT *
FROM user_app_loc
WHERE userid ='mckenna.tim@gmail.com'
AND devid IS NOT null
AND (role="admin" OR role="super") 

INSERT INTO `user_app_loc` 
(`id`, `userid`, `appid`, `role`, `locid`, `devid`) 
VALUES 
(NULL, 'mckenna.tim@gmail.com', 'admind', 'super', '1NearwaterAve', 'CYURD14I');

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
DROP INDEX `locid`, 
ADD INDEX `locid` (`locid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `userid` (`userid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `appid` (`appid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `role` (`role`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD UNIQUE `main` (`userid`, `appid`, `devid`, `role`, `locid`) 
USING BTREE;

SELECT * FROM `user_app_loc` 
ORDER BY `userid`, `appid`, `role`, `locid`, `devid`  
ASC 

ALTER TABLE `geniot`.`user_app_loc`
DROP INDEX `locid`,
           ADD INDEX `locid` (`locid`) USING BTREE;

ALTER TABLE `geniot`.`user_app_loc`
DROP INDEX `locid`,
           ADD INDEX `locid` (`locid`) USING BTREE;

SELECT DISTINCT u.devid
FROM user_app_loc u, devs d
WHERE d.devid=u.devid
    AND u.userid='tim@sitebuilt.net'
    AND u.appid='hvac'
    AND d.locid='12ParleyVale'

  ----------------queries in the api2.0---------------------

SELECT d.devid,
       d.devpwd,
       d.description,
       d.bizid,
       d.locid,
       l.address,
       l.latlng,
       l.timezone,
       d.server,
       d.specs,
       d.owner,
       d.apps
FROM devs d, locations l
WHERE d.locid=l.locid
ORDER BY d.devid

SELECT devs.devid,
       devs.devpwd,
       devs.description,
       devs.bizid,
       devs.locid,
       locations.address,
       locations.latlng,
       locations.timezone,
       devs.server,
       devs.specs,
       devs.owner,
       devs.apps
FROM devs, locations       
WHERE devs.locid = locations.locid
ORDER BY devs.devid

SELECT * FROM  app_loc 
WHERE appid="hvac" 
AND locid="12ParleyVale"


SELECT DISTINCT d.locid
FROM user_app_loc u , devs d
WHERE u.devid=d.devid
    AND u.userid='tim@sitebuilt.net'
    AND u.appid='hvac'
ORDER BY d.locid ASC

INSERT INTO user_app_loc
SET `devid` = 'CYURD14I',
    `userid` = 'tim3@sitebuilt.net',
    `appid` = 'hvac',
    `role` = 'user' 
ON DUPLICATE KEY
UPDATE `devid` = 'CYURD14I',
       `userid` = 'tim2@sitebuilt.net',
       `appid` = 'hvac',
       `role` = 'user'


INSERT INTO devuserapp
SET `devid` = 'CYURD14I',
    `userid` = 'tim2@sitebuilt.net',
    `appid` = 'hvac',
    `role` = 'user' ON DUPLICATE KEY
UPDATE `devid` = 'CYURD14I',
       `userid` = 'tim2@sitebuilt.net',
       `appid` = 'hvac',
       `role` = 'user'

----------------equeries in the api -----------------

--ex2.0/strategy/ln30
SELECT userid, devid 
FROM user_app_loc 
WHERE userid= 'mckenna.tim@gmail.com' 
AND devid IS NOT null

---dedata.get/apps index.js:21 

---admind2.0/super/devinfo 
SELECT * FROM user_app_loc 
WHERE userid ='mckenna.tim@gmail.com' 
AND devid IS NOT null 
AND (role="admin" OR role="super")

---dedata/index:184.post/dev 
INSERT INTO user_app_loc
SET `userid` = 'tim@sitebuilt.net',
`role` = 'admin',
`locid` = '12ParleyVale',
`devid` = 'CYURD007',
`appid` = 'admin' ON DUPLICATE KEY
UPDATE `userid` = 'tim@sitebuilt.net',
`role` = 'admin',
`locid` = '12ParleyVale',
`devid` = 'CYURD007',
`appid` = 'admin'

---dedata/index.js:204.post/dev  /super/CYURD14I
INSERT INTO locations
SET `locid` = '12ParleyVale',
`address` = '12 Parley Vale, Jamaica Plain, MA 02130',
`latlng` = '{\"lat\":42.315,\"lng\":-71.111}',
`timezone` = 'America/New_York' ON DUPLICATE KEY
UPDATE `locid` = '12ParleyVale',
`address` = '12 Parley Vale, Jamaica Plain, MA 02130',
`latlng` = '{\"lat\":42.315,\"lng\":-71.111}',
`timezone` = 'America/New_York'

---dedata/index.js:213.post/dev  /super/CYURD14I 
INSERT INTO devs
SET `devid` = 'CYURD007',
`bizid` = 'sbs',
`description` = '2 temps, 3 timers 1 relay demo board',
`locid` = '12ParleyVale',
`server` = '{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}',
`specs` = '{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}',
`owner` = 'tim@sitebuilt.net',
`apps` = '[\"admin\", \"user\"]' ON DUPLICATE KEY
UPDATE `devid` = 'CYURD007',
`bizid` = 'sbs',
`description` = '2 temps, 3 timers 1 relay demo board',
`locid` = '12ParleyVale',
`server` = '{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}',
`specs` = '{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}',
`owner` = 'tim@sitebuilt.net',
`apps` = '[\"admin\", \"user\"]'

------dedata/index.js:108.get/dev  /super/CYURD14I 
SELECT d.devid,
       d.devpwd,
       d.description,
       d.bizid,
       d.locid,
       l.address,
       l.latlng,
       l.timezone,
       d.server,
       d.specs,
       d.owner,
       d.apps
FROM devs d, locations l
WHERE d.locid=l.locid
ORDER BY d.devid

SELECT l.timezone
FROM locations l,
     devs d
WHERE l.locid=d.locid
    AND d.devid='CYURD003'
------dedata/index.js:84.get/users/:devid  /admin/CYURD14I 
SELECT * 
FROM user_app_loc 
WHERE devid='CYURD003'

SELECT DISTINCT locid
FROM `user_app_loc`
WHERE userid='tim@sitebuilt.net'
  AND appid='hvac'
ORDER BY `locid` ASC

SELECT devid
FROM `user_app_loc`
WHERE userid='tim@sitebuilt.net'
  AND appid='hvac'
  AND locid='12ParleyVale'
ORDER BY `locid` ASC

----------------end of queries in the api -----------------

DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `appurl` (`appurl`),
  KEY `apiurl` (`apiurl`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;


INSERT INTO apps (appid) VALUES ('admind')
INSERT INTO apps (appid) VALUES ('shroom')
INSERT INTO apps (appid) VALUES ('pahoRawSB')
INSERT INTO apps (appid) VALUES ('cascada')
INSERT INTO apps (appid) VALUES ('hvac')
INSERT INTO apps (appid) VALUES ('lightsoff')

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(80) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;


--------------original Tables------------------------
DROP TABLE IF EXISTS `scheds`;
CREATE TABLE `scheds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `dow` int(2) NOT NULL,
  `senrel` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devid` (`devid`),
  KEY `dow` (`dow`),
  KEY `senrel` (`senrel`),
  UNIQUE KEY `main` (`devid`, `dow`, `senrel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1000 ;

CREATE TABLE IF NOT EXISTS `bizapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `appid` (`appid`),
  UNIQUE KEY `main` (`bizid`, `appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=300 ;

CREATE TABLE IF NOT EXISTS `devuserapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) DEFAULT NULL,
  `userid` varchar(24) NOT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `auth` boolean DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devid` (`devid`),
  KEY `userid` (`userid`),
  KEY `appid` (`appid`),
  KEY `role` (`role`),
  KEY `auth` (`auth`),
  UNIQUE KEY `main` (`devid`, `userid`, `bizid`, `appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=200 ;

DROP TABLE IF EXISTS `devices`;
CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `apps` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `specs` (`specs`),
  KEY `owner` (`owner`),
  KEY `location` (`location`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

SELECT DISTINCT `userid` FROM `devuserapp` ;
SELECT DISTINCT devuserapp.userid FROM devuserapp
SELECT DISTINCT devuserapp.userid, devs.devid FROM devuserapp, devs ;
CREATE TABLE temp AS SELECT DISTINCT devuserapp.userid, devs.devid FROM devuserapp, devs ;
CREATE TABLE temp2 AS SELECT DISTINCT temp.userid, temp.devid, apps.appid FROM temp, apps ;

INSERT INTO `user_app_dev` (userid, appid, devid,role)
SELECT userid, appid, devid, "user"
FROM `temp2`;

CREATE TABLE IF NOT EXISTS `biz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) NOT NULL,
  `bizname` varchar(120) DEFAULT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `bizname` (`bizname`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=500 ;

-- a slow build
SELECT * FROM `devuserapp` d
LEFT JOIN `devices`e
ON d.devid=e.devid

SELECT * FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid


SELECT d.userid, d.devid, d.appid, e.description, a.desc
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid

SELECT d.userid, d.devid, d.appid, e.description, a.desc
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid
WHERE d.userid="mckenna.tim@gmail.com"

SELECT d.userid, d.devid, e.description as devdesc, d.appid,  a.desc as appdesc, d.role, d.auth
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid
WHERE d.userid="mckenna.tim@gmail.com"


SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  devuserapp d
LEFT JOIN
  devices e ON d.devid = e.devid
WHERE
  d.userid = 'mckenna.tim@gmail.com'

SELECT
  devid,
  description,
  owner
FROM
  `devices`
WHERE
  owner ='tim@sitebuilt.net'
ORDER BY
  devid;
-- last is it
SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  `devuserapp` d
LEFT JOIN
  `devices` e ON d.devid = e.devid
WHERE
  d.userid = 'tim@sitebuilt.net'
AND
(d.appid='admin' OR d.appid='super')

SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  `devuserapp` d
LEFT JOIN
  `devices` e ON d.devid = e.devid
WHERE
  d.userid = 'mckenna.tim@gmail.com'
AND
(d.appid='admin' OR d.appid='super')
