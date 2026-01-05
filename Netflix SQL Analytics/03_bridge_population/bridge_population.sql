/* =========================================================
   Bridge Table Population
   ========================================================= */

-- =========================================================
-- 1. POPULATE SHOW_DIRECTORS
-- =========================================================
INSERT INTO show_directors (show_id, director_id)
SELECT DISTINCT
    s.show_id,
    d.director_id
FROM netflix_data nd
JOIN shows s
    ON s.show_id = nd.show_id
JOIN directors d
    ON d.director_name = nd.director
WHERE nd.director IS NOT NULL
  AND nd.director <> '';

-- =========================================================
-- 2. POPULATE SHOW_ACTORS
-- =========================================================
INSERT INTO show_actors (show_id, actor_id)
SELECT DISTINCT
    s.show_id,
    a.actor_id
FROM netflix_data nd
JOIN shows s
    ON s.show_id = nd.show_id
JOIN numbers n
    ON n.n <= 1 + LENGTH(nd.cast) - LENGTH(REPLACE(nd.cast, ',', ''))
JOIN actors a
    ON a.actor_name = TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(nd.cast, ',', n.n),
            ',', -1
        )
    )
WHERE nd.cast IS NOT NULL
  AND nd.cast <> '';

-- =========================================================
-- 3. POPULATE SHOW_COUNTRIES
-- =========================================================
INSERT INTO show_countries (show_id, country_id)
SELECT DISTINCT
    s.show_id,
    c.country_id
FROM netflix_data nd
JOIN shows s
    ON s.show_id = nd.show_id
JOIN numbers n
    ON n.n <= 1 + LENGTH(nd.country) - LENGTH(REPLACE(nd.country, ',', ''))
JOIN countries c
    ON c.country_name = TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(nd.country, ',', n.n),
            ',', -1
        )
    )
WHERE nd.country IS NOT NULL
  AND nd.country <> '';

-- =========================================================
-- 4. POPULATE SHOW_GENRES
-- =========================================================
INSERT INTO show_genres (show_id, genre_id)
SELECT DISTINCT
    s.show_id,
    g.genre_id
FROM netflix_data nd
JOIN shows s
    ON s.show_id = nd.show_id
JOIN numbers n
    ON n.n <= 1 + LENGTH(nd.listed_in) - LENGTH(REPLACE(nd.listed_in, ',', ''))
JOIN genres g
    ON g.genre_name = TRIM(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(nd.listed_in, ',', n.n),
            ',', -1
        )
    )
WHERE nd.listed_in IS NOT NULL
  AND nd.listed_in <> '';
