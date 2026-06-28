# 客户管理系统 API 接口文档

## 1. 通用约定

### 1.1 Base URL

- **本地开发**：`http://127.0.0.1:8000`
- **API 前缀**：所有接口均以 `/api/` 开头

### 1.2 鉴权方式

除登录接口外，所有接口均需在请求头中携带 JWT Token：

```http
Authorization: Bearer <token>
```

Token 有效期为 7 天（10080 分钟）。

### 1.3 响应格式说明

本项目存在三种响应格式，请根据模块注意区分：

**格式 A（LX 模块 / 部分 Fmy 模块）**：

```json
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

**格式 B（WJC 的 applicant / inventor）**：

```json
{
    "code": 200,
    "msg": "查询成功",
    "data": {}
}
```

**格式 C（Gyz 模块 / WJC 的 business & enterprise / Fmy 的 ip-right & contact）**：

```json
{
    "success": true,
    "message": "获取成功",
    "data": {}
}
```

### 1.4 分页响应格式

分页接口通常返回以下结构：

```json
{
    "data": [],
    "meta": {
        "current_page": 1,
        "per_page": 15,
        "total": 100,
        "last_page": 7
    }
}
```

或 WJC 模块的：

```json
{
    "total": 100,
    "pages": 7,
    "current_page": 1,
    "list": []
}
```

### 1.5 请求参数命名规范

- 请求参数统一使用 **camelCase**（小驼峰）
- 后端在存储前自动转换为 **snake_case**（下划线）
- 响应数据统一转换为 **camelCase**

---

## 2. 认证模块

### 2.1 用户登录

- **接口地址**：`POST /api/v1/login`
- **描述**：获取 JWT Token，后续请求需在 Header 中携带。
- **请求头**：无需 `Authorization`
- **请求体 (Request Body)**：

```json
{
    "username": "LX",
    "password": "123456"
}
```

| 参数名     | 类型   | 必填 | 说明       |
| ---------- | ------ | ---- | ---------- |
| username   | string | 是   | 用户名/工号 |
| password   | string | 是   | 密码       |

- **响应示例**：

```json
{
    "code": 0,
    "message": "登录成功",
    "data": {
        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
        "tokenType": "bearer",
        "expiresIn": 604800
    }
}
```

---

## 3. 用户管理模块 (LX)

### 3.1 新增用户

- **接口地址**：`POST /api/v1/users`
- **描述**：创建系统用户账号。
- **请求体**：

```json
{
    "username": "zhangsan",
    "password": "123456",
    "realName": "张三",
    "gender": 1,
    "deptId": 1,
    "jobTitle": "专利代理师",
    "email": "zhangsan@example.com",
    "phone": "13800138000",
    "professionalLevel": "LEVEL_A",
    "businessLevel": "LEVEL_B",
    "status": 1,
    "employmentStatus": 1
}
```

| 参数名            | 类型    | 必填 | 说明                     |
| ----------------- | ------- | ---- | ------------------------ |
| username          | string  | 是   | 用户名/工号              |
| password          | string  | 是   | 密码                     |
| realName          | string  | 是   | 真实姓名                 |
| gender            | integer | 否   | 性别：0-未知，1-男，2-女 |
| deptId            | integer | 是   | 所属部门ID               |
| jobTitle          | string  | 否   | 职位                     |
| email             | string  | 是   | 邮箱                     |
| phone             | string  | 是   | 手机号                   |
| professionalLevel | string  | 否   | 专业等级                 |
| businessLevel     | string  | 否   | 商务等级                 |
| status            | integer | 是   | 账号状态：1-启用，0-禁用 |
| employmentStatus  | integer | 是   | 在职状态：1-在职，0-离职 |

- **响应格式**：格式 A

### 3.2 获取用户详情

- **接口地址**：`GET /api/v1/users/{id}`
- **描述**：获取单个用户详细信息。
- **路径参数**：`id` - 用户ID
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": {
        "id": 1,
        "username": "zhangsan",
        "realName": "张三",
        "gender": 1,
        "deptId": 1,
        "deptName": "专利部",
        "jobTitle": "专利代理师",
        "email": "zhangsan@example.com",
        "phone": "13800138000",
        "professionalLevel": "LEVEL_A",
        "businessLevel": "LEVEL_B",
        "status": 1,
        "employmentStatus": 1
    }
}
```

### 3.3 修改用户

- **接口地址**：`PUT /api/v1/users/{id}`
- **描述**：更新用户信息。`password` 为空时不修改密码。
- **路径参数**：`id` - 用户ID
- **请求体**：同 3.1，password 为可选
- **响应格式**：格式 A

---

## 4. 部门管理模块 (LX)

### 4.1 获取部门树形结构

- **接口地址**：`GET /api/v1/depts/tree`
- **描述**：获取部门树，用于下拉选择或左侧导航。
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 1,
            "label": "总公司",
            "children": [
                {
                    "id": 2,
                    "label": "研发部",
                    "children": []
                }
            ]
        }
    ]
}
```

### 4.2 新增部门

- **接口地址**：`POST /api/v1/depts`
- **请求体**：

```json
{
    "parentId": 0,
    "deptName": "测试部",
    "deptCode": "DEPT001",
    "leaderId": 1,
    "leaderName": "张三",
    "description": "部门描述",
    "remark": "备注"
}
```

| 参数名      | 类型    | 必填 | 说明                  |
| ----------- | ------- | ---- | --------------------- |
| parentId    | integer | 是   | 父部门ID，0为顶级部门 |
| deptName    | string  | 是   | 部门名称              |
| deptCode    | string  | 是   | 部门编码（唯一）      |
| leaderId    | integer | 否   | 负责人ID              |
| leaderName  | string  | 否   | 负责人姓名            |
| description | string  | 否   | 描述                  |
| remark      | string  | 否   | 备注                  |

### 4.3 修改部门

- **接口地址**：`PUT /api/v1/depts/{id}`
- **路径参数**：`id` - 部门ID
- **请求体**：同 4.2

---

## 5. 菜单管理模块 (LX)

### 5.1 创建菜单

- **接口地址**：`POST /api/v1/menus`
- **请求体**：

```json
{
    "parentId": 0,
    "menuName": "客户管理",
    "menuType": "M",
    "perms": "customer:view",
    "path": "/customer",
    "icon": "el-icon-user",
    "sortOrder": 1
}
```

| 参数名    | 类型    | 必填 | 说明                          |
| --------- | ------- | ---- | ----------------------------- |
| parentId  | integer | 否   | 父菜单ID，0为顶级             |
| menuName  | string  | 是   | 菜单名称                      |
| menuType  | string  | 是   | 菜单类型：M-目录，C-菜单，F-按钮 |
| perms     | string  | 否   | 权限标识                      |
| path      | string  | 否   | 路由地址                      |
| icon      | string  | 否   | 图标                          |
| sortOrder | integer | 否   | 排序                          |

### 5.2 获取菜单树形结构

- **接口地址**：`GET /api/v1/menus/tree`
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 1,
            "label": "客户管理",
            "menuType": "M",
            "children": [
                {
                    "id": 2,
                    "label": "客户列表",
                    "menuType": "C"
                }
            ]
        }
    ]
}
```

---

## 6. 角色管理模块 (LX)

### 6.1 创建角色

- **接口地址**：`POST /api/v1/roles`
- **请求体**：

```json
{
    "roleName": "客服人员",
    "roleKey": "customer_service",
    "description": "负责客户咨询",
    "status": 1,
    "sortOrder": 1
}
```

| 参数名      | 类型    | 必填 | 说明       |
| ----------- | ------- | ---- | ---------- |
| roleName    | string  | 是   | 角色名称   |
| roleKey     | string  | 是   | 角色标识（唯一） |
| description | string  | 否   | 描述       |
| status      | integer | 否   | 状态：1-启用，0-禁用 |
| sortOrder   | integer | 否   | 排序       |

### 6.2 获取角色列表

- **接口地址**：`GET /api/v1/roles`
- **查询参数**：

| 参数名   | 类型    | 必填 | 说明           |
| -------- | ------- | ---- | -------------- |
| pageNum  | integer | 否   | 页码，默认 1   |
| pageSize | integer | 否   | 每页条数，默认 10 |
| roleName | string  | 否   | 角色名称模糊搜索 |

- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": {
        "total": 100,
        "rows": [
            {
                "id": 1,
                "roleName": "客服人员",
                "roleKey": "customer_service",
                "description": "负责客户咨询",
                "status": 1,
                "createTime": "2026-06-26 15:30:00"
            }
        ]
    }
}
```

### 6.3 获取角色详情

- **接口地址**：`GET /api/v1/roles/{id}`
- **路径参数**：`id` - 角色ID

### 6.4 修改角色

- **接口地址**：`PUT /api/v1/roles/{id}`
- **路径参数**：`id` - 角色ID
- **请求体**：同 6.1

### 6.5 删除角色

- **接口地址**：`DELETE /api/v1/roles/{id}`
- **路径参数**：`id` - 角色ID

### 6.6 获取角色已选菜单

- **接口地址**：`GET /api/v1/roles/{id}/menus`
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [1, 2, 5, 10]
}
```

### 6.7 分配角色菜单权限

- **接口地址**：`PUT /api/v1/roles/{id}/menus`
- **请求体**：

```json
{
    "menuIds": [1, 2, 5, 10, 12]
}
```

| 参数名  | 类型    | 必填 | 说明               |
| ------- | ------- | ---- | ------------------ |
| menuIds | array   | 是   | 菜单ID数组         |
| menuIds.* | integer | 是   | 菜单ID，须存在     |

---

## 7. 字典管理模块 (LX)

以下字典接口均遵循统一的 CRUD 模式，响应格式为格式 A。

### 7.1 客户等级 (customer-levels)

| 方法   | 路径                              | 说明         |
| ------ | --------------------------------- | ------------ |
| GET    | `/api/v1/customer-levels`         | 获取列表     |
| POST   | `/api/v1/customer-levels`         | 创建         |
| PUT    | `/api/v1/customer-levels/{id}`    | 修改         |
| DELETE | `/api/v1/customer-levels/{id}`    | 删除         |

**字段说明**：

| 参数名      | 类型    | 必填 | 说明       |
| ----------- | ------- | ---- | ---------- |
| levelName   | string  | 是   | 等级名称   |
| levelCode   | string  | 否   | 等级编码   |
| sortOrder   | integer | 否   | 排序       |
| description | string  | 否   | 描述       |
| status      | integer | 否   | 状态 0/1   |

### 7.2 客户规模 (customer-scales)

| 方法   | 路径                              | 说明         |
| ------ | --------------------------------- | ------------ |
| GET    | `/api/v1/customer-scales`         | 获取列表     |
| POST   | `/api/v1/customer-scales`         | 创建         |
| PUT    | `/api/v1/customer-scales/{id}`    | 修改         |
| DELETE | `/api/v1/customer-scales/{id}`    | 删除         |

**字段说明**：

| 参数名    | 类型    | 必填 | 说明     |
| --------- | ------- | ---- | -------- |
| scaleName | string  | 是   | 规模名称 |
| sortOrder | integer | 否   | 排序     |
| status    | integer | 否   | 状态 0/1 |

### 7.3 文件描述 (file-descriptions)

| 方法   | 路径                               | 说明         |
| ------ | ---------------------------------- | ------------ |
| GET    | `/api/v1/file-descriptions`        | 获取列表     |
| POST   | `/api/v1/file-descriptions`        | 创建         |
| PUT    | `/api/v1/file-descriptions/{id}`   | 修改         |
| DELETE | `/api/v1/file-descriptions/{id}`   | 删除         |

**字段说明**：

| 参数名            | 类型    | 必填 | 说明             |
| ----------------- | ------- | ---- | ---------------- |
| projectType       | string  | 是   | 项目类型         |
| countryCode       | string  | 是   | 国家代码         |
| fileCategoryId    | integer | 是   | 文件分类ID       |
| fileSubcategoryId | integer | 是   | 文件子分类ID     |
| fileNameTemplate  | string  | 否   | 文件名模板       |
| fileCodeRule      | string  | 否   | 文件编码规则     |
| internalCode      | string  | 否   | 内部编码         |
| authRole          | string  | 否   | 权限角色（逗号分隔） |
| sortOrder         | integer | 否   | 排序             |
| status            | integer | 否   | 状态 0/1         |

### 7.4 文件分类 (file-categories)

| 方法   | 路径                               | 说明         |
| ------ | ---------------------------------- | ------------ |
| GET    | `/api/v1/file-categories`          | 获取列表     |
| POST   | `/api/v1/file-categories`          | 创建         |
| PUT    | `/api/v1/file-categories/{id}`     | 修改         |
| DELETE | `/api/v1/file-categories/{id}`     | 删除         |

**字段说明**：

| 参数名   | 类型    | 必填 | 说明       |
| -------- | ------- | ---- | ---------- |
| name     | string  | 是   | 分类名称   |
| parentId | integer | 否   | 父分类ID   |
| level    | integer | 否   | 层级       |
| sortOrder| integer | 否   | 排序       |
| status   | integer | 否   | 状态 0/1   |

### 7.5 价格指数 (price-indexes)

| 方法   | 路径                               | 说明         |
| ------ | ---------------------------------- | ------------ |
| GET    | `/api/v1/price-indexes`            | 获取列表     |
| POST   | `/api/v1/price-indexes`            | 创建         |
| PUT    | `/api/v1/price-indexes/{id}`       | 修改         |
| DELETE | `/api/v1/price-indexes/{id}`       | 删除         |

**字段说明**：

| 参数名      | 类型    | 必填 | 说明       |
| ----------- | ------- | ---- | ---------- |
| indexName   | string  | 是   | 指数名称   |
| description | string  | 否   | 描述       |
| sortOrder   | integer | 否   | 排序       |
| status      | integer | 否   | 状态 0/1   |

### 7.6 创新指数 (innovation-indexes)

| 方法   | 路径                                | 说明         |
| ------ | ----------------------------------- | ------------ |
| GET    | `/api/v1/innovation-indexes`        | 获取列表     |
| POST   | `/api/v1/innovation-indexes`        | 创建         |
| PUT    | `/api/v1/innovation-indexes/{id}`   | 修改         |
| DELETE | `/api/v1/innovation-indexes/{id}`   | 删除         |

**字段说明**：同 7.5

### 7.7 工业园区 (industrial-parks)

| 方法   | 路径                                | 说明         |
| ------ | ----------------------------------- | ------------ |
| GET    | `/api/v1/industrial-parks`          | 获取列表     |
| POST   | `/api/v1/industrial-parks`          | 创建         |
| PUT    | `/api/v1/industrial-parks/{id}`     | 修改         |
| DELETE | `/api/v1/industrial-parks/{id}`     | 删除         |

**字段说明**：

| 参数名        | 类型    | 必填 | 说明         |
| ------------- | ------- | ---- | ------------ |
| parkName      | string  | 是   | 园区名称     |
| parkCode      | string  | 否   | 园区编码     |
| address       | string  | 否   | 地址         |
| contactPerson | string  | 否   | 联系人       |
| contactPhone  | string  | 否   | 联系电话     |
| description   | string  | 否   | 描述         |
| sortOrder     | integer | 否   | 排序         |
| status        | integer | 否   | 状态 0/1     |

---

## 8. 常量/下拉查询模块 (LX)

以下接口均为 GET 请求，无需额外参数（部分支持 keyword / parentId）。

### 8.1 国家/地区列表

- **接口地址**：`GET /api/v1/countries`
- **响应格式**：格式 A，返回数组

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {"code": "CN", "name": "中国"},
        {"code": "US", "name": "美国"}
    ]
}
```

### 8.2 行业分类列表

- **接口地址**：`GET /api/v1/industry-categories`
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {"code": "C35", "name": "专用设备制造业"},
        {"code": "I63", "name": "电信、广播电视和卫星传输服务"}
    ]
}
```

### 8.3 企业类型列表

- **接口地址**：`GET /api/v1/enterprise-types`
- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {"code": "state_owned", "name": "国有企业"},
        {"code": "private", "name": "民营企业"},
        {"code": "foreign", "name": "外资企业"},
        {"code": "joint_venture", "name": "合资企业"},
        {"code": "other", "name": "其他"}
    ]
}
```

### 8.4 省市区列表

- **接口地址**：`GET /api/v1/regions`
- **查询参数**：

| 参数名   | 类型    | 必填 | 说明           |
| -------- | ------- | ---- | -------------- |
| parentId | integer | 否   | 父级ID，默认 0 |

- **响应示例**：

```json
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 1,
            "regionName": "北京市",
            "regionCode": "110000",
            "regionType": "province",
            "level": 1,
            "parentId": 0,
            "hasChildren": true
        }
    ]
}
```

---

## 9. 申请人/发明人模块 (WJC)

> 响应格式：格式 B（code / msg / data）

### 9.1 申请人接口

| 方法   | 路径                   | 说明       |
| ------ | ---------------------- | ---------- |
| GET    | `/api/applicant/list`  | 获取列表   |
| POST   | `/api/applicant/add`   | 新增       |
| PUT    | `/api/applicant/edit`  | 修改       |
| GET    | `/api/applicant/info`  | 获取详情   |
| DELETE | `/api/applicant/del`   | 删除       |

**GET /api/applicant/list 查询参数**：

| 参数名            | 类型    | 必填 | 说明             |
| ----------------- | ------- | ---- | ---------------- |
| page              | integer | 否   | 页码，默认 1     |
| limit             | integer | 否   | 每页条数，默认 10 |
| customer_name     | string  | 否   | 客户名称模糊搜索 |
| applicant_name_cn | string  | 否   | 申请人名称搜索   |
| applicant_type    | string  | 否   | 申请人类型筛选   |
| is_deleted        | integer | 否   | 是否删除：0-正常，1-已删除 |

**POST /api/applicant/add 请求体**：

```json
{
    "customer_id": 1,
    "customer_name": "XX科技",
    "applicant_name_cn": "张三",
    "applicant_name_en": "Zhang San",
    "applicant_type": "个人",
    "entity_type": "国内申请人",
    "nationality": "中国",
    "id_type": "身份证",
    "id_no": "110101199001011234",
    "fee_reduction_filing": 1,
    "fee_reduction_start": "2026-01-01",
    "fee_reduction_end": "2026-12-31",
    "region_id": 1,
    "street": "科技园南路88号",
    "business_address": "北京市海淀区",
    "address_en": "No.88 Science Park",
    "zip_code": "100000",
    "email": "zhangsan@example.com",
    "phone": "13800138000",
    "attorney_power_no": "AT-2026001",
    "sync_date": "2026-06-01",
    "operator_id": 1,
    "applicant_remark": "备注"
}
```

**PUT /api/applicant/edit 请求体**：同新增，需传 `id`

**GET /api/applicant/info 查询参数**：`id` - 申请人ID

**DELETE /api/applicant/del 查询参数**：`id` - 申请人ID（逻辑删除）

### 9.2 发明人接口

| 方法   | 路径                   | 说明       |
| ------ | ---------------------- | ---------- |
| GET    | `/api/inventor/list`   | 获取列表   |
| POST   | `/api/inventor/add`    | 新增       |
| PUT    | `/api/inventor/edit`   | 修改       |
| GET    | `/api/inventor/info`   | 获取详情   |
| DELETE | `/api/inventor/del`    | 删除       |

**GET /api/inventor/list 查询参数**：

| 参数名        | 类型    | 必填 | 说明             |
| ------------- | ------- | ---- | ---------------- |
| page          | integer | 否   | 页码，默认 1     |
| limit         | integer | 否   | 每页条数，默认 10 |
| customer_name | string  | 否   | 客户名称模糊搜索 |
| name          | string  | 否   | 发明人姓名搜索   |
| is_deleted    | integer | 否   | 是否删除         |

**POST /api/inventor/add 请求体**：

```json
{
    "customer_id": 1,
    "customer_name": "XX科技",
    "name": "李四",
    "english_name": "Li Si",
    "nationality": "中国",
    "id_type": "身份证",
    "id_no": "110101199001011235",
    "phone": "13800138001",
    "landline": "010-12345678",
    "wechat": "lisi_wechat",
    "email": "lisi@example.com",
    "region_id": 1,
    "street_address": "中关村大街1号",
    "address_en": "No.1 Zhongguancun",
    "zip_code": "100000",
    "inventor_remark": "备注",
    "operator_id": 1
}
```

**GET /api/inventor/info 查询参数**：`id` - 发明人ID

**PUT /api/inventor/edit 请求体**：同新增，需传 `id`

**DELETE /api/inventor/del 查询参数**：`id` - 发明人ID（逻辑删除）

---

## 10. 工商信息模块 (WJC)

> 响应格式：格式 C（success / message / data）

| 方法   | 路径                           | 说明       |
| ------ | ------------------------------ | ---------- |
| GET    | `/api/customer-business`       | 获取列表   |
| POST   | `/api/customer-business`       | 新增       |
| GET    | `/api/customer-business/{id}`  | 获取详情   |
| PUT    | `/api/customer-business/{id}`  | 修改       |
| DELETE | `/api/customer-business/{id}`  | 删除       |

**GET /api/customer-business 查询参数**：

| 参数名    | 类型    | 必填 | 说明                       |
| --------- | ------- | ---- | -------------------------- |
| page      | integer | 否   | 页码，默认 1               |
| per_page  | integer | 否   | 每页条数，默认 15          |
| search    | string  | 否   | 关键词搜索                 |
| sort      | string  | 否   | 排序字段，默认 created_at  |
| order     | string  | 否   | 排序方式，默认 desc        |

**POST /api/customer-business 请求体**：

```json
{
    "economy_category_code": "C35",
    "basic_id": 1,
    "established_time": "2020-01-01",
    "employee_count": 100,
    "registered_capital": 5000000.00,
    "main_business_product": "机器人制造",
    "rd_personnel": 20,
    "phd_count": 2,
    "senior_engineer_count": 5,
    "master_count": 8,
    "intermediate_engineer_count": 10,
    "bachelor_count": 30,
    "overseas_returnee_count": 3,
    "business_scope": "机器人研发、生产、销售"
}
```

---

## 11. 企业信息模块 (WJC)

> 响应格式：格式 C

| 方法   | 路径                              | 说明       |
| ------ | --------------------------------- | ---------- |
| GET    | `/api/customer-enterprises`       | 获取列表   |
| POST   | `/api/customer-enterprises`       | 新增       |
| GET    | `/api/customer-enterprises/{id}`  | 获取详情   |
| PUT    | `/api/customer-enterprises/{id}`  | 修改       |
| DELETE | `/api/customer-enterprises/{id}`  | 删除       |

**GET /api/customer-enterprises 查询参数**：

| 参数名    | 类型    | 必填 | 说明                       |
| --------- | ------- | ---- | -------------------------- |
| page      | integer | 否   | 页码，默认 1               |
| per_page  | integer | 否   | 每页条数，默认 15          |
| search    | string  | 否   | 关键词搜索                 |
| sort      | string  | 否   | 排序字段，默认 created_at  |
| order     | string  | 否   | 排序方式，默认 desc        |

**POST /api/customer-enterprises 请求体**：

```json
{
    "company_type": "民营企业",
    "registered_capital": 10000000.00,
    "established_date": "2018-05-20",
    "industry_category": "C35",
    "main_business": "人工智能软件开发与销售",
    "company_website": "https://www.example.com"
}
```

---

## 12. 客户基本信息模块 (Gyz)

> 响应格式：格式 C
> 
> **权限**：列表/详情需登录；增删改需 ADMIN 角色

| 方法   | 路径                        | 说明       |
| ------ | --------------------------- | ---------- |
| GET    | `/api/customer-basic`       | 获取列表   |
| GET    | `/api/customer-basic/{id}`  | 获取详情   |
| POST   | `/api/customer-basic`       | 新增       |
| PUT    | `/api/customer-basic/{id}`  | 修改       |
| DELETE | `/api/customer-basic/{id}`  | 删除       |

**GET /api/customer-basic 查询参数**：

| 参数名    | 类型    | 必填 | 说明                       |
| --------- | ------- | ---- | -------------------------- |
| page      | integer | 否   | 页码，默认 1               |
| per_page  | integer | 否   | 每页条数，默认 15          |
| search    | string  | 否   | 关键词搜索                 |
| sort      | string  | 否   | 排序字段，默认 created_at  |
| order     | string  | 否   | 排序方式，默认 desc        |

**POST /api/customer-basic 请求体**：

```json
{
    "customer_no": "KH20260001",
    "innovation_subject": "国家高新技术企业",
    "innovation_subject_en": "National High-Tech Enterprise",
    "credit_code": "91440300MA5DXXXX1X",
    "legal_representative": "张三",
    "company_contact": "李四",
    "customer_level": "A级",
    "customer_scale": "大型企业",
    "price_index": 1.05,
    "innovation_index": 85.5,
    "contract_count": 3,
    "latest_contract_date": "2026-05-01",
    "remark": "备注信息"
}
```

**响应示例**：

```json
{
    "success": true,
    "message": "新增成功",
    "data": {
        "id": 1,
        "customer_no": "KH20260001",
        "innovation_subject": "国家高新技术企业",
        "innovation_subject_en": "National High-Tech Enterprise",
        "credit_code": "91440300MA5DXXXX1X",
        "legal_representative": "张三",
        "company_contact": "李四",
        "customer_level": "A级",
        "customer_scale": "大型企业",
        "creator": "王五",
        "price_index": 1.05,
        "innovation_index": 85.5,
        "contract_count": 3,
        "latest_contract_date": "2026-05-01",
        "remark": "备注信息",
        "created_at": "2026-06-01 10:00:00",
        "updated_at": "2026-06-10 15:30:00"
    }
}
```

---

## 13. 客户地址模块 (Gyz)

> 响应格式：格式 C
> 
> **权限**：列表/详情需登录；增删改需 ADMIN 角色

| 方法   | 路径                           | 说明       |
| ------ | ------------------------------ | ---------- |
| GET    | `/api/customer-address`        | 获取列表   |
| GET    | `/api/customer-address/{id}`   | 获取详情   |
| POST   | `/api/customer-address`        | 新增       |
| PUT    | `/api/customer-address/{id}`   | 修改       |
| DELETE | `/api/customer-address/{id}`   | 删除       |

**GET /api/customer-address 查询参数**：同 12.1

**POST /api/customer-address 请求体**：

```json
{
    "nationality": "中国",
    "province": "广东省",
    "city": "深圳市",
    "district": "南山区",
    "street_address": "科技园南路88号",
    "address_en": "No.88, Science Park South Road",
    "other_address": "",
    "industrial_park": "深圳湾科技生态园",
    "postal_code": "518000",
    "company_website": "https://www.example.com"
}
```

---

## 14. 客户费用模块 (Gyz)

> 响应格式：格式 C
> 
> **权限**：列表/详情需登录；增删改需 ADMIN 角色

| 方法   | 路径                        | 说明       |
| ------ | --------------------------- | ---------- |
| GET    | `/api/customer-fee`         | 获取列表   |
| GET    | `/api/customer-fee/{id}`    | 获取详情   |
| POST   | `/api/customer-fee`         | 新增       |
| PUT    | `/api/customer-fee/{id}`    | 修改       |
| DELETE | `/api/customer-fee/{id}`    | 删除       |

**GET /api/customer-fee 查询参数**：同 12.1

**POST /api/customer-fee 请求体**：

```json
{
    "account_name": "XX科技有限公司",
    "bank_name": "中国工商银行深圳南山支行",
    "bank_account": "62220240000XXXX0000",
    "invoice_address": "深圳市南山区科技园南路88号",
    "invoice_phone": "0755-12345678",
    "taxpayer_type": "一般纳税人",
    "billing_address": "深圳市南山区科技园南路88号"
}
```

---

## 15. 知识产权模块 (Fmy)

> 响应格式：格式 C

| 方法   | 路径                            | 说明       |
| ------ | ------------------------------- | ---------- |
| GET    | `/api/customer-ip-rights`       | 获取列表   |
| GET    | `/api/customer-ip-rights/{id}`  | 获取详情   |
| POST   | `/api/customer-ip-rights`       | 新增       |
| PUT    | `/api/customer-ip-rights/{id}`  | 修改       |
| DELETE | `/api/customer-ip-rights/{id}`  | 删除       |

**GET /api/customer-ip-rights 查询参数**：

| 参数名    | 类型    | 必填 | 说明                       |
| --------- | ------- | ---- | -------------------------- |
| page      | integer | 否   | 页码，默认 1               |
| per_page  | integer | 否   | 每页条数，默认 15          |
| search    | string  | 否   | 关键词搜索                 |
| sort      | string  | 否   | 排序字段                   |
| order     | string  | 否   | 排序方式 asc/desc          |

**POST /api/customer-ip-rights 请求体**：

```json
{
    "trademark_count": 5,
    "patent_count": 10,
    "authorized_invention_patent_count": 3,
    "copyright_count": 2,
    "has_enjoyed_additional_deduction": true,
    "has_school_enterprise_cooperation": true,
    "cooperative_university_name": "清华大学"
}
```

---

## 16. 客户文件模块 (Fmy)

> 响应格式：格式 A 或格式 C（混合）

| 方法   | 路径                                    | 说明           |
| ------ | --------------------------------------- | -------------- |
| GET    | `/api/customer/files`                   | 获取文件列表   |
| POST   | `/api/customer/files`                   | 上传客户文件   |
| GET    | `/api/customer/files/types/tree`        | 获取文件类型树 |
| GET    | `/api/customer/files/view/{id}`         | 预览文件       |
| GET    | `/api/customer/files/download/{id}`     | 下载文件       |
| DELETE | `/api/customer/files/{id}`              | 删除文件       |

**GET /api/customer/files 查询参数**：

| 参数名       | 类型    | 必填 | 说明         |
| ------------ | ------- | ---- | ------------ |
| fileName     | string  | 否   | 文件名搜索   |
| fileType     | string  | 否   | 文件类型     |
| customerName | string  | 否   | 客户名称搜索 |
| startTime    | date    | 否   | 开始日期     |
| endTime      | date    | 否   | 结束日期     |
| pageNum      | integer | 否   | 页码，默认 1 |
| pageSize     | integer | 否   | 每页条数，默认 10 |

**响应示例**：

```json
{
    "code": 0,
    "message": "查询成功",
    "data": {
        "total": 100,
        "list": [
            {
                "id": "1",
                "serialNo": 1,
                "fileName": "合同.pdf",
                "fileType": "合同文件",
                "uploadTime": "2026-06-01",
                "uploader": "张三",
                "creator": "张三",
                "createTime": "2026-06-01"
            }
        ]
    }
}
```

**POST /api/customer/files 请求体**（multipart/form-data）：

| 参数名       | 类型    | 必填 | 说明           |
| ------------ | ------- | ---- | -------------- |
| fileTypeId   | string  | 是   | 文件类型ID     |
| customerId   | string  | 是   | 客户ID         |
| businessPerson | integer | 否   | 业务人员ID     |
| remark       | string  | 否   | 备注           |
| file         | file    | 是   | 文件，最大 20MB |

**GET /api/customer/files/types/tree 查询参数**：

| 参数名  | 类型   | 必填 | 说明       |
| ------- | ------ | ---- | ---------- |
| keyword | string | 否   | 关键词搜索 |

**响应示例**：

```json
{
    "code": 0,
    "message": "查询成功",
    "data": [
        {
            "id": "1",
            "name": "大分类A",
            "type": "big",
            "children": [
                {
                    "id": 2,
                    "name": "小分类B",
                    "type": "small",
                    "children": [
                        {
                            "id": "2-3",
                            "name": "文件模板",
                            "type": "file"
                        }
                    ]
                }
            ]
        }
    ]
}
```

**GET /api/customer/files/view/{id} 响应示例**：

```json
{
    "code": 0,
    "message": "查询成功",
    "data": {
        "fileName": "合同.pdf",
        "fileUrl": "https://oss.example.com/...",
        "fileType": "合同文件"
    }
}
```

**GET /api/customer/files/download/{id}**：
- 本地存储：直接返回文件流下载
- OSS 存储：返回 302 重定向到签名下载链接

---

## 17. 联系人模块 (Fmy)

> 响应格式：格式 B（code / msg / data）

| 方法   | 路径                           | 说明       |
| ------ | ------------------------------ | ---------- |
| GET    | `/api/contacts`                | 获取列表   |
| POST   | `/api/contacts`                | 新增       |
| GET    | `/api/contacts/{id}`           | 获取详情   |
| PUT    | `/api/customer/contact/{id}`   | 修改       |

**GET /api/contacts 查询参数**：

| 参数名         | 类型    | 必填 | 说明         |
| -------------- | ------- | ---- | ------------ |
| contactName    | string  | 否   | 联系人姓名   |
| customerName   | string  | 否   | 客户名称     |
| contactType    | string  | 否   | 联系人类型   |
| businessPerson | string  | 否   | 业务人员     |
| pageNum        | integer | 否   | 页码，默认 1 |
| pageSize       | integer | 否   | 每页条数，默认 10 |

**响应示例**：

```json
{
    "code": 200,
    "msg": "success",
    "data": {
        "total": 100,
        "list": [
            {
                "id": 1,
                "serialNo": 1,
                "name": "张三",
                "customerName": "XX科技",
                "contactType": "负责人",
                "phone": "13800138000",
                "gender": "未知",
                "isEmployed": 1,
                "position": "经理",
                "email": "zhangsan@example.com",
                "businessPerson": "李四"
            }
        ]
    }
}
```

**POST /api/contacts 请求体**：

```json
{
    "innovationSubjectId": 1,
    "contactType": "负责人",
    "name": "张三",
    "phone": "13800138000",
    "landline": "010-12345678",
    "isEmployed": "1",
    "position": "经理",
    "email": "zhangsan@example.com",
    "businessPersonId": 2,
    "assistantId": 3,
    "techDepartment": "技术部",
    "techLeaderId": 4,
    "workAddress": "北京市海淀区",
    "remark": "备注"
}
```

**GET /api/contacts/{id} 响应示例**：

```json
{
    "code": 200,
    "msg": "success",
    "data": {
        "innovationSubjectId": 1,
        "contactType": "负责人",
        "name": "张三",
        "phone": "13800138000",
        "landline": "010-12345678",
        "isEmployed": 1,
        "position": "经理",
        "email": "zhangsan@example.com",
        "businessPersonId": 2,
        "assistantId": 3,
        "techDepartment": "技术部",
        "techLeaderId": 4,
        "workAddress": "北京市海淀区",
        "remark": "备注",
        "createBy": "admin",
        "createTime": "2026-06-01 10:00:00",
        "updateBy": "admin",
        "updateTime": "2026-06-10 15:30:00"
    }
}
```

**PUT /api/customer/contact/{id} 请求体**：

```json
{
    "customerId": 1,
    "contactType": "负责人",
    "contactName": "张三",
    "gender": "男",
    "mobile": "13800138000",
    "telephone": "010-12345678",
    "isActive": "1",
    "position": "经理",
    "email": "zhangsan@example.com",
    "businessPerson": "2",
    "businessAssistant": "3",
    "techLeadDept": "技术部",
    "techLead": "4",
    "workAddress": "北京市海淀区",
    "remark": "备注"
}
```

---

## 18. 下拉选项模块 (Fmy)

> 响应格式：格式 B（code / msg / data）
> 
> 所有下拉接口均支持 `keyword` 参数进行模糊搜索。

### 18.1 客户下拉选项

- **接口地址**：`GET /api/customer/options`
- **响应示例**：

```json
{
    "code": 200,
    "msg": "success",
    "data": [
        {"id": "1", "name": "国家高新技术企业"},
        {"id": "2", "name": "XX科技有限公司"}
    ]
}
```

### 18.2 创新主体下拉

- **接口地址**：`GET /api/innovation-subjects/options`

### 18.3 联系人类型下拉

- **接口地址**：`GET /api/contact-types/options`

### 18.4 人员下拉（业务人员 / 助理 / 技术主导）

- **接口地址**：
  - `GET /api/staff/options`（业务人员）
  - `GET /api/assistant/options`（业务助理）
  - `GET /api/tech-leaders/options`（技术主导）

**响应示例**：

```json
{
    "code": 200,
    "msg": "success",
    "data": [
        {"id": "1", "name": "张三"},
        {"id": "2", "name": "李四"}
    ]
}
```

---

## 19. 通用文件上传 (Fmy)

> 响应格式：格式 A

- **接口地址**：`POST /api/file/upload`
- **请求体**（multipart/form-data）：

| 参数名 | 类型 | 必填 | 说明 |
| ------ | ---- | ---- | ---- |
| file   | file | 是   | 文件，最大 20MB |

- **响应示例**：

```json
{
    "code": 0,
    "message": "上传成功",
    "data": {
        "fileId": "d41d8cd98f00b204e9800998ecf8427e",
        "fileName": "文档.pdf",
        "fileUrl": "https://oss.example.com/uploads/...",
        "fileSize": 102400
    }
}
```

---

## 20. 附录：HTTP 状态码说明

| 状态码 | 说明                  |
| ------ | --------------------- |
| 200    | 请求成功              |
| 400    | 请求参数错误 / 业务异常 |
| 401    | 未授权（Token 无效或过期） |
| 403    | 无权访问（需要 LEVEL_A 或 ADMIN 角色） |
| 404    | 记录不存在            |
| 422    | 参数校验失败          |
| 500    | 服务器内部错误        |

---

## 21. 附录：角色权限说明

| 角色标识    | 说明                           |
| ----------- | ------------------------------ |
| ADMIN       | 系统管理员，拥有全部操作权限   |
| LEVEL_A     | 高级用户，可进行文件/联系人增删改 |
| 其他        | 普通登录用户，仅可查看         |
