USE production ;

-- Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

-- https://tableplus.io/blog/2018/08/mysql-how-to-drop-constraint-in-mysql.html

-- Supp la FK (en vue de la recréer)
ALTER TABLE products
DROP fk_products_category;


ALTER TABLE `products`
ADD CONSTRAINT `fk_products_category`
  FOREIGN KEY (`category_id`)
  REFERENCES `categories` (`category_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


-- Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products.

ALTER TABLE `products`
DROP `fk_products_brand`;

ALTER TABLE `products`
ADD CONSTRAINT `fk_products_brand`
  FOREIGN KEY (`brand_id`)
  REFERENCES `brands` (`brand_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;


ALTER TABLE `stocks`
DROP `fk_products_stocks`;

ALTER TABLE `stocks`
ADD CONSTRAINT `fk_stocks_product`
  FOREIGN KEY (`product_id`)
  REFERENCES `products` (`product_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE ;
