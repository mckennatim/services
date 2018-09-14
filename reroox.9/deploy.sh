#!/bin/sh
mysqldump -uroot -p --opt reroo > sql/reroo.sql
scp -r ../reroox root@sitebuilt.net:/home/services
