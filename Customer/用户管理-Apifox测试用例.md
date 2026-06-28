# 用户管理模块 - Apifox 测试用例

> 基础地址：`http://127.0.0.1:8000/api/v1`
> 认证方式：Header 中携带 `Authorization: Bearer <token>`

---

## 1. 用户列表

**接口信息**
- 请求方法：`GET`
- 请求地址：`/users`

**请求参数（Query）**
| 参数名 | 类型 | 必填 | 示例值 | 说明 |
|--------|------|------|--------|------|
| page | integer | 否 | 1 | 页码 |
| perPage | integer | 否 | 10 | 每页条数 |
| username | string | 否 | admin | 用户名模糊搜索 |
| realName | string | 否 | 张 | 姓名模糊搜索 |
| deptId | integer | 否 | 2 | 部门ID筛选 |
| status | integer | 否 | 1 | 账号状态：0-禁用，1-启用 |
| employmentStatus | integer | 否 | 1 | 在职状态：0-离职，1-在职 |

**请求示例**
```http
GET /api/v1/users?page=1&perPage=10&status=1 HTTP/1.1
Host: 127.0.0.1:8000
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
```

**成功响应示例**
```json
{
  "success": true,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "username": "admin",
        "realName": "管理员",
        "gender": 1,
        "deptId": 2,
        "deptName": "研发部",
        "roleId": 1,
        "roleName": "ADMIN",
        "jobTitle": "经理",
        "email": "admin@example.com",
        "phone": "13800138000",
        "professionalLevel": "高级",
        "businessLevel": "A级",
        "status": 1,
        "employmentStatus": 1
      }
    ],
    "total": 103,
    "page": 1,
    "perPage": 10,
    "totalPages": 11
  }
}
```

**Apifox 断言**
```javascript
pm.test("状态码为 200", function () {
    pm.response.to.have.status(200);
});
pm.test("返回 success 为 true", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.success).to.eql(true);
});
pm.test("data.list 为数组", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.list).to.be.an('array');
});
pm.test("data.total 大于等于 0", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.total).to.be.at.least(0);
});
```

---

## 2. 新增用户

**接口信息**
- 请求方法：`POST`
- 请求地址：`/users`

**请求头**
```http
Content-Type: application/json
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
```

**请求体（JSON）**
```json
{
  "username": "U2026001",
  "password": "123456",
  "realName": "张三",
  "gender": 1,
  "deptId": 2,
  "roleId": 3,
  "jobTitle": "前端开发",
  "email": "zhangsan@example.com",
  "phone": "13800138001",
  "professionalLevel": "中级",
  "businessLevel": "B级",
  "status": 1,
  "employmentStatus": 1
}
```

**字段说明**
| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| username | string | 是 | 用户名（工号），唯一 |
| password | string | 是 | 密码 |
| realName | string | 是 | 姓名 |
| gender | integer | 否 | 性别：0-未知，1-男，2-女 |
| deptId | integer | 是 | 所属部门ID |
| roleId | integer | 否 | 所属角色ID |
| jobTitle | string | 否 | 职位 |
| email | string | 是 | 邮箱 |
| phone | string | 是 | 手机号 |
| professionalLevel | string | 否 | 专业等级 |
| businessLevel | string | 否 | 商务等级 |
| status | integer | 是 | 账号状态：0-禁用，1-启用 |
| employmentStatus | integer | 是 | 在职状态：0-离职，1-在职 |

**成功响应示例**
```json
{
  "success": true,
  "message": "用户创建成功",
  "data": {
    "id": 21,
    "username": "U2026001",
    "realName": "张三",
    "gender": 1,
    "deptId": 2,
    "deptName": "研发部",
    "roleId": 3,
    "roleName": "LEVEL_A",
    "jobTitle": "前端开发",
    "email": "zhangsan@example.com",
    "phone": "13800138001",
    "professionalLevel": "中级",
    "businessLevel": "B级",
    "status": 1,
    "employmentStatus": 1
  }
}
```

**Apifox 断言**
```javascript
pm.test("状态码为 200", function () {
    pm.response.to.have.status(200);
});
pm.test("返回 success 为 true", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.success).to.eql(true);
});
pm.test("返回 message 为 用户创建成功", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.message).to.eql("用户创建成功");
});
pm.test("返回 data.id 存在", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.id).to.exist;
});
pm.test("返回 data.username 正确", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.username).to.eql("U2026001");
});
```

---

## 3. 用户详情

**接口信息**
- 请求方法：`GET`
- 请求地址：`/users/{id}`

**路径参数**
| 参数名 | 类型 | 必填 | 示例值 | 说明 |
|--------|------|------|--------|------|
| id | integer | 是 | 1 | 用户ID |

**请求示例**
```http
GET /api/v1/users/1 HTTP/1.1
Host: 127.0.0.1:8000
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
```

**成功响应示例**
```json
{
  "success": true,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "admin",
    "realName": "管理员",
    "gender": 1,
    "deptId": 2,
    "deptName": "研发部",
    "roleId": 1,
    "roleName": "ADMIN",
    "jobTitle": "经理",
    "email": "admin@example.com",
    "phone": "13800138000",
    "professionalLevel": "高级",
    "businessLevel": "A级",
    "status": 1,
    "employmentStatus": 1
  }
}
```

**Apifox 断言**
```javascript
pm.test("状态码为 200", function () {
    pm.response.to.have.status(200);
});
pm.test("返回 success 为 true", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.success).to.eql(true);
});
pm.test("返回 data.id 为 1", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.id).to.eql(1);
});
pm.test("返回 data.deptName 不为空", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.deptName).to.not.be.empty;
});
```

---

## 4. 修改用户

**接口信息**
- 请求方法：`PUT`
- 请求地址：`/users/{id}`

**路径参数**
| 参数名 | 类型 | 必填 | 示例值 | 说明 |
|--------|------|------|--------|------|
| id | integer | 是 | 21 | 用户ID |

**请求头**
```http
Content-Type: application/json
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
```

**请求体（JSON）**
```json
{
  "username": "U2026001",
  "password": "",
  "realName": "张三（已修改）",
  "gender": 1,
  "deptId": 3,
  "roleId": 2,
  "jobTitle": "高级前端开发",
  "email": "zhangsan_new@example.com",
  "phone": "13800138001",
  "professionalLevel": "高级",
  "businessLevel": "A级",
  "status": 1,
  "employmentStatus": 1
}
```

**字段说明**
- `password` 传空字符串时不修改密码
- `username` 需保持唯一（排除当前记录）
- 其他字段与新增一致

**成功响应示例**
```json
{
  "success": true,
  "message": "用户更新成功",
  "data": {
    "id": 21,
    "username": "U2026001",
    "realName": "张三（已修改）",
    "gender": 1,
    "deptId": 3,
    "deptName": "产品部",
    "roleId": 2,
    "roleName": "ADMIN",
    "jobTitle": "高级前端开发",
    "email": "zhangsan_new@example.com",
    "phone": "13800138001",
    "professionalLevel": "高级",
    "businessLevel": "A级",
    "status": 1,
    "employmentStatus": 1
  }
}
```

**Apifox 断言**
```javascript
pm.test("状态码为 200", function () {
    pm.response.to.have.status(200);
});
pm.test("返回 success 为 true", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.success).to.eql(true);
});
pm.test("返回 message 为 用户更新成功", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.message).to.eql("用户更新成功");
});
pm.test("返回 data.realName 已更新", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.realName).to.eql("张三（已修改）");
});
pm.test("返回 data.deptId 已更新", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.deptId).to.eql(3);
});
```

---

## 5. 删除用户

**接口信息**
- 请求方法：`DELETE`
- 请求地址：`/users/{id}`

**路径参数**
| 参数名 | 类型 | 必填 | 示例值 | 说明 |
|--------|------|------|--------|------|
| id | integer | 是 | 21 | 用户ID |

**请求示例**
```http
DELETE /api/v1/users/21 HTTP/1.1
Host: 127.0.0.1:8000
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...
```

**成功响应示例**
```json
{
  "success": true,
  "message": "用户删除成功",
  "data": []
}
```

**Apifox 断言**
```javascript
pm.test("状态码为 200", function () {
    pm.response.to.have.status(200);
});
pm.test("返回 success 为 true", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.success).to.eql(true);
});
pm.test("返回 message 为 用户删除成功", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.message).to.eql("用户删除成功");
});
```

---

## Apifox 快速导入建议

在 Apifox 中创建"用户管理"文件夹，按以下方式配置：

1. **环境变量**：在"环境"中设置 `baseUrl = http://127.0.0.1:8000/api/v1`
2. **全局前置操作**：在文件夹级别设置 Header `Authorization: Bearer {{token}}`
3. **接口依赖**：
   - "新增用户"成功后，将 `$.data.id` 写入环境变量 `newUserId`
   - "用户详情"、`"修改用户"`、`"删除用户"` 的路径参数使用 `{{newUserId}}`
