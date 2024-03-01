SELECT o.order_id, p.cost_price, oi.list_price, oi.quantity, c.category_name, o.order_date, s.store_id, (oi.list_price * oi.quantity) AS total_sale, 
(p.cost_price * oi.quantity) AS total_cost,(oi.list_price * oi.quantity)-(p.cost_price * oi.quantity) AS profit
FROM order_items oi 
LEFT JOIN orders o on o.order_id = oi.order_id 
LEFT JOIN products p on p.product_id= oi.product_id
LEFT JOIN categories c on c.category_id = p.category_id
LEFT JOIN stores s on s.store_id = o.store_id

UNION ALL

SELECT null as total_cost, null as total_sale,
null as category_name, null AS quantity, null as list_price, month_worked AS order_date, store_id, null as cost_price, 
null as order_id,total_monthly_costs AS profit
FROM (SELECT e.month_worked AS month_worked,e.store_id, r.rent*-1 -SUM(monthly_salary) as total_monthly_costs
FROM employees e
LEFT JOIN rent r ON r.store_id=e.store_id
GROUP BY e.store_id, e.month_worked, r.rent) op_ex
