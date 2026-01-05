/* =========================================================
   Aggregations & Trend Analysis
   ========================================================= */

-- ---------------------------------------------------------
-- 1. Content growth by year
-- Business Question: How many titles were added each year?
-- ---------------------------------------------------------
SELECT
    YEAR(date_added) AS year_added,
    COUNT(*) AS total_titles
FROM shows
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- ---------------------------------------------------------
-- 2. Movies vs TV Shows over time
-- Business Question: How has the content mix evolved?
-- ---------------------------------------------------------
SELECT
    YEAR(date_added) AS year_added,
    type,
    COUNT(*) AS total_titles
FROM shows
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added), type
ORDER BY year_added, type;

-- ---------------------------------------------------------
-- 3. Years with unusually high content additions
-- Business Question: Which years saw large catalog expansion?
-- ---------------------------------------------------------
SELECT
    YEAR(date_added) AS year_added,
    COUNT(*) AS total_titles
FROM shows
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
HAVING COUNT(*) > 500
ORDER BY total_titles DESC;

-- ---------------------------------------------------------
-- 4. Average release year by content type
-- Business Question: Are Movies or TV Shows generally newer?
-- ---------------------------------------------------------
SELECT
    type,
    ROUND(AVG(release_year), 1) AS avg_release_year
FROM shows
GROUP BY type;

-- ---------------------------------------------------------
-- 5. Most common ratings on Netflix
-- Business Question: What ratings dominate the catalog?
-- ---------------------------------------------------------
SELECT
    rating,
    COUNT(*) AS total_titles
FROM shows
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

-- ---------------------------------------------------------
-- 6. Long-form movie analysis
-- Business Question: What is the average movie duration?
-- ---------------------------------------------------------
SELECT
    ROUND(
        AVG(CAST(REPLACE(duration, ' min', '') AS UNSIGNED)),
        1
    ) AS avg_movie_duration_minutes
FROM shows
WHERE type = 'Movie'
  AND duration LIKE '%min';

-- ---------------------------------------------------------
-- 7. Release years with diverse content types
-- Business Question: Which years had both Movies and TV Shows?
-- ---------------------------------------------------------
SELECT
    release_year
FROM shows
WHERE type IN ('Movie', 'TV Show')
GROUP BY release_year
HAVING COUNT(DISTINCT type) = 2
ORDER BY release_year;

-- ---------------------------------------------------------
-- 8. Data quality check: Missing critical metadata
-- Business Question: Are there gaps in key attributes?
-- ---------------------------------------------------------
SELECT
    SUM(description IS NULL) AS missing_descriptions,
    SUM(rating IS NULL) AS missing_ratings,
    COUNT(*) AS total_titles
FROM shows;
