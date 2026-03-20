USE optics;

SELECT g.brand,g.model,s.sold_date,s.quantity FROM sales s JOIN glasses g ON s.glass = g.id JOIN clients c ON s.client = c.id WHERE s.sold_date BETWEEN '2025-01-01' AND '2026-01-01' AND c.name="Pedro Reyes";

SELECT DISTINCT b.name,g.model FROM glasses AS g JOIN brands AS b ON g.brand = b.id JOIN sales AS s ON s.glass = g.id JOIN employees AS e ON s.employee = e.id WHERE e.name ='Juan Costa';

SELECT DISTINCT s.name FROM suppliers AS s JOIN brands AS b ON b.supplier = s.id JOIN glasses as g ON g.brand = b.id JOIN sales AS sa ON sa.glass = g.id;

USE pizzeria;

SELECT SUM(pr.quantity) as 'Begudes_venudes_a_Barcelona' FROM products_from_orders AS pr JOIN products AS p ON pr.product = p.id JOIN orders AS o ON o.id = pr.the_order JOIN shops AS s ON o.shop = s.id JOIN cities AS c ON c.id = s.city WHERE p.product_type = 'DRINK' AND c.name='Barcelona';

SELECT COUNT (o.id) AS 'Comandes que ha realitzat el empleat' FROM orders AS o JOIN employees AS e ON e.id = o.delivered_by WHERE e.nif ='48473637E';
