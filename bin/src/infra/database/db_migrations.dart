import 'dart:developer';

import 'package:mysql_client/mysql_client.dart';

import 'db_config.dart';

class DBMigrations {
  final DBConfig _dbConfig;
  DBMigrations(this._dbConfig);

  Future<bool> checkTables() async {
    // if (await _database()) return false;
    if (!await _usuarios()) return false;
    if (!await _configuracoes()) return false;
    if (!await _contas()) return false;
    if (!await _transferencias()) return false;
    if (!await _receitas()) return false;
    if (!await _tiposDespesas()) return false;
    if (!await _despesas()) return false;
    return true;
  }

  Future<bool> _usuarios() async {
    try {
      print('>> Checking table "usuarios"');
      String query = 'USE constman;';
      await _dbConfig.execute(query);
      query = 'SHOW TABLES LIKE "usuarios";';
      IResultSet result = await _dbConfig.execute(query);
      if (result.rows.isEmpty) {
        query = 'CREATE TABLE IF NOT EXISTS `usuarios` (';
        query += '`id` INT NOT NULL AUTO_INCREMENT, ';
        query += '`nome` VARCHAR(255) NOT NULL, ';
        query += '`usuario` VARCHAR(255) NOT NULL, ';
        query += '`senha` VARCHAR(255) NOT NULL, ';
        query += '`nivel` INT NOT NULL DEFAULT 1, ';
        query += '`ativo` TINYINT NULL DEFAULT 1, ';
        query += '`tema` VARCHAR(50) NULL DEFAULT "LBlue", ';
        query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
        query +=
            '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
        query += 'PRIMARY KEY (`id`)) ';
        query += 'ENGINE = InnoDB;';
        await _dbConfig.execute(query);
      }
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "usuarios"');
      return false;
    }
  }

  Future<bool> _configuracoes() async {
    try {
      print('>> Checking table "configuracoes"');
      String query = 'USE constman;';
      await _dbConfig.execute(query);
      query = 'CREATE TABLE IF NOT EXISTS `configuracoes` (';
      query += '`constArea` FLOAT NULL DEFAULT 0, ';
      query += '`constValorPrevistoM2` FLOAT NULL DEFAULT 0, ';
      query += '`constUsarValorPrevisto` TINYINT NULL DEFAULT 1, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "configuracoes"');
      return false;
    }
  }

  Future<bool> _contas() async {
    try {
      print('>> Checking table "contas"');
      String query = 'CREATE TABLE IF NOT EXISTS `contas` (';
      query += '`id` INT NOT NULL AUTO_INCREMENT, ';
      query += '`nome` VARCHAR(255) NOT NULL, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
      query += 'PRIMARY KEY (`id`)) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "contas"');
      return false;
    }
  }

  Future<bool> _transferencias() async {
    try {
      print('>> Checking table "transferencias"');
      String query = 'CREATE TABLE IF NOT EXISTS `transferencias` (';
      query += '`id` INT NOT NULL AUTO_INCREMENT, ';
      query += '`descricao` VARCHAR(255) NOT NULL, ';
      query += '`dat` DATE NOT NULL, ';
      query += '`contaIdDebito` INT NOT NULL, ';
      query += '`contaIdCredito` INT NOT NULL, ';
      query += '`valor` FLOAT NOT NULL DEFAULT 0, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
      query += 'PRIMARY KEY (`id`)) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "transferencias"');
      return false;
    }
  }

  Future<bool> _receitas() async {
    try {
      print('>> Checking table "receitas"');
      String query = 'CREATE TABLE IF NOT EXISTS `receitas` (';
      query += '`id` INT NOT NULL AUTO_INCREMENT, ';
      query += '`descricao` VARCHAR(255) NOT NULL, ';
      query += '`dat` DATE NOT NULL, ';
      query += '`vencimento` DATE NOT NULL, ';
      query += '`valor` FLOAT NOT NULL DEFAULT 0, ';
      query += '`recebido` TINYINT NULL DEFAULT 1, ';
      query += '`contaId` INT NULL DEFAULT 0, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
      query += 'PRIMARY KEY (`id`)) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "receitas"');
      return false;
    }
  }

  Future<bool> _tiposDespesas() async {
    try {
      print('>> Checking table "tipos_despesas"');
      String query = 'CREATE TABLE IF NOT EXISTS `tipos_despesas` (';
      query += '`id` INT NOT NULL AUTO_INCREMENT, ';
      query += '`descricao` VARCHAR(255) NOT NULL, ';
      query += '`valorPrevisto` FLOAT NULL DEFAULT 0, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
      query += 'PRIMARY KEY (`id`)) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "tipos_despesas"');
      return false;
    }
  }

  Future<bool> _despesas() async {
    try {
      print('>> Checking table "despesas"');
      String query = 'CREATE TABLE IF NOT EXISTS `despesas` (';
      query += '`id` INT NOT NULL AUTO_INCREMENT, ';
      query += '`descricao` VARCHAR(255) NOT NULL, ';
      query += '`tipoDespesaId` INT NOT NULL, ';
      query += '`dat` DATE NOT NULL, ';
      query += '`vencimento` DATE NOT NULL, ';
      query += '`valor` FLOAT NOT NULL DEFAULT 0, ';
      query += '`pago` TINYINT NULL DEFAULT 1, ';
      query += '`contaId` INT NULL DEFAULT 0, ';
      query += '`dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP, ';
      query +=
          '`dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ';
      query += 'PRIMARY KEY (`id`)) ';
      query += 'ENGINE = InnoDB;';
      await _dbConfig.execute(query);
      return true;
    } catch (e) {
      print(e);
      log('[ERROR] Creating/Checking table "despesas"');
      return false;
    }
  }
}
