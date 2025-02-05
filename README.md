# Coffee Shop POS System

This is a **Rails 7 API** for a simplified **Point-of-Sale (POS) system** designed for a coffee shop. It allows customers to view items, place orders, and receive notifications when their orders are ready.

---

## Features

- **Region-based taxation** (California, Washington, etc.)
- **Item listing** with tax and discount calculations
- **Order creation **
- **API versioning (`v1`)**
- **Docker support** for easy setup

---

## Prerequisites

### Ruby Version
- **Ruby 3.2.2**

### System Dependencies
- **SQLite3**

---

## 🚀 Installation

### **Using Docker**

1. **Install Docker and Docker Compose**:
   - [Docker Installation Guide](https://www.docker.com/get-started)
   - [Docker Compose Installation Guide](https://docs.docker.com/compose/install/)

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repository-url
   cd your-project-directory
   ```
3. **Build Containers and Setup Database:
```
   docker-compose build
   docker-compose run web rake db:create db:migrate

   check rails console =>

   docker exec -it cofee_app-web-1 rails c

   ```

4. **Start the Application:


```
   docker-compose up

   docker bash => docker exec -it [container-name] bash

   check rails logs => tail -f log/development.log

   docker-compose down


```

#OR

# run this command before 
#
```
sudo chmod +x start.sh

```

#Now, when you run the script (./start.sh), it will stop any running Redis container and then start up your docker-compose services.

```
./start.sh
```


## ERD Diagram

You can view the **Entity Relationship Diagram (ERD)** for the Coffee Shop POS system by clicking the link below:

[Download ERD PDF](coffee_app/erd.pdf)

<iframe src="coffee_app/erd.pdf" width="600" height="400"></iframe>




## Discount Validations & Examples
✅ Valid Percentage Discount



```


❌ Invalid Percentage Discount (Missing Value)

`Discount.create(name: "Winter Sale", discount_type: "percentage", value: nil)
# Error: ["Value can't be blank", "Value is not a number"]`


✅ Valid Combo Discount

`Discount.create(name: "Buy 1 Get 1 Free", discount_type: "combo", condition: "Buy one item, get one free")
# Success: Discount created`

❌ Invalid Combo Discount (Missing Condition)

`Discount.create(name: "Summer Offer", discount_type: "combo", value: 5)
# Error: ["Condition can't be blank"]`





🔍 Validations & Examples
Discounts
✅ Valid Percentage Discount
```




# Coffee Shop POS System API

## Overview
This is a simplified POS (Point of Sale) system for American-style coffee shops, implemented using Ruby on Rails. The system manages shops, items, discounts, combo discounts, and orders. It includes API endpoints for creating, reading, and updating data related to these entities. Additionally, it supports real-time notifications for orders through WebSockets using ActionCable.

## API Endpoints

### **1. Shops**
- **GET /api/v1/shops**  
  Fetch all shops.
  - **Response:**
    ```json
    [
      {
        "id": 1,
        "name": "Coffee Shop",
        "region": "NYC",
        "tax_rate": 0.08,
        "created_at": "2025-02-05T00:00:00",
        "updated_at": "2025-02-05T00:00:00"
      }
    ]
    ```

- **POST /api/v1/shops**  
  Create a new shop.
  - **Request body:**
    ```json
    {
      "name": "Coffee Shop",
      "region": "NYC",
      "tax_rate": 0.08
    }
    ```

- **GET /api/v1/shops/:id**  
  Get a specific shop by `id`.
  - **Response:**
    Same as GET `/api/v1/shops`

### **2. Items**
- **GET /api/v1/items**  
  Fetch all items.
  - **Response:**
    ```json
    [
      {
        "id": 1,
        "name": "Coffee",
        "description": "Fresh brewed coffee",
        "price": 5.0,
        "quantity": 50,
        "created_at": "2025-02-05T00:00:00",
        "updated_at": "2025-02-05T00:00:00"
      }
    ]
    ```

### **3. Discounts**
- **GET /api/v1/discounts**  
  Fetch all discounts.
  - **Response:**
    ```json
    [
      {
        "id": 1,
        "name": "Winter Discount",
        "discount_type": 1,
        "value": 10.0,
        "condition": "Winter season",
        "created_at": "2025-02-05T00:00:00",
        "updated_at": "2025-02-05T00:00:00"
      }
    ]
    ```

- **POST /api/v1/discounts**  
  Create a new discount.
  - **Request body:**
    ```json
    {
      "name": "Winter Discount",
      "discount_type": 1,
      "value": 10.0,
      "condition": "Winter season"
    }
    ```

- **GET /api/v1/discounts/:id**  
  Get a specific discount by `id`.
  - **Response:**
    Same as GET `/api/v1/discounts`

### **4. Combo Discounts**
- **GET /api/v1/combo_discounts**  
  Fetch all combo discounts.
  - **Response:**
    ```json
    [
      {
        "id": 1,
        "discount_id": 1,
        "item_id": 2,
        "free_items_count": 1,
        "created_at": "2025-02-05T00:00:00",
        "updated_at": "2025-02-05T00:00:00"
      }
    ]
    ```

- **POST /api/v1/combo_discounts**  
  Create a new combo discount.
  - **Request body:**
    ```json
    {
      "discount_id": 1,
      "item_id": 2,
      "free_items_count": 1
    }
    ```

- **GET /api/v1/combo_discounts/:id**  
  Get a specific combo discount by `id`.
  - **Response:**
    Same as GET `/api/v1/combo_discounts`

### **5. Orders**
- **POST /api/v1/orders**  
  Create a new order.
  - **Request body:**
    ```json
    {
      "customer_id": 1,
      "shop_id": 1,
      "order_items": [
        {
          "item_id": 1,
          "quantity": 2,
          "unit_price": 10.0,
          "tax_rate": 0.1,
          "total_price": 20.0
        }
      ]
    }
    ```

- **GET /api/v1/orders/:id**  
  Get a specific order by `id`.
  - **Response:**
    ```json
    {
      "id": 1,
      "customer_id": 1,
      "shop_id": 1,
      "status": "pending",
      "subtotal": 20.0,
      "total": 22.0,
      "tax_total": 2.0,
      "discount_total": 0.0,
      "paid_at": null,
      "completed_at": null,
      "created_at": "2025-02-05T00:00:00",
      "updated_at": "2025-02-05T00:00:00"
    }
    ```

- **GET /api/v1/orders**  
  Fetch all orders.
  - **Response:**
    List of orders similar to GET `/api/v1/orders/:id`

- **PATCH /api/v1/orders/:id**  
  Update the status of an order.
  - **Request body:**
    ```json
    {
      "status": "completed"
    }
    ```

- **POST /api/v1/orders/:id/pay**  
  Mark the order as paid.
  - **Response:**
    ```json
    {
      "status": "paid",
      "paid_at": "2025-02-05T00:00:00"
    }
    ```

---

## How to Use

### Postman Parameters

#### **1. Create a Shop**
- **Endpoint:** `POST /api/v1/shops`
- **Body (JSON):**
  ```json
  {
    "name": "Coffee Shop",
    "region": "NYC",
    "tax_rate": 0.08
  }
# cofee_app
