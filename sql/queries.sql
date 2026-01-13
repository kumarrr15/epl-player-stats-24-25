-- ============================================
-- EPL Player Stats 2024-25: SQL Queries
-- Focus: xG Overperformance Analysis
-- ============================================

-- Query 1: Top 10 xG Overperformers (Clinical Finishers)
SELECT 
    Player,
    Squad,
    Pos,
    Gls,
    xG,
    (Gls - xG) AS xg_overperformance,
    Min
FROM players
WHERE Min >= 900
ORDER BY xg_overperformance DESC
LIMIT 10;

-- Query 2: Average xG Overperformance by Position
SELECT 
    Position,
    COUNT(*) AS player_count,
    AVG(Gls - xG) AS avg_xg_diff,
    AVG(Gls) AS avg_goals,
    AVG(xG) AS avg_xg
FROM players
WHERE Min >= 900
GROUP BY Pos
ORDER BY avg_xg_diff DESC;

-- Query 3: xG Underperformers (Players Missing Chances)
SELECT 
    Player,
    Squad,
    Pos,
    Gls,
    xG,
    (Goals - xG) AS xg_underperformance,
    Shots,
    Min
FROM players
WHERE Min >= 900
ORDER BY xg_underperformance ASC
LIMIT 10;

-- Query 4: High xG Players (Most Dangerous Attackers)
SELECT 
    Player,
    Team,
    xG,
    Goals,
    (Goals - xG) AS xg_diff,
    Min
FROM players
WHERE Minutes >= 900
ORDER BY xG DESC
LIMIT 10;

-- Query 5: Clinical Finishing Rate by Team
SELECT 
    Team,
    COUNT(*) AS player_count,
    SUM(Gls) AS total_goals,
    SUM(xG) AS total_xg,
    (SUM(Gls) - SUM(xG)) AS team_xg_diff,
    ROUND((SUM(Gls) / SUM(xG)) * 100, 2) AS finishing_efficiency_percent
FROM players
WHERE Minutes >= 900
GROUP BY Team
ORDER BY team_xg_diff DESC
LIMIT 10;
