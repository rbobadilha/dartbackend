-- --------------------------------------------------------
-- Servidor:                     192.168.1.18
-- Versão do servidor:           Microsoft SQL Server 2016 (RTM-GDR) (KB4019088) - 13.0.1742.0
-- OS do Servidor:               Windows Server 2016 Standard 6.3 <X64> (Build 14393: ) (Hypervisor)
-- HeidiSQL Versão:              12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando dados para a tabela constman.configuracoes: -1 rows
/*!40000 ALTER TABLE "configuracoes" DISABLE KEYS */;
INSERT INTO "configuracoes" ("constArea", "constValorPrevistoM2", "constUsarValorPrevisto") VALUES
	(355, 5000, b'0');
/*!40000 ALTER TABLE "configuracoes" ENABLE KEYS */;

-- Copiando dados para a tabela constman.contas: -1 rows
/*!40000 ALTER TABLE "contas" DISABLE KEYS */;
INSERT INTO "contas" ("id", "nome") VALUES
	(1, 'INFOENG'),
	(2, 'CASA'),
	(3, 'BRADESCO'),
	(4, 'XP');
/*!40000 ALTER TABLE "contas" ENABLE KEYS */;

-- Copiando dados para a tabela constman.despesas: -1 rows
/*!40000 ALTER TABLE "despesas" DISABLE KEYS */;
INSERT INTO "despesas" ("id", "descricao", "tipoDespesaId", "dat", "vencimento", "valorCripto", "pago", "contaId") VALUES
	(1, 'Projeto arquiteura Dian', 1, '2021-10-15', '2021-10-15', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(2, 'Fusão terrenos Marcelo', 2, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(3, 'Fusão terrenos Cartório', 2, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(4, 'Projeto estrutural Sérgio Vaqueiro', 1, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(5, 'Levantamento topográfico Wladimir', 1, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(6, 'Taxa aprovação projeto Damha', 2, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f093f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(7, 'ART projeto arquitetura', 2, '2021-12-11', '2021-12-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(8, 'Escritura terrenos', 2, '2022-04-12', '2022-04-12', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(9, 'Fusão escritura terrenos', 2, '2022-04-13', '2022-04-13', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(10, 'Todeschini 1/10', 6, '2022-07-20', '2022-07-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(11, 'Todeschini 2/10', 6, '2022-07-20', '2022-08-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(12, 'Todeschini 3/10', 6, '2022-07-20', '2022-09-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(13, 'Todeschini 4/10', 6, '2022-07-20', '2022-10-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(14, 'Todeschini 5/10', 6, '2022-07-20', '2022-11-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(15, 'Todeschini 6/10', 6, '2022-07-20', '2022-12-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(16, 'Todeschini 7/10', 6, '2022-07-20', '2023-01-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(17, 'Todeschini 8/10', 6, '2022-07-20', '2023-02-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(18, 'Todeschini 9/10', 6, '2022-07-20', '2023-03-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(19, 'Todeschini 10/10', 6, '2022-07-20', '2023-04-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(20, 'Madeiras 7 Setembro', 20, '2022-06-07', '2022-06-07', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 2),
	(21, 'Acompanhamento Sérgio Vaqueiro 1/4', 1, '2022-06-20', '2022-06-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(22, 'Acompanhamento Sérgio Vaqueiro', 1, '2022-06-20', '2022-07-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(23, 'Acompanhamento Sérgio Vaqueiro', 1, '2022-06-20', '2022-08-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3fb63f3f3f3f3f3f3f3f3f, b'0', 0),
	(24, 'Acompanhamento Sérgio Vaqueiro', 1, '2022-06-20', '2022-09-20', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(25, 'Projeto Elétrico Jayme Telles', 1, '2022-06-20', '2022-07-11', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(26, 'Demarcação terreno Wladimir', 1, '2022-06-09', '2022-06-09', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(27, 'Ferro Costa Ferro', 21, '2022-06-13', '2022-06-13', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(28, 'Terraplanagem BM Locações', 4, '2022-06-14', '2022-06-14', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(29, 'Caixas de esgoto', 5, '2022-06-20', '2022-06-20', _binary 0x3f3f3f3f3f3f3f3f01003f6c3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(30, 'Locação Caçamba', 9, '2022-06-17', '2022-07-15', _binary 0x3f3f3f3f3f3f3f3f01003f0e3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0),
	(31, 'Casa C Areia Pedra', 5, '2022-06-21', '2022-06-28', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 2),
	(32, 'Basical cimento', 5, '2022-06-21', '2022-07-02', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(33, 'Concreto brocas Concrewall', 18, '2022-06-29', '2022-06-29', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(34, 'CLR Contrutora Pgto 1', 3, '2022-06-29', '2022-06-29', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(35, 'Aluguel prédio excluir', 31, '2022-06-29', '2022-06-29', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(36, 'Ferro arrimo', 21, '2022-07-04', '2022-07-05', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f433f3f3f3f3f553f3f3f3f, b'0', 0),
	(37, 'Concreto brocas Concrewall / Arrimo', 18, '2022-07-01', '2022-07-05', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', 0);
/*!40000 ALTER TABLE "despesas" ENABLE KEYS */;

-- Copiando dados para a tabela constman.receitas: -1 rows
/*!40000 ALTER TABLE "receitas" DISABLE KEYS */;
INSERT INTO "receitas" ("id", "descricao", "dat", "vencimento", "valorCripto", "recebido", "contaId") VALUES
	(1, 'Venda casa 1/6', '2022-05-10', '2022-05-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(2, 'Venda casa 2/6', '2022-05-10', '2022-08-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(3, 'Venda casa 3/6', '2022-05-10', '2022-11-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(4, 'Venda casa 4/6', '2022-05-10', '2023-02-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(5, 'Venda casa 5/6', '2022-05-10', '2023-05-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(6, 'Venda casa 6/6', '2022-05-10', '2023-08-10', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f123f3f3f3f3f3f3f3f, b'0', NULL),
	(7, 'Venda loft 1/5', '2022-05-30', '2022-05-30', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(8, 'Venda loft 2/5', '2022-05-30', '2022-06-30', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 1),
	(9, 'Venda loft 3/5', '2022-05-30', '2022-07-30', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(10, 'Venda loft 4/5', '2022-05-30', '2022-08-30', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(11, 'Venda loft 5/5', '2022-05-30', '2022-09-30', _binary 0x3f3f3f3f3f3f3f3f01003f3f4d3f3f3f3f3f3f3f3f3f3f3f3f3f, b'0', NULL),
	(12, 'Aporte 1', '2021-10-01', '2021-10-01', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(13, 'Aporte 2', '2022-04-01', '2022-04-01', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f753f3f3f3f3f3f3f3f3f, b'1', 3),
	(15, 'Venda terra Phablo', '2022-06-14', '2022-06-14', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f, b'1', 3),
	(17, 'Muro arrimo Phablo', '2022-07-02', '2022-07-05', _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3fe43f3f3f3f3f3f3f3f3f3f, b'0', 0);
/*!40000 ALTER TABLE "receitas" ENABLE KEYS */;

-- Copiando dados para a tabela constman.tipos_despesas: -1 rows
/*!40000 ALTER TABLE "tipos_despesas" DISABLE KEYS */;
INSERT INTO "tipos_despesas" ("id", "descricao", "valorPrevisto") VALUES
	(1, 'Projetos', 37000),
	(2, 'Documentação', 20000),
	(3, 'M O Construtora', 700000),
	(4, 'Terraplanagem e brocas', 15000),
	(5, 'Materiais básicos', 133000),
	(6, 'Móveis planejados', 230000),
	(7, 'Materiais pintura', 55000),
	(8, 'Materiais elétricos', 30000),
	(9, 'Aluguel equipamentos ', 16000),
	(10, 'Calhas', 18000),
	(11, 'Lajes e escoras', 30000),
	(12, 'Materiais Hidráulicos ', 25000),
	(13, 'Piscina', 55000),
	(14, 'Revestimentos', 80000),
	(15, 'Mármores e Granitos', 50000),
	(16, 'Esquadrias de Alumínio', 90000),
	(17, 'Portas batentes e acessórios', 50000),
	(18, 'Concreto', 55000),
	(19, 'Blocos e tijolos', 35000),
	(20, 'Madeira e caixaria', 30000),
	(21, 'Ferragem', 60000),
	(22, 'Limpeza final', 6000),
	(23, 'Tubulação de ar', 8000),
	(24, 'Piso grama e pedras', 10000),
	(25, 'Peças iluminação', 30000),
	(26, 'Espelhos e box', 20000),
	(27, 'Puxadores', 5000),
	(28, 'Sonorização', 40000),
	(29, 'M O assentamento portas', 12000),
	(30, 'M O gesseiro e forro madeira', 100000),
	(31, 'Excluir', 0.01);
/*!40000 ALTER TABLE "tipos_despesas" ENABLE KEYS */;

-- Copiando dados para a tabela constman.transferencias: -1 rows
/*!40000 ALTER TABLE "transferencias" DISABLE KEYS */;
INSERT INTO "transferencias" ("id", "descricao", "dat", "contaIdDebito", "contaIdCredito", "valorCripto") VALUES
	(1, 'Aplicação receb casa 1/6', '2022-05-10', 1, 4, _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f),
	(2, 'Venda loft 1/5', '2022-05-30', 1, 3, _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f),
	(3, 'Tranf', '2022-06-07', 1, 2, _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f),
	(4, 'Trans', '2022-06-13', 1, 3, _binary 0x3f3f3f3f3f3f3f3f01003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f);
/*!40000 ALTER TABLE "transferencias" ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
