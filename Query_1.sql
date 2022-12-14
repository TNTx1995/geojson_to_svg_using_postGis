WITH
    query AS (SELECT geom AS geometry FROM table_name limit 1 ),
    q AS (SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="green"', ' />')),'') as svg FROM query )
SELECT
    CONCAT('<svg xmlns="http://w...content-available-to-author-only...3.org/2000/svg" xmlns:xlink="http://w...content-available-to-author-only...3.org/1999/xlink" height="400" width="400" viewBox="',
        CONCAT_WS(' ', q.x_min, -1 * q.y_max, q.x_max-q.x_min, q.y_max-q.y_min), '">', q.svg, '</svg>') FROM q