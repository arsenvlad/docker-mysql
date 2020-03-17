# -- This database schema is based on https://www.kaggle.com/olistbr/brazilian-ecommerce
CREATE DATABASE ecommerce_db1;
USE ecommerce_db1;

CREATE TABLE customers (
  customer_id varchar(50) not null,
  customer_unique_id varchar(50) not null,
  customer_zip_code_prefix int default null,
  customer_city varchar(100),
  customer_state varchar(100),
  PRIMARY KEY (customer_id),
  UNIQUE KEY customer_unique_id (customer_unique_id)
);

CREATE TABLE geolocation (
  geolocation_zip_code_prefix int not null,
  geolocation_lat double default null,
  geolocation_lng double default null,
  geolocation_city varchar(100),
  geolocation_state varchar(100),
  PRIMARY KEY (geolocation_zip_code_prefix)
);

CREATE TABLE order_items (
  order_id varchar(50) not null,
  order_item_id int not null,
  product_id varchar(50) not null,
  seller_id varchar(50) not null,
  shipping_limit_date datetime,
  price double default null,
  freight_value double default null,
  PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
  order_id varchar(50) not null,
  payment_sequential int default null,
  payment_type varchar(50),
  payment_installments int default null,
  payment_value double default null,
  PRIMARY KEY (order_id)
);

CREATE TABLE order_reviews (
  review_id varchar(50) not null,
  order_id varchar(50) not null,
  review_score int default null,
  review_comment_title varchar(100),
  review_comment_message text,
  review_creation_date datetime,
  review_answer_timestamp datetime,
  PRIMARY KEY (review_id)
);

CREATE TABLE orders (
  order_id varchar(50) not null,
  customer_id varchar(50) not null,
  order_status varchar(50),
  order_purchase_timestamp datetime,
  order_approved_at datetime,
  order_delivered_carrier_date datetime,
  order_delivered_customer_date datetime,
  order_estimated_delivery_date datetime,
  PRIMARY KEY (order_id)
);

CREATE TABLE products (
  product_id varchar(50) not null,
  product_category_name varchar(100),
  product_name_length int default null,
  product_description_length int default null,
  product_photos_qty int default null,
  product_weight_g int default null,
  product_length_cm int default null,
  product_height_cm int default null,
  product_width_cm int default null,
  PRIMARY KEY (product_id)
);

CREATE TABLE sellers (
  seller_id varchar(50) not null,
  seller_zip_code_prefix int not null,
  seller_city varchar(100),
  seller_state varchar(100),
  PRIMARY KEY (seller_id)
);

CREATE TABLE product_category_name_translation (
  product_category_id int NOT NULL AUTO_INCREMENT,
  product_category_name varchar(100),
  product_category_name_english varchar(100),
  PRIMARY KEY (product_category_id)
);

# -- Create foreign keys after tables are defined
ALTER TABLE customers ADD CONSTRAINT fk_customers_geolocation FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocation (geolocation_zip_code_prefix);

ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (order_id) REFERENCES customers (customer_id);

ALTER TABLE order_items ADD CONSTRAINT fk_order_items_sellers FOREIGN KEY (seller_id) REFERENCES sellers (seller_id);
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_products FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE order_payments ADD CONSTRAINT fk_order_payments_orders FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE order_reviews ADD CONSTRAINT fk_order_reviews_orders FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE sellers ADD CONSTRAINT fk_sellers_geolocation FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocation (geolocation_zip_code_prefix);

# -- Create view
CREATE VIEW customer_order_items_view AS
SELECT 
	c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_date,
    oi.price,
    oi.freight_value
FROM customers c INNER JOIN orders o ON o.customer_id = c.customer_id INNER JOIN order_items oi ON oi.order_id = o.order_id;

# -- Create non-root users and grant access
CREATE USER 'ecommercedb1user'@'%' IDENTIFIED BY 'my-secure-pw';
GRANT SELECT ON ecommerce_db1.* TO 'ecommercedb1user'@'%';

