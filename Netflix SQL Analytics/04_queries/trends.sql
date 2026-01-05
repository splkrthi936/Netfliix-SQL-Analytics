/* =========================================================
   Window Functions – Time Series & Growth Analysis
   ========================================================= */

-- ---------------------------------------------------------
-- 1. Year-over-year content growth
-- Pattern: LAG()
-- ---------------------------------------------------------
WITH yearly_counts AS (
    SELECT
        YEAR(date_added) AS year_added,
        COUNT(*) AS total_titles
    FROM shows
    WHERE date_added IS NOT NULL
    GROUP BY YEAR(date_added)
)
SELECT
    year_added,
    total_titles,
    total_titles - LAG(total_titles) OVER (
        ORDER BY year_added
    ) AS yoy_growth
FROM yearly_counts
ORDER BY year_added;

-- ---------------------------------------------------------
-- 2. Cumulative content growth
-- Pattern: Running total
-- ---------------------------------------------------------
WITH yearly_counts AS (
    SELECT
        YEAR(date_added) AS year_added,
        COUNT(*) AS total_titles
    FROM shows
    WHERE date_added IS NOT NULL
    GROUP BY YEAR(date_added)
)
SELECT
    year_added,
    total_titles,
    SUM(total_titles) OVER (
        ORDER BY year_added
    ) AS cumulative_titles
FROM yearly_counts
ORDER BY year_added;

-- ---------------------------------------------------------
-- 3. Content growth trend classification
-- Pattern: LAG + CASE
-- ---------------------------------------------------------
WITH yearly_counts AS (
    SELECT
        YEAR(date_added) AS year_added,
        COUNT(*) AS total_titles
    FROM shows
    WHERE date_added IS NOT NULL
    GROUP BY YEAR(date_added)
)
SELECT
    year_added,
    total_titles,
    CASE
        WHEN total_titles > LAG(total_titles) OVER (ORDER BY year_added)
            THEN 'Increase'
        WHEN total_titles < LAG(total_titles) OVER (ORDER BY year_added)
            THEN 'Decrease'
        ELSE 'No Change'
    END AS growth_trend
FROM yearly_counts
ORDER BY year_added;

-- ---------------------------------------------------------
-- 4. Running total by content type
-- Pattern: PARTITION + ORDER
-- ---------------------------------------------------------
WITH yearly_type_counts AS (
    SELECT
        YEAR(date_added) AS year_added,
        type,
        COUNT(*) AS total_titles
    FROM shows
    WHERE date_added IS NOT NULL
    GROUP BY YEAR(date_added), type
)
SELECT
    year_added,
    type,
    total_titles,
    SUM(total_titles) OVER (
        PARTITION BY type
        ORDER BY year_added
    ) AS cumulative_by_type
FROM yearly_type_counts
ORDER BY type, year_added;
