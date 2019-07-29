USE sales ;

-- Supp la FK (en vue de la recréer)
ALTER TABLE orders
DROP fk_orders_staffs;


ALTER TABLE orders
ADD CONSTRAINT fk_orders_staffs
FOREIGN KEY (staff_id)
REFERENCES staffs (staff_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- Supp la FK (en vue de la recréer)
ALTER TABLE orders
DROP fk_orders_customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
  FOREIGN KEY (customer_id)
  REFERENCES customers (customer_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


-- Supp la FK (en vue de la recréer)
ALTER TABLE orders
DROP fk_orders_stores;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_stores
  FOREIGN KEY (store_id)
  REFERENCES stores (store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;
  
  
-- Supp la FK (en vue de la recréer)  
ALTER TABLE staffs
DROP fk_staffs_stores;

ALTER TABLE staffs
ADD CONSTRAINT fk_staffs_stores
  FOREIGN KEY (store_id)
  REFERENCES stores (store_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;
  
  
-- Supp la FK (en vue de la recréer)  
ALTER TABLE order_items
DROP fk_order_items_orders;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
  FOREIGN KEY (order_id)
  REFERENCES orders (order_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;
  

-- Supp la FK (en vue de la recréer)  
ALTER TABLE staffs
DROP fk_staffs_managers;

ALTER TABLE staffs
ADD CONSTRAINT fk_staffs_managers
  FOREIGN KEY (manager_id)
  REFERENCES managers (manager_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;
  
  -- Entre deux datas bases
  
ALTER TABLE production.stocks
ADD CONSTRAINT fk_stocks_store
  FOREIGN KEY (store_id) 
  REFERENCES sales.stores (store_id) 
  ON DELETE CASCADE 
  ON UPDATE CASCADE;
  
  
ALTER TABLE sales.order_items
ADD CONSTRAINT fk_order_items_products
  FOREIGN KEY (product_id) 
  REFERENCES production.products (product_id) 
  ON DELETE CASCADE 
  ON UPDATE CASCADE;
 
 -- POUR UNE FOREIGN KEY DANS UNE MÊME TABLE
 -- ALTER TABLE staffs
 -- ADD FOREIGN KEY fk_manager_staffs(manager_id)
 -- REFERENCES staffs(staff_id)
 -- ON DELETE CASCADE 
 -- ON UPDATE CASCADE;