/* =========================================================
Core & Dimension Tables
   ========================================================= */

-- =========================
-- FACT TABLE
-- =========================
DROP TABLE IF EXISTS shows;

CREATE TABLE shows (
    show_id        VARCHAR(20) PRIMARY KEY,
    type           VARCHAR(20),
    title          VARCHAR(255),
    date_added     DATE,
    release_year   INT,
    rating         VARCHAR(20),
    duration       VARCHAR(50),
    description    TEXT
);

-- =========================
-- DIMENSION TABLES
-- =========================

DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
    actor_id    INT AUTO_INCREMENT PRIMARY KEY,
    actor_name  VARCHAR(255)
);

DROP TABLE IF EXISTS directors;
CREATE TABLE directors (
    director_id     INT AUTO_INCREMENT PRIMARY KEY,
    director_name   VARCHAR(255)
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id      INT AUTO_INCREMENT PRIMARY KEY,
    country_name    VARCHAR(255)
);

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
    genre_id    INT AUTO_INCREMENT PRIMARY KEY,
    genre_name  VARCHAR(255)
);
