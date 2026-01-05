/* =========================================================
   Window Functions – Rankings & Top-N Analysis
   ========================================================= */

-- ---------------------------------------------------------
-- 1. Top 10 actors by number of titles
-- Pattern: ROW_NUMBER over aggregated results
-- ---------------------------------------------------------
SELECT
    actor_name,
    total_titles
FROM (
    SELECT
        a.actor_name,
        COUNT(DISTINCT sa.show_id) AS total_titles,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(DISTINCT sa.show_id) DESC
        ) AS rn
    FROM actors a
    JOIN show_actors sa
        ON a.actor_id = sa.actor_id
    GROUP BY a.actor_id, a.actor_name
) t
WHERE rn <= 10;

-- ---------------------------------------------------------
-- 2. Top genre per year
-- Pattern: RANK() with PARTITION BY
-- ---------------------------------------------------------
SELECT
    year_added,
    genre_name,
    total_titles
FROM (
    SELECT
        YEAR(s.date_added) AS year_added,
        g.genre_name,
        COUNT(DISTINCT s.show_id) AS total_titles,
        RANK() OVER (
            PARTITION BY YEAR(s.date_added)
            ORDER BY COUNT(DISTINCT s.show_id) DESC
        ) AS rnk
    FROM shows s
    JOIN show_genres sg
        ON s.show_id = sg.show_id
    JOIN genres g
        ON sg.genre_id = g.genre_id
    WHERE s.date_added IS NOT NULL
    GROUP BY YEAR(s.date_added), g.genre_id, g.genre_name
) t
WHERE rnk = 1
ORDER BY year_added;

-- ---------------------------------------------------------
-- 3. Most active director per content type
-- Pattern: DENSE_RANK per partition
-- ---------------------------------------------------------
SELECT
    type,
    director_name,
    total_titles
FROM (
    SELECT
        s.type,
        d.director_name,
        COUNT(DISTINCT s.show_id) AS total_titles,
        DENSE_RANK() OVER (
            PARTITION BY s.type
            ORDER BY COUNT(DISTINCT s.show_id) DESC
        ) AS rnk
    FROM shows s
    JOIN show_directors sd
        ON s.show_id = sd.show_id
    JOIN directors d
        ON sd.director_id = d.director_id
    GROUP BY s.type, d.director_id, d.director_name
) t
WHERE rnk = 1;
