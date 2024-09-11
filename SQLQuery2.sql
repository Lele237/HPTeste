--Campanha com mais leads
SELECT TOP 1 campanha, SUM(leads) AS total_leads
FROM [C�pia de [HP]] PLANILHA TESTE T�CNICO - extract (1)]
GROUP BY campanha
ORDER BY total_leads DESC;

--Campanha com o melhor CPL
SELECT TOP 1 campanha,
       SUM(valor_gasto) / NULLIF(SUM(leads), 0) AS CPL
FROM [C�pia de [HP]] PLANILHA TESTE T�CNICO - extract (1)]
GROUP BY campanha
ORDER BY cpl ASC;
