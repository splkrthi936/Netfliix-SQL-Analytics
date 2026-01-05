/* =========================================================
   Advanced Filtering with Subqueries & EXISTS
   ========================================================= */

-- ---------------------------------------------------------
-- 1. Directors who never directed a Movie
-- Business Question: Which directors worked only on TV Shows?
-- Pattern: NOT EXISTS (anti-join)
-- ---------------------------------------------------------
SELECT
    d.director_name
FROM directors d
WHERE NOT EXISTS (
    SELECT 1
    FROM show_directors sd
    JOIN shows s
        ON s.show_id = sd.show_id
    WHERE sd.director_id = d.director_id
      AND s.type = 'Movie'
);

-- ---------------------------------------------------------
-- 2. Shows that belong to more than one genre
-- Business Question: Which titles span multiple genres?
-- Pattern: Subquery + HAVING
-- ---------------------------------------------------------
SELECT
    s.title
FROM shows s
WHERE s.show_id IN (
    SELECT
        sg.show_id
    FROM show_genres sg
    GROUP BY sg.show_id
    HAVING COUNT(DISTINCT sg.genre_id) > 1
);

-- ---------------------------------------------------------
-- 3. Actors who worked with more than one director
-- Business Question: Which actors are highly collaborative?
-- Pattern: GROUP BY + HAVING
-- ---------------------------------------------------------
SELECT
    a.actor_name
FROM actors a
WHERE a.actor_id IN (
    SELECT
        sa.actor_id
    FROM show_actors sa
    JOIN show_directors sd
        ON sa.show_id = sd.show_id
    GROUP BY sa.actor_id
    HAVING COUNT(DISTINCT sd.director_id) > 1
);

-- ---------------------------------------------------------
-- 4. Countries where every title is a Movie
-- Business Question: Which markets only host Movies?
-- Pattern: EXISTS + NOT EXISTS (relational division)
-- ---------------------------------------------------------
SELECT
    c.country_name
FROM countries c
WHERE EXISTS (
    SELECT 1
    FROM show_countries sc
    WHERE sc.country_id = c.country_id
)
AND NOT EXISTS (
    SELECT 1
    FROM show_countries sc
    JOIN shows s
        ON s.show_id = sc.show_id
    WHERE sc.country_id = c.country_id
      AND s.type <> 'Movie'
);

-- ---------------------------------------------------------
-- 5. Actors who acted in all genres
-- Business Question: Which actors have the widest genre reach?
-- Pattern: Double NOT EXISTS (classic relational division)
-- ---------------------------------------------------------
SELECT
    a.actor_name
FROM actors a
WHERE NOT EXISTS (
    SELECT 1
    FROM genres g
    WHERE NOT EXISTS (
        SELECT 1
        FROM show_actors sa
        JOIN show_genres sg
            ON sg.show_id = sa.show_id
        WHERE sa.actor_id = a.actor_id
          AND sg.genre_id = g.genre_id
    )
);

-- ---------------------------------------------------------
-- 6. Shows released after the average release year
-- Business Question: Which content is newer than average?
-- Pattern: Scalar subquery
-- ---------------------------------------------------------
SELECT
    title,
    release_year
FROM shows
WHERE release_year >
      (SELECT AVG(release_year) FROM shows);

-- ---------------------------------------------------------
-- 7. Shows with the maximum number of actors
-- Business Question: Which titles have the largest cast?
-- Pattern: Max-per-group subquery
-- ---------------------------------------------------------
SELECT
    s.title,
    COUNT(sa.actor_id) AS actor_count
FROM shows s
JOIN show_actors sa
    ON s.show_id = sa.show_id
GROUP BY s.show_id, s.title
HAVING COUNT(sa.actor_id) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(actor_id) AS cnt
        FROM show_actors
        GROUP BY show_id
    ) t
);
