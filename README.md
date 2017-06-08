# docker-orgdev

## 使用

自动安装请执行：

```
docker run --name smartwiki -p 80:80 -e DB_HOST=192.168.4.104 -e DB_PORT=3306 -e DB_DATABASE=smartwiki -e DB_USERNAME=root -e DB_PASSWORD=123456 -e ACCOUNT=admin -e PASSWORD=123456 -e EMAIL=admin@iminho.me -e APACHE_HOST=demo.iminho.me -v /var/www/html:/var/www/html/public/uploads -d daocloud.io/lifei6671/docker-smartwiki:latest
```

## 变量使用

DB_HOST 数据库地址

DB_DATABASE 数据库名称

DB_PORT 数据库端口号

DB_USERNAME 数据库用户名

DB_PASSWORD 数据库密码

ACCOUNT 管理员账号

PASSWORD 管理员密码

EMAIL  管理员邮箱

APACHE_HOST 使用的域名

## DaoCloud镜像

```
docker pull daocloud.io/lifei6671/docker-smartwiki:latest
```
