--Alterar nomes colunas com espaço entre as palavras

--ALTER TABLE `desenvolveboticario.crimesp.crimes` RENAME COLUMN `Roubo a Banco ` TO roubo_a_banco;

--Alterar ponto(.) por vírgula (,) 

/*UPDATE `desenvolveboticario.crimesp.crimes`
SET furtos_na_regiao = REPLACE(furtos_na_regiao, '.', ',')
WHERE furtos_na_regiao LIKE '%.%';
*/


--Análise de quantas delegacias registraram algum tipo de crime em SP por ano

SELECT DISTINCT
  COUNT(delegacia) AS qtd_delegacias,
  Ano
FROM `desenvolveboticario.crimesp.crimes`
GROUP BY Ano;


--Análise de total de crimes registrados por delegacia e ano 
--(como não consegui modificar a tabela por comando DML, foi necessário o uso do replace para considerar o número como inteiro)

WITH total_crimes AS (
SELECT 
  Delegacia,
  Ano,
  SUM(CAST(REPLACE(CAST(furtos_na_regiao AS STRING), ".", "") AS INTEGER)) + 
  SUM(roubo_de_carga) + 
  SUM(CAST(REPLACE(CAST(roubos AS STRING), ".", "") AS INTEGER)) + 
  SUM(roubo_de_veiculo) + 
  SUM(CAST(REPLACE(CAST(furto_de_veiculo AS STRING), ".", "") AS INTEGER)) + 
  SUM(Latrocinios) +
  SUM(homicidio_doloso_por_acidente_de_transito) + 
  SUM(homicidio_culposo_por_acidente_de_transito) + 
  SUM(homicidio_culposo) + 
  SUM(tentativa_de_homicido) + 
  SUM(lesao_corporal_seguida_de_morte) + 
  SUM(lesao_corporal_dolosa) + 
  SUM(lesao_corporal_culposa_por_acidente_de_transito) + 
  SUM(lesao_corporal_culposa) + 
  SUM(Estupro) + 
  SUM(estupro_de_vulneravel) + 
  SUM(CAST(REPLACE(CAST(roubo_de_veiculos AS STRING), ".", "") AS INTEGER)) + 
  SUM(roubo_a_banco) AS total_crimes
FROM 
  `desenvolveboticario.crimesp.crimes`
GROUP BY 
  Ano, Delegacia
)


-- Transformação da coluna dos tipos de crimes em linha e classificação por gravidade

SELECT 
  Delegacia, 
  Ano,    
  crime_tipo,
  valor,
  CASE 
    WHEN crime_tipo = 'Furtos na Região' THEN 'Gravidade Baixa'
    WHEN crime_tipo = 'Roubo de Carga' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Roubos' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Roubo de Veículo' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Furto de Veículo' THEN 'Gravidade Baixa'
    WHEN crime_tipo = 'Latrocínios' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Homicídio Doloso por Acidente de Trânsito' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Homicídio Culposo por Acidente de Trânsito' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Homicídio Culposo' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Tentativa de Homicídio' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Lesão Corporal Seguida de Morte' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Lesão Corporal Dolosa' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Lesão Corporal Culposa por Acidente de Trânsito' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Lesão Corporal Culposa' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Estupro' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Estupro de Vulnerável' THEN 'Gravidade Alta'
    WHEN crime_tipo = 'Roubo de Veículos' THEN 'Gravidade Média'
    WHEN crime_tipo = 'Roubo a Banco' THEN 'Gravidade Alta'
    ELSE ''
  END AS classificacao_gravidade
FROM (
  SELECT 
    Delegacia,
    Ano,
    crime_tipo,
    valor
  FROM 
    `desenvolveboticario.crimesp.crimes`,
  UNNEST([
    STRUCT('Furtos na Região' AS crime_tipo, roubos AS valor),
    STRUCT('Roubo de Carga' AS crime_tipo, roubo_de_carga AS valor),
    STRUCT('Roubos' AS crime_tipo, roubos AS valor),
    STRUCT('Roubo de Veículo' AS crime_tipo, roubo_de_veiculo AS valor),
    STRUCT('Furto de Veículo' AS crime_tipo, furto_de_veiculo AS valor),
    STRUCT('Latrocínios' AS crime_tipo, Latrocinios AS valor),
    STRUCT('Homicídio Doloso por Acidente de Trânsito' AS crime_tipo, homicidio_doloso_por_acidente_de_transito AS valor),
    STRUCT('Homicídio Culposo por Acidente de Trânsito' AS crime_tipo, homicidio_culposo_por_acidente_de_transito AS valor),
    STRUCT('Homicídio Culposo' AS crime_tipo, homicidio_culposo AS valor),
    STRUCT('Tentativa de Homicídio' AS crime_tipo, tentativa_de_homicido AS valor),
    STRUCT('Lesão Corporal Seguida de Morte' AS crime_tipo, lesao_corporal_seguida_de_morte AS valor),
    STRUCT('Lesão Corporal Dolosa' AS crime_tipo, lesao_corporal_dolosa AS valor),
    STRUCT('Lesão Corporal Culposa por Acidente de Trânsito' AS crime_tipo, lesao_corporal_culposa_por_acidente_de_transito AS valor),
    STRUCT('Lesão Corporal Culposa' AS crime_tipo, lesao_corporal_culposa AS valor),
    STRUCT('Estupro' AS crime_tipo, Estupro AS valor),
    STRUCT('Estupro de Vulnerável' AS crime_tipo, estupro_de_vulneravel AS valor),
    STRUCT('Roubo de Veículos' AS crime_tipo, roubo_de_veiculos AS valor),
    STRUCT('Roubo a Banco' AS crime_tipo, roubo_a_banco AS valor)
  ]) AS crimes
);


