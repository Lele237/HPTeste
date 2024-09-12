  -- Análise de performance por canal e campanha
SELECT 
    canal, 
    campanha, 
    SUM(impressões) AS total_impressões, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(cliques) / SUM(impressões)) * 100 AS ctr,  -- Taxa de Cliques
    (SUM(leads) / SUM(cliques)) * 100 AS taxa_conversao,  -- Taxa de Conversão
    (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) AS cpl  -- Custo por Lead
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO (1) - Copiar (3) - extract]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    canal, campanha
ORDER BY 
    taxa_conversao DESC, ctr DESC;


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
    SUM(leads) = 0 OR (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) > 50  -- Ajuste o valor conforme a meta de CPL desejada
ORDER BY 
    cpl DESC;

	--Análise temporal para Otimização de investimentos
SELECT 
    data, 
    SUM(impressões) AS total_impressões, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(cliques) / SUM(impressões)) * 100 AS ctr, 
    (SUM(leads) / SUM(cliques)) * 100 AS taxa_conversao
FROM 
   [Cópia de [HP]] PLANILHA TESTE TÉCNICO - extract (1)]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    data
ORDER BY 
    taxa_conversao DESC;

	-- Comparação do desempenho de canais para melhor alocação de orçamento
SELECT 
    canal, 
    SUM(valor_gasto) AS total_gasto, 
    SUM(leads) AS total_leads,
    (SUM(leads) / NULLIF(SUM(valor_gasto), 0)) AS leads_por_gasto
FROM 
    [Cópia de [HP]] PLANILHA TESTE TÉCNICO (1) - Copiar (3) - extract]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    canal
ORDER BY 
    leads_por_gasto DESC;

