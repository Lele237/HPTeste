  -- An�lise de performance por canal e campanha
SELECT 
    canal, 
    campanha, 
    SUM(impress�es) AS total_impress�es, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(cliques) / SUM(impress�es)) * 100 AS ctr,  -- Taxa de Cliques
    (SUM(leads) / SUM(cliques)) * 100 AS taxa_conversao,  -- Taxa de Convers�o
    (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) AS cpl  -- Custo por Lead
FROM 
    [C�pia de [HP]] PLANILHA TESTE T�CNICO (1) - Copiar (3) - extract]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    canal, campanha
ORDER BY 
    taxa_conversao DESC, ctr DESC;


	--Identifica��o de An�ncios que t�m alta despesa, mas baixa convers�o.
SELECT 
    grupo_de_an�ncio, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) AS cpl
FROM 
    [C�pia de [HP]] PLANILHA TESTE T�CNICO - extract (1)]
WHERE 
   data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    grupo_de_an�ncio
HAVING 
    SUM(leads) = 0 OR (SUM(valor_gasto) / NULLIF(SUM(leads), 0)) > 50  -- Ajuste o valor conforme a meta de CPL desejada
ORDER BY 
    cpl DESC;

	--An�lise temporal para Otimiza��o de investimentos
SELECT 
    data, 
    SUM(impress�es) AS total_impress�es, 
    SUM(cliques) AS total_cliques, 
    SUM(leads) AS total_leads, 
    SUM(valor_gasto) AS total_gasto,
    (SUM(cliques) / SUM(impress�es)) * 100 AS ctr, 
    (SUM(leads) / SUM(cliques)) * 100 AS taxa_conversao
FROM 
   [C�pia de [HP]] PLANILHA TESTE T�CNICO - extract (1)]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    data
ORDER BY 
    taxa_conversao DESC;

	-- Compara��o do desempenho de canais para melhor aloca��o de or�amento
SELECT 
    canal, 
    SUM(valor_gasto) AS total_gasto, 
    SUM(leads) AS total_leads,
    (SUM(leads) / NULLIF(SUM(valor_gasto), 0)) AS leads_por_gasto
FROM 
    [C�pia de [HP]] PLANILHA TESTE T�CNICO (1) - Copiar (3) - extract]
WHERE 
    data >= '2024-08-01' AND data <= '2024-08-31'
GROUP BY 
    canal
ORDER BY 
    leads_por_gasto DESC;

