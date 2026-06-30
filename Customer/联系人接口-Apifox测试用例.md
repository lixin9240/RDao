# 联系人接口 — Apifox 测试用例

> 基础地址示例：`http://127.0.0.1:8000/api/v1`
> 所有接口均需在 Header 中携带 JWT Token

---

## 公共请求头

```http
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
Content-Type: application/json
Accept: application/json
```

---

## 1. 获取联系人列表

- **请求方法**：`GET`
- **请求地址**：`/customer/contacts`
- **Query 参数**：

| 参数名        | 类型    | 必填 | 示例值 | 说明           |
|---------------|---------|------|--------|----------------|
| page          | integer | 否   | 1      | 页码           |
| page_size     | integer | 否   | 15     | 每页条数       |
| contact_name  | string  | 否   | 张三   | 联系人姓名     |
| customer_name | string  | 否   | 科技   | 客户名称       |
| contact_type  | string  | 否   | 负责人 | 联系人类型     |
| business_person | string | 否 | 李四 | 业务员姓名     |

- **请求示例**：

```http
GET /api/v1/customer/contacts?page=1&page_size=10&contact_name=&customer_name=&contact_type=&business_person=
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "查询成功",
  "data": {
    "total": 1,
    "list": [
      {
        "serialNo": 1,
        "name": "张三",
        "customerName": "某某科技有限公司",
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

---

## 2. 创建联系人

- **请求方法**：`POST`
- **请求地址**：`/customer/contacts`
- **请求 Body**：

```json
{
  "innovationSubjectId": 1,
  "contactType": "负责人",
  "name": "张三",
  "phone": "13800138000",
  "landline": "021-12345678",
  "isEmployed": 1,
  "position": "经理",
  "email": "zhangsan@example.com",
  "businessPersonId": 2,
  "assistantId": 3,
  "techDepartment": "研发部",
  "techLeaderId": 4,
  "workAddress": "上海市浦东新区",
  "remark": "备注信息"
}
```

| 参数名              | 类型    | 必填 | 说明                     |
|---------------------|---------|------|--------------------------|
| innovationSubjectId | integer | 是   | 创新主体ID（客户ID）     |
| contactType         | string  | 是   | 联系人类型               |
| name                | string  | 是   | 联系人姓名               |
| phone               | string  | 是   | 手机号                   |
| landline            | string  | 否   | 座机号                   |
| isEmployed          | integer | 是   | 是否在职：0否，1是       |
| position            | string  | 否   | 职位                     |
| email               | string  | 否   | 邮箱                     |
| businessPersonId    | integer | 否   | 业务员ID                 |
| assistantId         | integer | 否   | 助理ID                   |
| techDepartment      | string  | 否   | 技术负责人部门           |
| techLeaderId        | integer | 否   | 技术负责人ID             |
| workAddress         | string  | 否   | 工作地址                 |
| remark              | string  | 否   | 备注                     |

- **成功响应示例**：

```json
{
  "success": true,
  "message": "创建成功"
}
```

---

## 3. 获取联系人详情

- **请求方法**：`GET`
- **请求地址**：`/customer/contacts/{id}`
- **Path 参数**：

| 参数名 | 类型    | 必填 | 示例值 | 说明 |
|--------|---------|------|--------|------|
| id     | integer | 是   | 1      | 联系人ID |

- **请求示例**：

```http
GET /api/v1/customer/contacts/1
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "查询成功",
  "data": {
    "innovationSubjectId": 1,
    "contactType": "负责人",
    "name": "张三",
    "phone": "13800138000",
    "landline": "021-12345678",
    "isEmployed": 1,
    "position": "经理",
    "email": "zhangsan@example.com",
    "businessPersonId": 2,
    "assistantId": 3,
    "techDepartment": "研发部",
    "techLeaderId": 4,
    "workAddress": "上海市浦东新区",
    "remark": "备注信息",
    "createBy": "管理员",
    "createTime": "2026-06-30 10:00:00",
    "updateBy": "管理员",
    "updateTime": "2026-06-30 10:00:00"
  }
}
```

- **400 响应示例**：

```json
{
  "success": false,
  "message": "联系人不存在"
}
```

---

## 4. 更新联系人

- **请求方法**：`PUT`
- **请求地址**：`/customer/contact/{id}`
- **Path 参数**：

| 参数名 | 类型    | 必填 | 示例值 | 说明 |
|--------|---------|------|--------|------|
| id     | integer | 是   | 1      | 联系人ID |

- **请求 Body**：

```json
{
  "customerId": 1,
  "contactType": "技术负责人",
  "name": "张三",
  "phone": "13900139000",
  "landline": "021-87654321",
  "isActive": 1,
  "position": "技术总监",
  "email": "zhangsan@example.com",
  "salesRepId": 2,
  "salesAssistantId": 3,
  "techLeadDept": "研发部",
  "techLeadId": 4,
  "workAddress": "上海市浦东新区",
  "notes": "更新备注"
}
```

| 参数名              | 类型    | 必填 | 说明                     |
|---------------------|---------|------|--------------------------|
| customerId          | integer | 否   | 客户ID                   |
| contactType         | string  | 是   | 联系人类型               |
| name                | string  | 是   | 联系人姓名               |
| phone               | string  | 否   | 手机号                   |
| landline            | string  | 否   | 座机号                   |
| isActive            | integer | 是   | 是否在职：0否，1是       |
| position            | string  | 否   | 职位                     |
| email               | string  | 否   | 邮箱                     |
| salesRepId          | integer | 否   | 业务员ID                 |
| salesAssistantId    | integer | 否   | 助理ID                   |
| techLeadDept        | string  | 否   | 技术负责人部门           |
| techLeadId          | integer | 否   | 技术负责人ID             |
| workAddress         | string  | 否   | 工作地址                 |
| notes               | string  | 否   | 备注                     |

- **成功响应示例**：

```json
{
  "success": true,
  "message": "更新成功"
}
```

---

## 5. 获取联系人类型选项

- **请求方法**：`GET`
- **请求地址**：`/customer/contact-types/options`
- **请求示例**：

```http
GET /api/v1/customer/contact-types/options
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "value": "负责人",
      "label": "负责人"
    },
    {
      "value": "技术负责人",
      "label": "技术负责人"
    },
    {
      "value": "财务负责人",
      "label": "财务负责人"
    }
  ]
}
```

---

## Apifox 断言建议（可选）

针对每个接口，可在 Apifox 中添加如下通用断言：

1. **状态码等于 200**
2. **JSON Path `$.success` 等于 `true`**
3. **JSON Path `$.message` 不为空**
4. **JSON Path `$.data` 不为空**（创建/更新接口除外）

---

## 前置条件

1. 数据库中已存在 `customer_basics` 记录，测试用例中使用的 `innovationSubjectId` 请替换为实际存在的 ID。
2. 数据库中已存在 `sys_users` 记录，`businessPersonId`、`assistantId`、`techLeaderId` 请替换为实际存在的用户 ID。
3. 已先执行登录接口获取有效 JWT Token，填入 `Authorization: Bearer <token>`。