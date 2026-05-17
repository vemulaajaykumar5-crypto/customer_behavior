-- 1. Total Revenue by Gender
SELECT
    gender,
    SUM(purchase_amount) AS total_revenue
FROM mydata.customer
GROUP BY gender
ORDER BY total_revenue DESC;

-- 2. Top 10 Spending Customers
SELECT
    customer_id,
    SUM(purchase_amount) AS total_spent
FROM mydata.customer
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;
-- Identify high-value customers

-- 3. Revenue by Category
SELECT
    category,
    SUM(purchase_amount) AS total_sales
FROM mydata.customer
GROUP BY category
ORDER BY total_sales DESC;
-- Best-performing product categories

-- 4. Average Rating by Category
SELECT
    category,
    ROUND(AVG(review_rating),2) AS avg_rating
FROM mydata.customer
GROUP BY category
ORDER BY avg_rating DESC;
-- Customer satisfaction analysis


--  5. Seasonal Sales Analysis
SELECT
    season,
    SUM(purchase_amount) AS total_sales,
    COUNT(*) AS total_orders
FROM mydata.customer
GROUP BY season
ORDER BY total_sales DESC;
-- Seasonal demand planning

-- 6. Payment Method Analysis
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(purchase_amount) AS revenue
FROM mydata.customer
GROUP BY payment_method
ORDER BY revenue DESC;
-- Preferred payment channels

-- 7. Subscription Customer Analysis
SELECT
    subscription_status,
    COUNT(*) AS customers,
    SUM(purchase_amount) AS total_sales,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM mydata.customer
GROUP BY subscription_status;
-- Subscription program effectiveness

-- 8. Discount Impact on Sales
SELECT
    discount_applied,
    SUM(purchase_amount) AS total_sales,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM mydata.customer
GROUP BY discount_applied;
-- Evaluate discount strategy

-- 9. Most Purchased Products
SELECT
    item_purchased,
    COUNT(*) AS total_orders
FROM mydata.customer
GROUP BY item_purchased
ORDER BY total_orders DESC
LIMIT 10;
-- Inventory optimization

-- 10. Top Revenue Locations
SELECT
    location,
    SUM(purchase_amount) AS total_sales
FROM mydata.customer
GROUP BY location
ORDER BY total_sales DESC
LIMIT 10;
-- Regional performance analysis

-- 11. Age Group Spending Analysis
SELECT
    age_group,
    COUNT(*) AS customers,
    SUM(purchase_amount) AS total_sales,
    ROUND(AVG(purchase_amount),2) AS avg_spending
FROM mydata.customer
GROUP BY age_group
ORDER BY total_sales DESC;
-- Demographic targeting

-- 12. Shipping Type Performance
SELECT
    shipping_type,
    COUNT(*) AS total_orders,
    SUM(purchase_amount) AS revenue
FROM mydata.customer
GROUP BY shipping_type
ORDER BY revenue DESC;
-- Shipping preference analysis
 
 -- 13. High Loyalty Customers
SELECT
    customer_id,
    previous_purchases,
    purchase_amount
FROM mydata.customer
WHERE previous_purchases >= 20
ORDER BY previous_purchases DESC;
-- Loyalty campaign targeting


-- 14. Category-wise Average Purchase
SELECT
    category,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM mydata.customer
GROUP BY category
ORDER BY avg_purchase DESC;

-- High-ticket category analysis

-- 15. Customer Segmentation Using CASE
SELECT
    customer_id,
    purchase_amount,
    CASE
        WHEN purchase_amount >= 80 THEN 'High Value'
        WHEN purchase_amount >= 50 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM mydata.customer;
-- Customer segmentation
-- Marketing targeting
-- Loyalty analysis

-- 16 Revenue Contribution Percentage by Category
SELECT
    category,
    SUM(purchase_amount) AS total_sales,
    ROUND(
        SUM(purchase_amount) * 100 /
        (SELECT SUM(purchase_amount) FROM customer),
        2
    ) AS revenue_percentage
FROM mydata.customer
GROUP BY category
ORDER BY total_sales DESC;
-- Shows which categories drive business revenue

-- 17 . Rank Customers by Spending
SELECT
    customer_id,
    SUM(purchase_amount) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(purchase_amount) DESC
    ) AS spending_rank
FROM mydata.customer
GROUP BY customer_id;
-- VIP customer identification

-- 18. Running Total Revenue
SELECT
    customer_id,
    purchase_amount,
    SUM(purchase_amount) OVER (
        ORDER BY customer_id
    ) AS running_revenue
FROM mydata.customer;
-- Trend tracking
-- Cumulative growth

-- 19. Average Purchase Compared to Overall Average
SELECT
    customer_id,
    purchase_amount,
    (SELECT AVG(purchase_amount) FROM customer) AS overall_avg,
    purchase_amount -
    (SELECT AVG(purchase_amount) FROM customer) AS difference
FROM mydata.customer;
-- Identify above-average customers

-- 20. Top Category per Gender
SELECT
    gender,
    category,
    SUM(purchase_amount) AS total_sales
FROM mydata.customer
GROUP BY gender, category
ORDER BY gender, total_sales DESC;
-- Gender-based product targeting

-- 21. Customer Loyalty Segmentation
SELECT
    customer_id,
    previous_purchases,
    CASE
        WHEN previous_purchases >= 40 THEN 'Highly Loyal'
        WHEN previous_purchases >= 20 THEN 'Loyal'
        WHEN previous_purchases >= 10 THEN 'Regular'
        ELSE 'New'
    END AS loyalty_segment
FROM mydata.customer;
-- Retention campaigns

-- 22 Most Profitable Season per Category
SELECT
    category,
    season,
    SUM(purchase_amount) AS revenue
FROM mydata.customer
GROUP BY category, season
ORDER BY category, revenue DESC;
 -- Seasonal inventory planning
 
--  23. Payment Method Share Percentage
SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(
        COUNT(*) * 100 /
        (SELECT COUNT(*) FROM customer),
        2
    ) AS transaction_percentage
FROM mydata.customer
GROUP BY payment_method;
-- Preferred payment adoption

-- 24 Repeat Purchase Indicator
SELECT
    customer_id,
    previous_purchases,
    CASE
        WHEN previous_purchases > 1 THEN 'Repeat Customer'
        ELSE 'First-Time Customer'
    END AS purchase_type
FROM mydata.customer;
 -- Retention analysis
 
-- 25 Highest Rated Categories with Minimum Sales Threshold
SELECT
    category,
    ROUND(AVG(review_rating),2) AS avg_rating,
    SUM(purchase_amount) AS total_sales
FROM mydata.customer
GROUP BY customer
HAVING SUM(purchase_amount) > 5000
ORDER BY avg_rating DESC;
-- Prevent misleading small-sample ratings

-- 26  Revenue Distribution by Age Group
SELECT
    age_group,
    MIN(purchase_amount) AS min_purchase,
    MAX(purchase_amount) AS max_purchase,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM mydata.customer
GROUP BY age_group;
-- Understand spending spread

-- 27. Highest Revenue Product in Each Category
SELECT
    category,
    item_purchased,
    SUM(purchase_amount) AS revenue
FROM mydata.customer
GROUP BY category, item_purchased
ORDER BY category, revenue DESC;
-- Product prioritization

-- 28 Discount Usage by Gender
SELECT
    gender,
    discount_applied,
    COUNT(*) AS total_customers
FROM mydata.customer
GROUP BY gender, discount_applied;
-- Discount sensitivity analysis

-- 29. Revenue by Frequency of Purchase
SELECT
    frequency_of_purchases,
    SUM(purchase_amount) AS total_sales,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM mydata.customer
GROUP BY frequency_of_purchases
ORDER BY total_sales DESC;
-- Purchase habit analysis

-- 30 Customer Lifetime Value Approximation
SELECT
    customer_id,
    purchase_amount * previous_purchases AS estimated_clv
FROM mydata.customer
ORDER BY estimated_clv DESC;
-- Approximate customer value ranking