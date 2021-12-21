create database dsa_cap02
go

use dsa_cap02
go

create table tb_navios(
	nome_navio varchar(200),
	mes_ano varchar(20),
	classificacao_risco varchar(20),
	indice_conformidade float,
	pontuacao_risco int,
	temporada varchar(200)
)
go

bulk insert tb_navios
from '\\VM-DELL\Users\VM_Dell\Downloads\DADOS_ABERTOS_INSPECAO_NAVIO.csv'  -- Caminho do arquivo no Servidor em que est� instalado o SGBD (VM no Dell).
with(
	format = 'csv',
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '0x0a'  -- N�o consegui usando o valor '\n'. Alternei para '0x0a' e o comando bulk processou. Muuuuuuito estranho. Fonte da pesquisa: 'https://isolution.pro/pt/q/so68956216/sql-server-bcp-bulk-insert-pipe-delimitado-com-arquivo-de-formato-de-qualificador-de-texto'
)
go

select * from tb_navios

/* EXERC�CIO */
/* Trabalhando  com  o  mesmo  datasetusado  neste  cap�tulo, crie  instru��es  SQL  que respondam �s perguntas abaixo:

1-Quais embarca��es possuem pontua��o de risco igual a 310? - 2 registros */
select * from tb_navios where pontuacao_risco = 310

/*2-Quais embarca��es t�m classifica��o de risco A e �ndice de conformidade maior ou igual a 95%? - 259 registros */
select * from tb_navios where classificacao_risco = 'A' and indice_conformidade >= 95

/*3-Quais embarca��es t�m classifica��o de risco C ou D e �ndice de conformidade menor ou igual a 95%? - 98 registros */
select * from tb_navios where classificacao_risco in ('C', 'D') and indice_conformidade <= 95

/*4-Quais embarca��es t�m classifica��o de risco A ou pontua��o de risco igual a 0? - 261 registros */
select * from tb_navios where classificacao_risco = 'A' or pontuacao_risco = 0

/*5-[DESAFIO]Quais embarca��es foram inspecionadas em Dezembro de 2016? - 7 registros*/
select * from tb_navios where temporada like '%Dezembro 2016'
