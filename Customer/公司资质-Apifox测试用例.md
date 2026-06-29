# 公司资质接口 — Apifox 测试用例

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

## 1. 获取公司资质列表

- **请求方法**：`GET`
- **请求地址**：`/customer-qualifications`
- **Query 参数**：

| 参数名   | 类型    | 必填 | 示例值 | 说明       |
|----------|---------|------|--------|------------|
| page     | integer | 否   | 1      | 页码       |
| per_page | integer | 否   | 15     | 每页条数   |
| keyword  | string  | 否   | 张三   | 关键词搜索 |
| sort     | string  | 否   | id     | 排序字段   |
| order    | string  | 否   | desc   | 排序方向   |

- **请求示例**：

```http
GET /api/v1/customer-qualifications?page=1&per_page=10&keyword=&sort=id&order=desc
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "查询成功",
  "data": {
    "data": [
      {
        "id": 1,
        "customer_id": 1,
        "is_economic_accepted": true,
        "economic_accept_time": "2025-03-15",
        "is_tech_accepted": false,
        "tech_accept_time": null,
        "is_high_tech": true,
        "high_tech_time": "2024-06-01",
        "is_province_tech": false,
        "province_tech_time": null,
        "is_city_tech": false,
        "city_tech_time": null,
        "is_province_engineer_center": false,
        "province_engineer_center_time": null,
        "is_ip_standard": true,
        "ip_standard_time": "2025-01-10",
        "is_integration_standard": false,
        "integration_standard_time": null,
        "creator": "管理员",
        "created_at": "2026-06-29T10:00:00.000000Z",
        "updated_at": "2026-06-29T10:00:00.000000Z",
        "customer_basic": {
          "id": 1,
          "customer_no": "KH20250001",
          "innovation_subject": "某某科技有限公司"
        }
      }
    ],
    "meta": {
      "current_page": 1,
      "per_page": 10,
      "total": 1,
      "last_page": 1
    }
  }
}
```

---

## 2. 获取公司资质详情

- **请求方法**：`GET`
- **请求地址**：`/customer-qualifications/{id}`
- **Path 参数**：

| 参数名 | 类型    | 必填 | 示例值 | 说明 |
|--------|---------|------|--------|------|
| id     | integer | 是   | 1      | 资质ID |

- **请求示例**：

```http
GET /api/v1/customer-qualifications/1
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "查询成功",
  "data": {
    "id": 1,
    "customer_id": 1,
    "is_economic_accepted": true,
    "economic_accept_time": "2025-03-15",
    "is_tech_accepted": false,
    "tech_accept_time": null,
    "is_high_tech": true,
    "high_tech_time": "2024-06-01",
    "is_province_tech": false,
    "province_tech_time": null,
    "is_city_tech": false,
    "city_tech_time": null,
    "is_province_engineer_center": false,
    "province_engineer_center_time": null,
    "is_ip_standard": true,
    "ip_standard_time": "2025-01-10",
    "is_integration_standard": false,
    "integration_standard_time": null,
    "creator": "管理员",
    "created_at": "2026-06-29T10:00:00.000000Z",
    "updated_at": "2026-06-29T10:00:00.000000Z",
    "customer_basic": {
      "id": 1,
      "customer_no": "KH20250001",
      "innovation_subject": "某某科技有限公司"
    }
  }
}
```

- **404 响应示例**：

```json
{
  "success": false,
  "message": "公司资质信息不存在"
}
```

---

## 3. 创建公司资质

- **请求方法**：`POST`
- **请求地址**：`/customer-qualifications`
- **请求 Body**：

```json
{
  "customer_id": 1,
  "is_economic_accepted": true,
  "economic_accept_time": "2025-03-15",
  "is_tech_accepted": false,
  "tech_accept_time": null,
  "is_high_tech": true,
  "high_tech_time": "2024-06-01",
  "is_province_tech": false,
  "province_tech_time": null,
  "is_city_tech": false,
  "city_tech_time": null,
  "is_province_engineer_center": false,
  "province_engineer_center_time": null,
  "is_ip_standard": true,
  "ip_standard_time": "2025-01-10",
  "is_integration_standard": false,
  "integration_standard_time": null
}
```

> 说明：`customer_id` 必须填写，且必须存在于 `customer_basics` 表中；`creator` 字段由后端自动填充当前登录人姓名，无需传递。

- **成功响应示例**：

```json
{
  "success": true,
  "message": "新增成功",
  "data": {
    "customer_id": 1,
    "is_economic_accepted": true,
    "economic_accept_time": "2025-03-15",
    "is_tech_accepted": false,
    "tech_accept_time": null,
    "is_high_tech": true,
    "high_tech_time": "2024-06-01",
    "is_province_tech": false,
    "province_tech_time": null,
    "is_city_tech": false,
    "city_tech_time": null,
    "is_province_engineer_center": false,
    "province_engineer_center_time": null,
    "is_ip_standard": true,
    "ip_standard_time": "2025-01-10",
    "is_integration_standard": false,
    "integration_standard_time": null,
    "creator": "管理员",
    "id": 1,
    "created_at": "2026-06-29T10:00:00.000000Z",
    "updated_at": "2026-06-29T10:00:00.000000Z"
  }
}
```

---

## 4. 修改公司资质

- **请求方法**：`PUT`
- **请求地址**：`/customer-qualifications/{id}`
- **Path 参数**：

| 参数名 | 类型    | 必填 | 示例值 | 说明 |
|--------|---------|------|--------|------|
| id     | integer | 是   | 1      | 资质ID |

- **请求 Body**：

```json
{
  "customer_id": 1,
  "is_economic_accepted": true,
  "economic_accept_time": "2025-03-15",
  "is_tech_accepted": true,
  "tech_accept_time": "2025-06-20",
  "is_high_tech": true,
  "high_tech_time": "2024-06-01",
  "is_province_tech": false,
  "province_tech_time": null,
  "is_city_tech": false,
  "city_tech_time": null,
  "is_province_engineer_center": false,
  "province_engineer_center_time": null,
  "is_ip_standard": true,
  "ip_standard_time": "2025-01-10",
  "is_integration_standard": true,
  "integration_standard_time": "2025-05-01"
}
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "更新成功",
  "data": {
    "id": 1,
    "customer_id": 1,
    "is_economic_accepted": true,
    "economic_accept_time": "2025-03-15",
    "is_tech_accepted": true,
    "tech_accept_time": "2025-06-20",
    "is_high_tech": true,
    "high_tech_time": "2024-06-01",
    "is_province_tech": false,
    "province_tech_time": null,
    "is_city_tech": false,
    "city_tech_time": null,
    "is_province_engineer_center": false,
    "province_engineer_center_time": null,
    "is_ip_standard": true,
    "ip_standard_time": "2025-01-10",
    "is_integration_standard": true,
    "integration_standard_time": "2025-05-01",
    "creator": "管理员",
    "created_at": "2026-06-29T10:00:00.000000Z",
    "updated_at": "2026-06-29T10:30:00.000000Z"
  }
}
```

---

## 5. 删除公司资质

- **请求方法**：`DELETE`
- **请求地址**：`/customer-qualifications/{id}`
- **Path 参数**：

| 参数名 | 类型    | 必填 | 示例值 | 说明 |
|--------|---------|------|--------|------|
| id     | integer | 是   | 1      | 资质ID |

- **请求示例**：

```http
DELETE /api/v1/customer-qualifications/1
```

- **成功响应示例**：

```json
{
  "success": true,
  "message": "删除成功"
}
```

---

## Apifox 断言建议（可选）

针对每个接口，可在 Apifox 中添加如下通用断言：

1. **状态码等于 200**
2. **JSON Path `$.success` 等于 `true`**
3. **JSON Path `$.message` 不为空**
4. **JSON Path `$.data` 不为空**（删除接口除外）

---

## 前置条件

1. 数据库中已存在 `customer_basics` 记录，测试用例中使用的 `customer_id` 请替换为实际存在的 ID。
2. 已先执行登录接口获取有效 JWT Token，填入 `Authorization: Bearer <token>`。
3. 若为新环境，请先运行迁移：

```bash
php artisan migrate
```
