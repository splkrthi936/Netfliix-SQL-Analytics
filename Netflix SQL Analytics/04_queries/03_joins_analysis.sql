/* =========================================================
   Join-Based Analytics
   ========================================================= */
-- ---------------------------------------------------------
-- 1. Shows with their directors
-- Business Question: Who directed what?
-- ---------------------------------------------------------
SELECT
    s.title,
    d.director_name
FROM shows s
JOIN show_directors sd
    ON s.show_id = sd.show_id
JOIN directors d
    ON sd.director_id = d.director_id
ORDER BY d.director_name, s.title;

-- ---------------------------------------------------------
-- 2. Top directors by number of titles
-- Business Question: Who are the most active directors?
-- ---------------------------------------------------------
SELECT
    d.director_name,
    COUNT(DISTINCT sd.show_id) AS total_titles
FROM directors d
JOIN show_directors sd
    ON d.director_id = sd.director_id
GROUP BY d.director_id, d.director_name
ORDER BY total_titles DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 3. Top actors by number of appearances
-- Business Question: Who appears most frequently on Netflix?
-- ---------------------------------------------------------
SELECT
    a.actor_name,
    COUNT(DISTINCT sa.show_id) AS total_titles
FROM actors a
JOIN show_actors sa
    ON a.actor_id = sa.actor_id
GROUP BY a.actor_id, a.actor_name
ORDER BY total_titles DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 4. Country-wise content count
-- Business Question: Which countries contribute the most content?
-- ---------------------------------------------------------
SELECT
    c.country_name,
    COUNT(DISTINCT sc.show_id) AS total_titles
FROM countries c
JOIN show_countries sc
    ON c.country_id = sc.country_id
GROUP BY c.country_id, c.country_name
ORDER BY total_titles DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 5. Genre popularity
-- Business Question: Which genres dominate Netflix?
-- ---------------------------------------------------------
SELECT
    g.genre_name,
    COUNT(DISTINCT sg.show_id) AS total_titles
FROM genres g
JOIN show_genres sg
    ON g.genre_id = sg.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY total_titles DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 6. Movies vs TV Shows by country
-- Business Question: What content type dominates per country?
-- ---------------------------------------------------------
SELECT
    c.country_name,
    s.type,
    COUNT(DISTINCT s.show_id) AS total_titles
FROM countries c
JOIN show_countries sc
    ON c.country_id = sc.country_id
JOIN shows s
    ON sc.show_id = s.show_id
GROUP BY c.country_id, c.country_name, s.type
ORDER BY c.country_name, total_titles DESC;

-- ---------------------------------------------------------
-- 7. Actor–Director collaborations
-- Business Question: Which actor-director pairs collaborate most?
-- ---------------------------------------------------------
SELECT
    a.actor_name,
    d.director_name,
    COUNT(DISTINCT sa.show_id) AS collaborations
FROM show_actors sa
JOIN actors a
    ON sa.actor_id = a.actor_id
JOIN show_directors sd
    ON sa.show_id = sd.show_id
JOIN directors d
    ON sd.director_id = d.director_id
GROUP BY a.actor_id, d.director_id
ORDER BY collaborations DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 8. Genre diversity per show
-- Business Question: Which titles span multiple genres?
-- ---------------------------------------------------------
SELECT
    s.title,
    COUNT(DISTINCT sg.genre_id) AS genre_count
FROM shows s
JOIN show_genres sg
    ON s.show_id = sg.show_id
GROUP BY s.show_id, s.title
HAVING COUNT(DISTINCT sg.genre_id) > 1
ORDER BY genre_count DESC;
