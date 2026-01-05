INSERT INTO shows (
    show_id,
    type,
    title,
    date_added,
    release_year,
    rating,
    duration,
    description
)
SELECT
    show_id,
    MAX(type) AS type,
    MAX(title) AS title,
    MAX(
        CASE
            WHEN date_added LIKE '%/%/%'
                THEN STR_TO_DATE(date_added, '%m/%d/%Y')
            WHEN date_added LIKE '%,%'
                THEN STR_TO_DATE(date_added, '%M %d, %Y')
            ELSE NULL
        END
    ) AS date_added,
    MAX(release_year) AS release_year,
    MAX(rating) AS rating,
    MAX(duration) AS duration,
    MAX(description) AS description
FROM netflix_data
GROUP BY show_id;
