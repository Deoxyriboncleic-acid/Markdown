# linux的账号和用户组管理

### 本篇文章诞生的前提

超算队的服务器从单用户转变为多用户，产生了许许多多的问题，莫名其妙的一个人目录下的文件权限就发生了改变。为了方便管理决定还是使用一个人进行管理。

## 基础普及（非运维）
#### 用户与用户组的概念

1. 文件拥有者
2. 用户组的概念
3. 其他人的概念

#### 用户组分类

1. 有效用户组
2. 初始用户组

#### linux文件权限概念

- chgrp：修改文件所属用户组
- chown：修改文件拥有者
- [chmod](https://www.redhat.com/sysadmin/suid-sgid-sticky-bit)：修改文件的权限，SUID，SGID，SBIT

#### 用户标识符

**每个人只有一个UID**

- UID
- GID

```shell
id dmstai #dmstai 是用户名字
```

##### groups：查看支持的用户组

##### newgrp：有效用户组切换

#### PS：

每次工作的时候切换到目的的工作组，不会的指令自行**RTFM**。

这样创建的文件就可以在用户组间了。



## 运维知识

### 关于用户和用户组

**UID**：/etc/passwd

![image-20230523144031846](/Users/wqy/Library/Application Support/typora-user-images/image-20230523144031846.png)

#### UID解析

1.  账号名称
2. 密码：显示为x，密码存储到/etc/shadow 了
3. UID
4. GID
5. 用户信息说明栏
6. 家目录
7. shell

PS：UID的限制：

| ID范围                  | 该ID的用户特性                                               |
| ----------------------- | ------------------------------------------------------------ |
| 0(系统管理员)           | 和root账号的权限一样，不建议很多人拥有最高权限               |
| 1～999(系统账号)        | 1～200:有linux发行版自行建立的系统账号   201～999：用户有系统需求时，自行可以使用的UID |
| 1000～60000(可登陆帐号) | 给一般用户使用                                               |



**GID**: /etc/group

![image-20230523152830130](/Users/wqy/Library/Application Support/typora-user-images/image-20230523152830130.png)

#### GID解析

1. 组名
2. 用户组密码：密码存储在/etc/gshadow中
3. GID
4. 此用户组支持的账号名称

**密码表**：/etc/shadow

![image-20230523144557077](/Users/wqy/Library/Application Support/typora-user-images/image-20230523144557077.png)

#### 密码表解析：

1. 账号名称
2. 密码（经过编码的密码）
3. 最近修改密码的日期
4. 密码不可被修改的天数（与第三字段相比）
5. 密码需要修改的天数（与第三字段相比）
6. 密码需要修改期限的警告天数（与第五字段相比）
7. 密码过期后的账号宽限时间（密码失效日）（与第五字段相比）
8. 账号失效日期
9. 保留

PS：这一段意义应该不大，并且还复杂，碰到的时候查鸟哥就好啦

#### 密码忘记啦，该怎么办

- 一般用户：root使用passwd解决
- root用户：启动linux，修改shadow文件。例如：重新进入单人维护模式，系统会给一个root权限的bash接口，现在使用passwd就可以更改   或者    Live CD启动后挂载根目录去修改/etc/shadow 直接把里面的密码清空，下次开机的时候就不需要密码。

### 刚进行ssh时系统的操作

1. 先去查找/etc/passwd里面是否有你输入的账号，有的话将UID和GID**读出**，并且把**shell设置和账户家目录**一起读出来
2. **核对密码表**，根据刚刚的UID核对
3. 如果一切正常进入**shell**管理阶段

**PS：详细说明参考man 5 passed and man 5 shadow**

> 从上述文件中可以发现有许多的账户是系统创建的，作用是维护系统的正常进行，我们可以简称为**系统账号**，请不要随便删除。



## 账号管理

#### useradd：新增账户

#### usermod：对user设置的参数进行修改。

PS：当然可以**/etc/passwd**和**/etc/shadow**进行修改

#### userdel：删除用户相关数据



#### passwd:账号密码设置

#### change:密码参数显示

## 用户功能

#### finger:检查用户信息

#### chfn：修改用户finger数据

#### chsh：change shell

## 用户组管理 

#### groupadd：新增用户组

#### groupmod：修改用户组

#### groupdel：删除用户组



#### PS：ACL的知识RTFM



