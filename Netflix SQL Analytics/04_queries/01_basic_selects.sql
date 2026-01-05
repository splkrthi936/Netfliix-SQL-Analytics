/* =========================================================
   Basic Data Exploration
   ========================================================= */

-- ---------------------------------------------------------
-- 1. Dataset overview
-- Business Question: What does the dataset look like?
-- ---------------------------------------------------------
SELECT *
FROM shows
LIMIT 10;

-- ---------------------------------------------------------
-- 2. Content split by type
-- Business Question: How is Netflix content distributed?
-- ---------------------------------------------------------
SELECT
    type,
    COUNT(*) AS total_titles
FROM shows
GROUP BY type;

-- ---------------------------------------------------------
-- 3. Latest content added to Netflix
-- Business Question: What are the most recent additions?
-- ---------------------------------------------------------
SELECT
    title,
    type,
    date_added
FROM shows
WHERE date_added IS NOT NULL
ORDER BY date_added DESC
LIMIT 5;

-- ---------------------------------------------------------
-- 4. Titles released in a specific year
-- Business Question: What content came out in 2020?
-- ---------------------------------------------------------
SELECT
    title,
    type,
    rating
FROM shows
WHERE release_year = 2020;

-- ---------------------------------------------------------
-- 5. Long-form movies
-- Business Question: Which movies are longer than 90 minutes?
-- ---------------------------------------------------------
SELECT
    title,
    duration
FROM shows
WHERE type = 'Movie'
  AND duration LIKE '%min'
  AND CAST(REPLACE(duration, ' min', '') AS UNSIGNED) > 90;

-- ---------------------------------------------------------
-- 6. Missing metadata check
-- Business Question: Are there data quality gaps?
-- ---------------------------------------------------------
SELECT COUNT(*) AS missing_descriptions
FROM shows
WHERE description IS NULL;

-- ---------------------------------------------------------
-- 7. Ratings used on Netflix
-- Business Question: What rating categories exist?
-- ---------------------------------------------------------
SELECT DISTINCT rating
FROM shows
WHERE rating IS NOT NULL;
