# QuickOn Gogs 应用镜像

![GitHub Workflow Status (event)](https://img.shields.io/github/actions/workflow/status/quicklyon/gogs-docker/docker.yml?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/gogs?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/gogs?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/gogs-docker?style=flat-square)

> 申明: 该软件镜像是由QuickOn打包。在发行中提及的各自商标由各自的公司或个人所有，使用它们并不意味着任何从属关系。

## 快速参考

- 通过 [渠成软件百宝箱](https://www.qucheng.com/app-install/install-gogs-127.html) 一键安装 **Gogs**
- [Dockerfile 源码](https://github.com/quicklyon/gogs-docker)
- [Gogs 源码](https://github.com/gogs/gogs)
- [Gogs 官网](https://gogs.io)

## 一、关于 Gogs

Gogs 的目标是打造一个最简单、最快速和最轻松的方式搭建自助 Git 服务。使用 Go 语言开发使得 Gogs 能够通过独立的二进制分发，并且支持 Go 语言支持的 所有平台，包括 Linux、Mac OS X、Windows 以及 ARM 平台。

![screenshots](https://raw.githubusercontent.com/quicklyon/gogs-docker/master/.template/screenshot.png)

Gogs官网：[https://gogs.io](https://gogs.io)


### 1.1 开源组件

- Web 框架：[Macaron](http://go-macaron.com)
- UI 组件：
  - [Semantic UI](http://semantic-ui.com/)
  - [GitHub Octicons](https://octicons.github.com/)
  - [Font Awesome](http://fontawesome.io/)
- 前端插件：
  - [DropzoneJS](http://www.dropzonejs.com/)
  - [highlight.js](https://highlightjs.org/)
  - [clipboard.js](https://zenorocha.github.io/clipboard.js/)
  - [emojify.js](https://github.com/Ranks/emojify.js)
  - [jQuery Date Time Picker](https://github.com/xdan/datetimepicker)
  - [jQuery MiniColors](https://github.com/claviska/jquery-minicolors)
  - [CodeMirror](https://codemirror.net/)
  - [notebook.js](https://github.com/jsvine/notebookjs)
  - [marked](https://github.com/chjj/marked)
- ORM：[Xorm](https://github.com/go-xorm/xorm)
- 数据库驱动：
  - [github.com/go-sql-driver/mysql](https://github.com/go-sql-driver/mysql)
  - [github.com/lib/pq](https://github.com/lib/pq)
  - [github.com/mattn/go-sqlite3](https://github.com/mattn/go-sqlite3)
  - [github.com/denisenkom/go-mssqldb](https://github.com/denisenkom/go-mssqldb)
- 以及其它所有 Go 语言的第三方包依赖。

## 二、支持的版本(Tag)

由于版本比较多,这里只列出最新的5个版本,更详细的版本列表请参考:[可用版本列表](https://hub.docker.com/r/easysoft/gogs/tags/)

- [`latest`](https://github.com/gogs/gogs/releases)
- [0.12.10](https://github.com/gogs/gogs/releases/tag/v0.12.10)
- [0.12.9](https://github.com/gogs/gogs/releases/tag/v0.12.9)
- [0.12.8](https://github.com/gogs/gogs/releases/tag/v0.12.8)

## 三、获取镜像

推荐从 [Docker Hub Registry](https://hub.docker.com/r/easysoft/gogs) 拉取我们构建好的官方Docker镜像。

```bash
docker pull easysoft/gogs:latest
```

如需使用指定的版本，可以拉取一个包含版本标签的镜像，在Docker Hub仓库中查看 [可用版本列表](https://hub.docker.com/r/easysoft/gogs/tags/)

```bash
docker pull easysoft/gogs:[TAG]
```

## 四、持久化数据

如果你删除容器，所有的数据都将被删除，下次运行镜像时会重新初始化数据。为了避免数据丢失，你应该为容器提供一个挂在卷，这样可以将数据进行持久化存储。

为了数据持久化，你应该挂载持久化目录：

- /data 持久化数据

如果挂载的目录为空，首次启动会自动初始化相关文件

```bash
$ docker run -it \
    -v $PWD/data:/data \
docker pull easysoft/gogs:latest
```

或者修改 docker-compose.yml 文件，添加持久化目录配置

```bash
services:
  Gogs:
  ...
    volumes:
      - /path/to/persistence:/data
  ...
```

## 五、环境变量

| 变量名           | 默认值        | 说明                                |
| ---------------- | ------------- | ----------------------------------|
| DEBUG                  | NULL              | 是否打开调试信息，默认关闭  |
| APP_DOMAIN             | git.demo.com      | gogs域名                 |
| APP_PROTOCOL           | http              | gogs域名协议类型          |
| MYSQL_HOST             | 127.0.0.1         | MySQL连接地址             |
| MYSQL_PORT             | 3306              | MYSQL端口                |
| MYSQL_DB               | gogs              | Gogs数据库名称            |
| MYSQL_USER             | root              | MySQL用户名              |
| MYSQL_PASSWORD         | pass4Gogs         | MySQL密码                |
| MAIL_ENABLED           | false             | 是否启动邮件配置                |
| SMTP_SUBJECT_PREFIX    | [Gogs]            | 邮件主题前缀            |
| SMTP_HOST              | localhost         | 邮件服务器地址            |
| SMTP_PORT              | 25                | 邮件服务器端口            |
| SMTP_USER              | admin@localhost   | 发件人邮箱地址            |
| SMTP_PASS              | NULL              | 发件人密码            |
| SMTP_FROMNAME          | Gogs              | 发件人显示信息           |
| MAIL_DISABLE_HELO      | false             | 是否禁止发送HELO指令     |
| MAIL_HELO_HOST         | SMTP_HOST         | 发送HELO的主机地址     |
| DEFAULT_ADMIN_USERNAME | git-admin         | Gogs默认管理员用户名       |
| DEFAULT_ADMIN_PASSWORD | pass4Git          | Gogs默认管理员密码         |
| ADMIN_EMAIL            | demo@chandao.net  | Gogs管理员邮箱            |
| GIT_FORCE_PRIVATE      | false             | Gogs强制创建私有仓库       |

## 六、运行

### 6.1 单机Docker-compose方式运行

```bash
# 启动服务
make run

# 查看服务状态
make ps

# 查看服务日志
docker-compose logs -f gogs

```
> **说明：**
>
> - 启动成功后，打开浏览器输入 `http://<你的IP>:8083` 访问管理后台
> - 默认用户名：`git-admin`，默认密码：`pass4Git`
- [VERSION](https://github.com/quicklyon/gogs-docker/blob/main/VERSION) 文件中详细的定义了Makefile可以操作的版本。
- [docker-compose.yml](https://github.com/quicklyon/gogs-docker/blob/main/docker-compose.yml)。
