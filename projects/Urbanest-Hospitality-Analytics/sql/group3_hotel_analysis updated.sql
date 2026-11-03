-- =====================================================================
-- UrbanNest Hospitality Analytics | Group 3 Capstone | SQL Analysis
-- SQL team : Jacinta Syokau, Stephen Bonu
-- Engine   : SQLite 3 (any version; no window functions required)
-- Database : hotel.db, created by HOSPITALITY_CAPSTONE_MASTER_v4.ipynb (Section 7)
-- Table    : hotel_booking (cleaned data, 85,501 rows)
-- Run      : sqlite3 hotel.db < group3_hotel_analysis.sql
-- Notes    : revenue = adr * total_nights  ("booking value", EUR)
--            Cancelled bookings keep their booking value, so completed
--            (realized) value is calculated with is_canceled = 0.
-- =====================================================================

.headers on
.mode column

-- ---------------------------------------------------------------------
-- 0. Sanity check: row count and date range
-- ---------------------------------------------------------------------
SELECT COUNT(*)               AS n_bookings,
       SUM(is_canceled)       AS n_cancelled,
       MIN(arrival_date_year) AS first_year,
       MAX(arrival_date_year) AS last_year
FROM hotel_booking;

-- ---------------------------------------------------------------------
-- Q1. Which room types generate the highest average revenue?
--     Shows booking value (all bookings) and completed value (stays only).
--     Room L (6 bookings) is excluded because its average is unreliable.
-- ---------------------------------------------------------------------
SELECT reserved_room_type,
       COUNT(*)                                                  AS n_bookings,
       ROUND(AVG(revenue), 2)                                    AS avg_booking_value,
       ROUND(AVG(CASE WHEN is_canceled = 0 THEN revenue END), 2) AS avg_completed_value
FROM hotel_booking
GROUP BY reserved_room_type
HAVING COUNT(*) >= 100
ORDER BY avg_completed_value DESC;

-- ---------------------------------------------------------------------
-- Q2. Which months have the highest booking activity?
--     The data covers Jul-2015 to Aug-2017, so July and August appear in
--     3 years and every other month in 2. bookings_per_year corrects this.
-- ---------------------------------------------------------------------
SELECT arrival_date_month,
       COUNT(*)                                                         AS n_bookings,
       COUNT(DISTINCT arrival_date_year)                                AS years_covered,
       ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT arrival_date_year), 0)     AS bookings_per_year,
       ROUND(AVG(adr), 2)                                               AS avg_adr,
       ROUND(AVG(is_canceled) * 100, 1)                                 AS cancellation_rate_pct,
       ROUND(SUM(CASE WHEN is_canceled = 0 THEN revenue ELSE 0 END), 0) AS completed_value
FROM hotel_booking
GROUP BY arrival_date_month
ORDER BY bookings_per_year DESC;

-- ---------------------------------------------------------------------
-- Q3. What is the average revenue for different customer segments?
-- ---------------------------------------------------------------------
-- 3a. By market segment
SELECT market_segment,
       COUNT(*)                                                  AS n_bookings,
       ROUND(AVG(revenue), 2)                                    AS avg_booking_value,
       ROUND(AVG(CASE WHEN is_canceled = 0 THEN revenue END), 2) AS avg_completed_value
FROM hotel_booking
WHERE market_segment <> 'Undefined'
GROUP BY market_segment
ORDER BY avg_booking_value DESC;

-- 3b. By customer type
SELECT customer_type,
       COUNT(*)                                                  AS n_bookings,
       ROUND(AVG(revenue), 2)                                    AS avg_booking_value,
       ROUND(AVG(CASE WHEN is_canceled = 0 THEN revenue END), 2) AS avg_completed_value
FROM hotel_booking
GROUP BY customer_type
ORDER BY avg_booking_value DESC;

-- ---------------------------------------------------------------------
-- Q4. Which market segments generate the most total revenue,
--     and how much of their booked value is actually retained?
-- ---------------------------------------------------------------------
SELECT market_segment,
       COUNT(*)                                                         AS n_bookings,
       ROUND(SUM(revenue), 0)                                           AS total_booking_value,
       ROUND(SUM(CASE WHEN is_canceled = 0 THEN revenue ELSE 0 END), 0) AS completed_value,
       ROUND(100.0 * SUM(CASE WHEN is_canceled = 0 THEN revenue ELSE 0 END)
             / SUM(revenue), 1)                                         AS pct_value_retained
FROM hotel_booking
GROUP BY market_segment
ORDER BY completed_value DESC;

-- ---------------------------------------------------------------------
-- Q5. What is the cancellation rate by market segment?
--     (Source of the "Online TA 35.5% vs Direct/Offline ~15%" finding)
-- ---------------------------------------------------------------------
SELECT market_segment,
       COUNT(*)                         AS n_bookings,
       SUM(is_canceled)                 AS n_cancelled,
       ROUND(AVG(is_canceled) * 100, 1) AS cancellation_rate_pct
FROM hotel_booking
WHERE market_segment <> 'Undefined'
GROUP BY market_segment
ORDER BY cancellation_rate_pct DESC;

-- ---------------------------------------------------------------------
-- Q6. What is the overall cancellation rate and cancelled value?
-- ---------------------------------------------------------------------
SELECT COUNT(*)                                                   AS n_bookings,
       SUM(is_canceled)                                           AS n_cancelled,
       ROUND(AVG(is_canceled) * 100, 2)                           AS cancellation_rate_pct,
       ROUND(SUM(revenue), 0)                                     AS total_booking_value,
       ROUND(SUM(CASE WHEN is_canceled = 1 THEN revenue END), 0)  AS cancelled_value,
       ROUND(100.0 * SUM(CASE WHEN is_canceled = 1 THEN revenue END)
             / SUM(revenue), 1)                                   AS pct_value_cancelled
FROM hotel_booking;

-- ---------------------------------------------------------------------
-- Q7. What is the average length of stay (completed stays), by hotel?
-- ---------------------------------------------------------------------
SELECT hotel,
       ROUND(AVG(total_nights), 2) AS avg_length_of_stay,
       ROUND(AVG(revenue), 2)      AS avg_completed_value
FROM hotel_booking
WHERE is_canceled = 0
GROUP BY hotel
UNION ALL
SELECT 'All hotels',
       ROUND(AVG(total_nights), 2),
       ROUND(AVG(revenue), 2)
FROM hotel_booking
WHERE is_canceled = 0;

-- ---------------------------------------------------------------------
-- Q8. Which room types are booked most frequently?
-- ---------------------------------------------------------------------
SELECT reserved_room_type,
       COUNT(*) AS n_bookings,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM hotel_booking), 1) AS share_pct
FROM hotel_booking
GROUP BY reserved_room_type
ORDER BY n_bookings DESC;

-- ---------------------------------------------------------------------
-- Q9. Booking value by hotel: completed vs cancelled
-- ---------------------------------------------------------------------
SELECT hotel,
       COUNT(*)                                                         AS n_bookings,
       ROUND(AVG(is_canceled) * 100, 1)                                 AS cancellation_rate_pct,
       ROUND(SUM(CASE WHEN is_canceled = 0 THEN revenue ELSE 0 END), 0) AS completed_value,
       ROUND(SUM(CASE WHEN is_canceled = 1 THEN revenue ELSE 0 END), 0) AS cancelled_value
FROM hotel_booking
GROUP BY hotel;

-- ---------------------------------------------------------------------
-- Q10. Cancellation rate by lead time
-- ---------------------------------------------------------------------
SELECT CASE
         WHEN lead_time <= 7   THEN '1) 0-7 days'
         WHEN lead_time <= 30  THEN '2) 8-30 days'
         WHEN lead_time <= 90  THEN '3) 31-90 days'
         WHEN lead_time <= 180 THEN '4) 91-180 days'
         WHEN lead_time <= 365 THEN '5) 181-365 days'
         ELSE                       '6) 365+ days'
       END                              AS lead_time_band,
       COUNT(*)                         AS n_bookings,
       ROUND(AVG(is_canceled) * 100, 1) AS cancellation_rate_pct
FROM hotel_booking
GROUP BY lead_time_band
ORDER BY lead_time_band;

-- ---------------------------------------------------------------------
-- Q11. Peak-season cancellation exposure: July and August by segment
-- ---------------------------------------------------------------------
SELECT market_segment,
       COUNT(*)                                                   AS n_bookings,
       ROUND(AVG(is_canceled) * 100, 1)                           AS cancellation_rate_pct,
       ROUND(SUM(CASE WHEN is_canceled = 1 THEN revenue END), 0)  AS cancelled_value
FROM hotel_booking
WHERE arrival_date_month IN ('July', 'August')
  AND market_segment <> 'Undefined'
GROUP BY market_segment
ORDER BY cancelled_value DESC;
