####Netflix SQL Analytics Project

###Project Summary

This project demonstrates advanced SQL skills by transforming raw Netflix data into a fully normalized relational database and performing business-driven analytics.

The objective was not just to write queries, but to simulate a real-world data workflow:
- Clean messy raw data
- Design a scalable database schema
- Build many-to-many relationships
- Perform analytical and trend-based SQL analysis

This project showcases practical SQL used in analytics and data engineering roles.



 Dataset

Source: Netflix Titles Dataset  

Challenges handled:
- Duplicate primary keys in raw data
- Inconsistent date formats
- Comma-separated values (actors, directors, genres, countries)
- Missing metadata fields



##  Database Design

The database was normalized to Third Normal Form (3NF).

### Fact Table
- `shows`

### Dimension Tables
- `actors`
- `directors`
- `countries`
- `genres`

### Bridge Tables (Many-to-Many Relationships)
- `show_actors`
- `show_directors`
- `show_countries`
- `show_genres`

This design enables scalable analytics across content, geography, and people.



## Data Engineering Steps

- Deduplicated records during ingestion
- Standardized inconsistent date formats
- Parsed comma-separated fields using SQL string functions
- Created surrogate keys for dimensions
- Built bridge tables to support many-to-many joins
- Designed idempotent load scripts



##  Key Business Insights Generated

### Content Growth Analysis
- Year-over-year content expansion
- Cumulative catalog growth
- Movie vs TV Show trends over time

### Genre & Country Analysis
- Most dominant genres
- Genre popularity by year
- Countries contributing the most content
- Content type dominance by country

### People & Collaboration Analysis
- Top actors and directors by number of titles
- Actor–director collaboration patterns
- Directors who only worked on TV Shows
- Actors appearing across multiple genres

### Advanced SQL Patterns Used
- Complex multi-table joins
- EXISTS / NOT EXISTS (anti-joins)
- Relational division logic
- Subqueries and max-per-group patterns
- Window functions (ROW_NUMBER, RANK, LAG)
- Running totals and time-series analysis


##  SQL Skills Demonstrated

- Schema design & normalization
- Aggregations and HAVING filters
- Advanced join logic
- Subqueries & correlated queries
- Window functions
- Time-series analytics
- Data quality auditing
- Business-oriented query design


This project simulates a real analytics workflow, from raw data ingestion to advanced SQL insights.

It demonstrates the ability to:
- Handle imperfect real-world datasets
- Design normalized relational databases
- Write advanced analytical SQL
- Translate data into meaningful business insights


