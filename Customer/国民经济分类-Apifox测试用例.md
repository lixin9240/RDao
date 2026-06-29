# 国民经济分类四级联动 - Apifox 测试用例

## 公共请求头

```
Authorization: Bearer <你的JWT Token>
Content-Type: application/json
```

---

## 1. 获取国民经济门类列表（一级分类）

### 请求信息

| 属性 | 值 |
|------|-----|
| 方法 | GET |
| 地址 | `http://127.0.0.1:8000/api/v1/economy-categories` |

### 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| parentId | 否 | integer | 父级ID，不传或传0获取门类（一级分类） |

### 成功响应示例

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "id": 1,
      "categoryCode": "A",
      "categoryName": "农、林、牧、渔业",
      "level": 1,
      "parentId": 0,
      "hasChildren": true
    },
    {
      "id": 2,
      "categoryCode": "B",
      "categoryName": "采矿业",
      "level": 1,
      "parentId": 0,
      "hasChildren": true
    },
    {
      "id": 3,
      "categoryCode": "C",
      "categoryName": "制造业",
      "level": 1,
      "parentId": 0,
      "hasChildren": true
    },
    {
      "id": 4,
      "categoryCode": "D",
      "categoryName": "电力、热力、燃气及水生产和供应业",
      "level": 1,
      "parentId": 0,
      "hasChildren": true
    }
  ]
}
```

### 断言建议

- HTTP 状态码 = 200
- `$.success` = true
- `$.data` 数组长度 > 0
- 第一条数据 `$.data[0].level` = 1
- 第一条数据 `$.data[0].parentId` = 0

---

## 2. 获取国民经济大类列表（二级分类）

### 请求信息

| 属性 | 值 |
|------|-----|
| 方法 | GET |
| 地址 | `http://127.0.0.1:8000/api/v1/economy-categories` |

### 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| parentId | 是 | integer | 父级ID，传入门类的ID获取大类 |

### 示例请求

```
GET /api/v1/economy-categories?parentId=3
```

### 成功响应示例

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "id": 10,
      "categoryCode": "C13",
      "categoryName": "农副食品加工业",
      "level": 2,
      "parentId": 3,
      "hasChildren": true
    },
    {
      "id": 11,
      "categoryCode": "C14",
      "categoryName": "食品制造业",
      "level": 2,
      "parentId": 3,
      "hasChildren": true
    },
    {
      "id": 12,
      "categoryCode": "C15",
      "categoryName": "酒、饮料和精制茶制造业",
      "level": 2,
      "parentId": 3,
      "hasChildren": true
    },
    {
      "id": 13,
      "categoryCode": "C16",
      "categoryName": "烟草制品业",
      "level": 2,
      "parentId": 3,
      "hasChildren": true
    }
  ]
}
```

### 断言建议

- HTTP 状态码 = 200
- `$.success` = true
- `$.data` 数组长度 > 0
- 第一条数据 `$.data[0].level` = 2
- 第一条数据 `$.data[0].parentId` = 3

---

## 3. 获取国民经济中类列表（三级分类）

### 请求信息

| 属性 | 值 |
|------|-----|
| 方法 | GET |
| 地址 | `http://127.0.0.1:8000/api/v1/economy-categories` |

### 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| parentId | 是 | integer | 父级ID，传入大类的ID获取中类 |

### 示例请求

```
GET /api/v1/economy-categories?parentId=10
```

### 成功响应示例

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "id": 101,
      "categoryCode": "C131",
      "categoryName": "谷物磨制",
      "level": 3,
      "parentId": 10,
      "hasChildren": true
    },
    {
      "id": 102,
      "categoryCode": "C132",
      "categoryName": "饲料加工",
      "level": 3,
      "parentId": 10,
      "hasChildren": true
    },
    {
      "id": 103,
      "categoryCode": "C133",
      "categoryName": "植物油加工",
      "level": 3,
      "parentId": 10,
      "hasChildren": true
    },
    {
      "id": 104,
      "categoryCode": "C134",
      "categoryName": "制糖业",
      "level": 3,
      "parentId": 10,
      "hasChildren": true
    }
  ]
}
```

### 断言建议

- HTTP 状态码 = 200
- `$.success` = true
- `$.data` 数组长度 > 0
- 第一条数据 `$.data[0].level` = 3

---

## 4. 获取国民经济小类列表（四级分类）

### 请求信息

| 属性 | 值 |
|------|-----|
| 方法 | GET |
| 地址 | `http://127.0.0.1:8000/api/v1/economy-categories` |

### 请求参数

| 参数名 | 必填 | 类型 | 说明 |
|--------|------|------|------|
| parentId | 是 | integer | 父级ID，传入中类的ID获取小类 |

### 示例请求

```
GET /api/v1/economy-categories?parentId=101
```

### 成功响应示例

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "id": 1011,
      "categoryCode": "C1311",
      "categoryName": "稻谷加工",
      "level": 4,
      "parentId": 101,
      "hasChildren": false
    },
    {
      "id": 1012,
      "categoryCode": "C1312",
      "categoryName": "小麦加工",
      "level": 4,
      "parentId": 101,
      "hasChildren": false
    },
    {
      "id": 1013,
      "categoryCode": "C1313",
      "categoryName": "玉米加工",
      "level": 4,
      "parentId": 101,
      "hasChildren": false
    },
    {
      "id": 1014,
      "categoryCode": "C1319",
      "categoryName": "其他谷物磨制",
      "level": 4,
      "parentId": 101,
      "hasChildren": false
    }
  ]
}
```

### 断言建议

- HTTP 状态码 = 200
- `$.success` = true
- `$.data` 数组长度 > 0
- 第一条数据 `$.data[0].level` = 4
- 第一条数据 `$.data[0].hasChildren` = false

---

## 5. 获取国民经济分类全量树形结构

### 请求信息

| 属性 | 值 |
|------|-----|
| 方法 | GET |
| 地址 | `http://127.0.0.1:8000/api/v1/economy-categories/tree` |

### 请求参数

无

### 成功响应示例

```json
{
  "success": true,
  "message": "查询成功",
  "data": [
    {
      "id": 1,
      "categoryCode": "A",
      "categoryName": "农、林、牧、渔业",
      "level": 1,
      "parentId": 0,
      "children": [
        {
          "id": 5,
          "categoryCode": "A01",
          "categoryName": "农业",
          "level": 2,
          "parentId": 1,
          "children": [
            {
              "id": 51,
              "categoryCode": "A011",
              "categoryName": "谷物种植",
              "level": 3,
              "parentId": 5,
              "children": [
                {
                  "id": 511,
                  "categoryCode": "A0111",
                  "categoryName": "稻谷种植",
                  "level": 4,
                  "parentId": 51
                },
                {
                  "id": 512,
                  "categoryCode": "A0112",
                  "categoryName": "小麦种植",
                  "level": 4,
                  "parentId": 51
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "id": 3,
      "categoryCode": "C",
      "categoryName": "制造业",
      "level": 1,
      "parentId": 0,
      "children": [
        {
          "id": 10,
          "categoryCode": "C13",
          "categoryName": "农副食品加工业",
          "level": 2,
          "parentId": 3
        }
      ]
    }
  ]
}
```

### 断言建议

- HTTP 状态码 = 200
- `$.success` = true
- `$.data` 数组长度 > 0
- 一级分类 `$.data[0].level` = 1
- 存在嵌套的 children 字段

---

## 前端联动使用说明

```javascript
// 1. 页面加载时获取门类（一级）
axios.get('/api/v1/economy-categories', { params: { parentId: 0 } })
  .then(res => { /* 填充门类下拉 */ });

// 2. 选择门类后获取大类（二级）
axios.get('/api/v1/economy-categories', { params: { parentId: selectedCategoryId } })
  .then(res => { /* 填充大类下拉 */ });

// 3. 选择大类后获取中类（三级）
axios.get('/api/v1/economy-categories', { params: { parentId: selectedLargeId } })
  .then(res => { /* 填充中类下拉 */ });

// 4. 选择中类后获取小类（四级）
axios.get('/api/v1/economy-categories', { params: { parentId: selectedMidId } })
  .then(res => { /* 填充小类下拉 */ });
```

---

## 字段说明

| 字段 | 类型 | 说明 |
|------|------|------|
| id | integer | 分类ID |
| categoryCode | string | 行业代码（如 A、C13、C131、C1311） |
| categoryName | string | 行业名称 |
| level | integer | 层级：1-门类，2-大类，3-中类，4-小类 |
| parentId | integer | 父级ID，顶级为0 |
| hasChildren | boolean | 是否有子级分类 |

---

## 注意事项

1. **认证要求**：所有接口需携带 `Authorization: Bearer <token>` 请求头
2. **路径前缀**：接口路径包含 `/api/v1/` 前缀
3. **数据来源**：数据从 `sys_economy_category` 表读取，需提前导入 GB/T 4754-2017 国民经济行业分类数据
4. **数据格式**：返回数据已转换为 camelCase 格式
