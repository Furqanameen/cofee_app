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




# API Documentation for the Coffee Shop POS System

This is the API documentation for the Coffee Shop POS system built using Ruby on Rails. This API allows users to interact with orders, items, discounts, combo discounts, and shops.

## Base URL
The base URL for this API is: `https://yourdomain.com/api/v1`

---

## Endpoints

### 1. **Shops**

#### **GET /api/v1/shops**
Fetch a list of all shops.

- **Response:**
  - Status: 200 OK
  - Body: 
    ```json
    [
      {
        "id": 1,
        "name": "Coffee Shop A",
        "region": "New York",
        "tax_rate": 0.07,
        "created_at": "2025-02-01T00:00:00Z",
        "updated_at": "2025-02-01T00:00:00Z"
      }
    ]
    ```

#### **GET /api/v1/shops/:id**
Fetch details of a specific shop.

- **Parameters:**
  - `id` (required): The ID of the shop.
  
- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (if found):
    ```json
    {
      "id": 1,
      "name": "Coffee Shop A",
      "region": "New York",
      "tax_rate": 0.07,
      "created_at": "2025-02-01T00:00:00Z",
      "updated_at": "2025-02-01T00:00:00Z"
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Shop not found"
    }
    ```

#### **POST /api/v1/shops**
Create a new shop.

- **Parameters:**
  - `name` (required): Name of the shop.
  - `region` (required): Region of the shop.
  - `tax_rate` (required): Tax rate for the shop.

- **Response:**
  - Status: 201 Created or 422 Unprocessable Entity
  - Body (on success):
    ```json
    {
      "message": "Shop created successfully",
      "shop": {
        "id": 1,
        "name": "Coffee Shop A",
        "region": "New York",
        "tax_rate": 0.07
      }
    }
    ```

---

### 2. **Items**

#### **GET /api/v1/items**
Fetch a list of all items.

- **Response:**
  - Status: 200 OK
  - Body:
    ```json
    [
      {
        "id": 1,
        "name": "Espresso",
        "description": "Strong coffee",
        "price": 5.00,
        "quantity": 10,
        "created_at": "2025-02-01T00:00:00Z",
        "updated_at": "2025-02-01T00:00:00Z"
      }
    ]
    ```

#### **GET /api/v1/items/:id**
Fetch details of a specific item.

- **Parameters:**
  - `id` (required): The ID of the item.
  
- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (if found):
    ```json
    {
      "id": 1,
      "name": "Espresso",
      "description": "Strong coffee",
      "price": 5.00,
      "quantity": 10,
      "created_at": "2025-02-01T00:00:00Z",
      "updated_at": "2025-02-01T00:00:00Z"
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Item not found"
    }
    ```

#### **POST /api/v1/items**
Create a new item.

- **Parameters:**
  - `name` (required): Name of the item.
  - `description` (required): Description of the item.
  - `price` (required): Price of the item.
  - `quantity` (required): Quantity in stock.

- **Response:**
  - Status: 201 Created or 422 Unprocessable Entity
  - Body (on success):
    ```json
    {
      "id": 1,
      "name": "Espresso",
      "description": "Strong coffee",
      "price": 5.00,
      "quantity": 10
    }
    ```

---

### 3. **Discounts**

#### **GET /api/v1/discounts**
Fetch a list of all discounts.

- **Response:**
  - Status: 200 OK
  - Body:
    ```json
    [
      {
        "id": 1,
        "name": "10% Off",
        "discount_type": 0,
        "value": 10.00,
        "condition": "On orders above $50"
      }
    ]
    ```

#### **GET /api/v1/discounts/:id**
Fetch details of a specific discount.

- **Parameters:**
  - `id` (required): The ID of the discount.

- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (if found):
    ```json
    {
      "id": 1,
      "name": "10% Off",
      "discount_type": 0,
      "value": 10.00,
      "condition": "On orders above $50"
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Discount not found"
    }
    ```

#### **POST /api/v1/discounts**
Create a new discount.

- **Parameters:**
  - `name` (required): Name of the discount.
  - `discount_type` (required): Type of discount (e.g., percentage or flat value).
  - `value` (required): Discount value.
  - `condition` (optional): Condition for the discount.

- **Response:**
  - Status: 201 Created or 422 Unprocessable Entity
  - Body (on success):
    ```json
    {
      "message": "Discount created successfully",
      "discount": {
        "id": 1,
        "name": "10% Off",
        "discount_type": 0,
        "value": 10.00,
        "condition": "On orders above $50"
      }
    }
    ```

---

### 4. **Combo Discounts**

#### **GET /api/v1/combo_discounts**
Fetch a list of all combo discounts.

- **Response:**
  - Status: 200 OK
  - Body:
    ```json
    [
      {
        "id": 1,
        "discount_id": 1,
        "item_id": 1,
        "free_items_count": 1
      }
    ]
    ```

#### **GET /api/v1/combo_discounts/:id**
Fetch details of a specific combo discount.

- **Parameters:**
  - `id` (required): The ID of the combo discount.

- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (if found):
    ```json
    {
      "id": 1,
      "discount_id": 1,
      "item_id": 1,
      "free_items_count": 1
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Combo discount not found"
    }
    ```

#### **POST /api/v1/combo_discounts**
Create a new combo discount.

- **Parameters:**
  - `discount_id` (required): ID of the associated discount.
  - `item_id` (required): ID of the item being discounted.
  - `free_items_count` (required): Number of free items for the combo.

- **Response:**
  - Status: 201 Created or 422 Unprocessable Entity
  - Body (on success):
    ```json
    {
      "message": "Combo discount created successfully",
      "combo_discount": {
        "id": 1,
        "discount_id": 1,
        "item_id": 1,
        "free_items_count": 1
      }
    }
    ```

---

### 5. **Orders**

#### **GET /api/v1/orders**
Fetch a list of all orders.

- **Response:**
  - Status: 200 OK
  - Body:
    ```json
    [
      {
        "id": 1,
        "customer_id": 1,
        "shop_id": 1,
        "status": 0,
        "subtotal": 50.00,
        "total": 55.00,
        "tax_total": 5.00,
        "discount_total": 0.00
      }
    ]
    ```

#### **POST /api/v1/orders**
Create a new order.

- **Parameters:**
  - `customer_id` (required): The ID of the customer.
  - `shop_id` (required): The ID of the shop.
  - `items` (required): An array of items being ordered, with their quantity.

- **Response:**
  - Status: 201 Created or 422 Unprocessable Entity
  - Body (on success):
    ```json
    {
      "message": "Order created successfully",
      "order": {
        "id": 1,
        "customer_id": 1,
        "shop_id": 1,
        "status": 0,
        "subtotal": 50.00,
        "total": 55.00,
        "tax_total": 5.00,
        "discount_total": 0.00
      }
    }
    ```

#### **GET /api/v1/orders/:id**
Fetch details of a specific order.

- **Parameters:**
  - `id` (required): The ID of the order.

- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (if found):
    ```json
    {
      "id": 1,
      "customer_id": 1,
      "shop_id": 1,
      "status": 0,
      "subtotal": 50.00,
      "total": 55.00,
      "tax_total": 5.00,
      "discount_total": 0.00
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Order not found"
    }
    ```

#### **POST /api/v1/orders/:id/pay**
Mark the order as paid.

- **Parameters:**
  - `id` (required): The ID of the order.

- **Response:**
  - Status: 200 OK or 404 Not Found
  - Body (on success):
    ```json
    {
      "message": "Order paid successfully"
    }
    ```
  - Body (if not found):
    ```json
    {
      "error": "Order not found"
    }
    ```

