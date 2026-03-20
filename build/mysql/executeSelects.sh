#!/bin/bash
set -e

echo "Esperant que Mysql estigui llest...."
while ! mysqladmin ping -hlocalhost -uroot -p "ArturPassRoot-987" --silent; do
    echo "Mysql no llest encara, esperant..."
    sleep 2
done

echo "MySQL llest. Executant SELECTs..."

mysql -uroot -p"ArturPassRoot-987" < /docker-entrypoing-initdb.d/selectslevel1.sql

echo "Script completat"
