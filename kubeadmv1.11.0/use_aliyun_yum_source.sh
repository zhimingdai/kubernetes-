#!/bin/bash

#centos7配置使用阿里云的yum源

set -e

#直接把文件放在当前目录里面，也可以执行下一行的命令从网上下载
#wget -O /etc/yum.repos.d/CentOS7-Aliyun.repo http://mirrors.aliyun.com/repo/Centos-7.repo
cp -p ./CentOS7-Aliyun.repo /etc/yum.repos.d
yum clean all
yum makecache -y
yum repolist all

yum install wget -y
