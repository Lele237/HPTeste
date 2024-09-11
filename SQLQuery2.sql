--Campanha com mais leads
SELECT TOP 1 campanha, SUM(leads) AS total_leads
FROM [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
GROUP BY campanha
ORDER BY total_leads DESC;

--Campanha com o melhor CPL
SELECT TOP 1 campanha,
       SUM(valor_gasto) / NULLIF(SUM(leads), 0) AS CPL
FROM [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
GROUP BY campanha
ORDER BY cpl ASC;
