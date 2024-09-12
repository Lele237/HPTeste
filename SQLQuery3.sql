
-- Análise Temporal para Otimização de Investimentos
SELECT 
    data, 
    SUM(impressões) AS total_impressões, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(cliques) / NULLIF(SUM(impressões), 0)) * 100 AS ctr, 
    (SUM(leads) / NULLIF(SUM(cliques), 0)) * 100 AS taxa_conversao
FROM 
   [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
WHERE 
    data BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY 
    data
ORDER BY 
    taxa_conversao DESC;


-- Analisar o desempenho por data para identificar picos e baixas
SELECT 
    data,
    SUM(leads) AS total_leads,
    SUM(valor_gasto) AS total_gasto,
    SUM(valor_gasto) / NULLIF(SUM(leads), 0) AS cpl
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
WHERE 
    data BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY 
    data
ORDER BY 
    cpl DESC;

--Identificação de Anúncios que têm alta despesa, mas baixa conversão.
SELECT 
    grupo_de_anúncio, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) AS cpl
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
WHERE 
   data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    grupo_de_anúncio
HAVING 
    SUM(leads) = 0 OR (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) > 50  
ORDER BY 
    cpl DESC;


-- Comparar o investimento com o número de leads gerados por campanha
SELECT 
    campanha,
    SUM(leads) AS total_leads,
    SUM(valor_gasto) AS total_gasto,
    CASE 
        WHEN SUM(valor_gasto) > 0 THEN SUM(leads) / SUM(valor_gasto)
        ELSE 0
    END AS eficiencia_orcamento
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    campanha
ORDER BY 
    eficiencia_orcamento DESC;


-- Análise de performance por segmento 
SELECT 
    grupo_de_anúncio,
    canal,
    SUM(leads) AS total_leads,
    SUM(valor_gasto) AS total_gasto,
    SUM(valor_gasto) / NULLIF(SUM(leads), 0) AS cpl
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO (1) - Copiar (3) - extract]
WHERE 
    data BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY 
    grupo_de_anúncio, canal
ORDER BY 
    cpl DESC;

	-- Comparação do desempenho de canais para melhor alocação de orçamento
SELECT 
    canal, 
    SUM(valor_gasto) AS total_gasto, 
    SUM(leads) AS total_leads,
    SUM(leads) / NULLIF(SUM(valor_gasto), 0) AS leads_por_gasto
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO (1) - Copiar (3) - extract]
WHERE 
    data BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY 
    canal
ORDER BY 
    leads_por_gasto DESC;  




