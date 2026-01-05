/* =========================================================
   Bridge Tables – Many-to-Many Relationships
   ========================================================= */

-- =========================
-- SHOW ↔ ACTORS
-- =========================
DROP TABLE IF EXISTS show_actors;
CREATE TABLE show_actors (
    show_id   VARCHAR(20),
    actor_id  INT,
    PRIMARY KEY (show_id, actor_id)
);

-- =========================
-- SHOW ↔ DIRECTORS
-- =========================
DROP TABLE IF EXISTS show_directors;
CREATE TABLE show_directors (
    show_id      VARCHAR(20),
    director_id  INT,
    PRIMARY KEY (show_id, director_id)
);

-- =========================
-- SHOW ↔ COUNTRIES
-- =========================
DROP TABLE IF EXISTS show_countries;
CREATE TABLE show_countries (
    show_id     VARCHAR(20),
    country_id  INT,
    PRIMARY KEY (show_id, country_id)
);

-- =========================
-- SHOW ↔ GENRES
-- =========================
DROP TABLE IF EXISTS show_genres;
CREATE TABLE show_genres (
    show_id   VARCHAR(20),
    genre_id  INT,
    PRIMARY KEY (show_id, genre_id)
);
