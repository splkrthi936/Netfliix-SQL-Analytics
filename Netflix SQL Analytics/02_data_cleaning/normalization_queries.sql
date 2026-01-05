/* =========================================================
   Data Cleaning & Normalization
   Source Table: netflix_data
   
   --  In this phase, raw source data is standardized through normalization procedures to enforce structural consistency. 
   ========================================================= */
-- 1. POPULATE DIRECTORS DIMENSION
-- =========================================================
INSERT INTO directors (director_name)
SELECT DISTINCT TRIM(director)
FROM netflix_data
WHERE director IS NOT NULL
  AND director <> '';

-- =========================================================
-- 2. POPULATE ACTORS DIMENSION
-- =========================================================
-- Helper numbers table used for splitting comma-separated values

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT PRIMARY KEY);

INSERT INTO numbers (n)
VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

INSERT INTO actors (actor_name)
SELECT DISTINCT
    TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(cast, ',', numbers.n),
            ',', -1
        )
    ) AS actor_name
FROM netflix_data
JOIN numbers
  ON numbers.n <= 1 + LENGTH(cast) - LENGTH(REPLACE(cast, ',', ''))
WHERE cast IS NOT NULL
  AND cast <> '';

-- =========================================================
-- 3. POPULATE COUNTRIES DIMENSION
-- =========================================================
INSERT INTO countries (country_name)
SELECT DISTINCT
    TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(country, ',', numbers.n),
            ',', -1
        )
    ) AS country_name
FROM netflix_data
JOIN numbers
  ON numbers.n <= 1 + LENGTH(country) - LENGTH(REPLACE(country, ',', ''))
WHERE country IS NOT NULL
  AND country <> '';

-- =========================================================
-- 4. POPULATE GENRES DIMENSION
-- =========================================================
INSERT INTO genres (genre_name)
SELECT DISTINCT
    TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(listed_in, ',', numbers.n),
            ',', -1
        )
    ) AS genre_name
FROM netflix_data
JOIN numbers
  ON numbers.n <= 1 + LENGTH(listed_in) - LENGTH(REPLACE(listed_in, ',', ''))
WHERE listed_in IS NOT NULL
  AND listed_in <> '';
