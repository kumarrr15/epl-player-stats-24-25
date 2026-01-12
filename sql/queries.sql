-- ============================================
-- EPL Player Stats 2024-25: SQL Queries
-- Focus: xG Overperformance Analysis
-- ============================================

-- Query 1: Top 10 xG Overperformers (Clinical Finishers)
SELECT 
    Player,
    Team,
    Position,
    Goals,
    xG,
    (Goals - xG) AS xg_overperformance,
    Minutes
FROM players
WHERE Minutes >= 500
ORDER BY xg_overperformance DESC
LIMIT 10;

-- Query 2: Average xG Overperformance by Position
SELECT 
    Position,
    COUNT(*) AS player_count,
    AVG(Goals - xG) AS avg_xg_diff,
    AVG(Goals) AS avg_goals,
    AVG(xG) AS avg_xg
FROM players
WHERE Minutes >= 500
GROUP BY Position
ORDER BY avg_xg_diff DESC;

-- Query 3: xG Underperformers (Players Missing Chances)
SELECT 
    Player,
    Team,
    Position,
    Goals,
    xG,
    (Goals - xG) AS xg_underperformance,
    Shots,
    Minutes
FROM players
WHERE Minutes >= 500
ORDER BY xg_underperformance ASC
LIMIT 10;

-- Query 4: High xG Players (Most Dangerous Attackers)
SELECT 
    Player,
    Team,
    xG,
    Goals,
    (Goals - xG) AS xg_diff,
    Shots,
    Minutes
FROM players
WHERE Minutes >= 500
ORDER BY xG DESC
LIMIT 10;

-- Query 5: Clinical Finishing Rate by Team
SELECT 
    Team,
    COUNT(*) AS player_count,
    SUM(Goals) AS total_goals,
    SUM(xG) AS total_xg,
    (SUM(Goals) - SUM(xG)) AS team_xg_diff,
    ROUND((SUM(Goals) / SUM(xG)) * 100, 2) AS finishing_efficiency_percent
FROM players
WHERE Minutes >= 500
GROUP BY Team
ORDER BY team_xg_diff DESC
LIMIT 10;

-- Query 6: Shot Accuracy vs xG Overperformance
SELECT 
    Player,
    Team,
    (Goals - xG) AS xg_diff,
    ROUND((Shots_on_Target * 1.0 / Shots) * 100, 2) AS shot_accuracy_percent,
    Shots,
    Shots_on_Target,
    Goals
FROM players
WHERE Minutes >= 500 AND Shots > 20
ORDER BY xg_diff DESC
LIMIT 15;
