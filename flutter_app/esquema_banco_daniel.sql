-- DROP SCHEMA `certeira`;

-- CREATE SCHEMA `certeira` DEFAULT CHARACTER SET utf8 ;

-- Tabelas de localização
CREATE TABLE Estado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  estado VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Cidade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  cidade VARCHAR(100) NOT NULL,
  codigo_estado INT NOT NULL,
  ibge VARCHAR(7),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_estado) REFERENCES Estado(codigo)
);

CREATE TABLE Bairro (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  bairro VARCHAR(100) NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Rua (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(100) NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Endereco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_rua  INT NOT NULL,
  numero VARCHAR(6),
  codigo_bairro INT NOT NULL,
  codigo_cidade INT NOT NULL,
  cep VARCHAR(10),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_bairro) REFERENCES Bairro(codigo),
  FOREIGN KEY (codigo_cidade) REFERENCES Cidade(codigo),
  FOREIGN KEY (codigo_rua) REFERENCES Rua(codigo)
);

-- Empresa e pessoas
CREATE TABLE Empresa (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  razao VARCHAR(150),
  fantasia VARCHAR(150),
  cnpj VARCHAR(14),
  im VARCHAR(10),
  codigo_endereco INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_endereco) REFERENCES Endereco(codigo)
);

CREATE TABLE Empregado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100),
  senha VARCHAR(100),
  codigo_endereco INT,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  data_demissao DATETIME,
  FOREIGN KEY (codigo_endereco) REFERENCES Endereco(codigo)
);

CREATE TABLE Funcionario (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_empresa INT NOT NULL,
  codigo_empregado INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_empresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigo_empregado) REFERENCES Empregado(codigo)
);

-- Clientes e fornecedores
CREATE TABLE Cliente (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome_razao VARCHAR(150),
  apelido_fantasia VARCHAR(150),
  cpf_cnpj VARCHAR(14),
  rg_ie VARCHAR(15),
  codigo_endereco INT,
  email VARCHAR(100),
  senha VARCHAR(100),
  desconto DECIMAL(10,2) DEFAULT 0.00,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_endereco) REFERENCES Endereco(codigo)
);

CREATE TABLE Fornecedor (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome_razao VARCHAR(150),
  apelido_fantasia VARCHAR(150),
  cpf_cnpj VARCHAR(14),
  rg_ie VARCHAR(15),
  im VARCHAR(10),
  codigo_endereco INT,
  email VARCHAR(100),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_endereco) REFERENCES Endereco(codigo)
);

-- Serviços e ordens
CREATE TABLE Atividade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  atividade VARCHAR(100),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Preco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  preco DECIMAL(10,2),
  codigo_empresa INT NOT NULL,
  codigo_atividade INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_empresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigo_atividade) REFERENCES Atividade(codigo)
);

CREATE TABLE Servico (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_cliente INT NOT NULL,
  codigo_funcionario INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_cliente) REFERENCES Cliente(codigo),
  FOREIGN KEY (codigo_funcionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE ServicoItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_preco INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_preco) REFERENCES Preco(codigo)
);

-- Financeiro: receber
CREATE TABLE Pagamento (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  pagamento VARCHAR(100),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Receber (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_servico INT NOT NULL,
  valor_total DECIMAL(10,2),
  valor_pago DECIMAL(10,2),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_servico) REFERENCES Servico(codigo)
);

CREATE TABLE ReceberItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_receber INT NOT NULL,
  valor_pago DECIMAL(10,2),
  codigo_pagamento INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_receber) REFERENCES Receber(codigo),
  FOREIGN KEY (codigo_pagamento) REFERENCES Pagamento(codigo)
);

-- Financeiro: pagar
CREATE TABLE Despesa (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_fornecedor INT NOT NULL,
  codigo_funcionario INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_fornecedor) REFERENCES Fornecedor(codigo),
  FOREIGN KEY (codigo_funcionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE Pagar (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_despesa INT NOT NULL,
  valor_total DECIMAL(10,2),
  valor_pago DECIMAL(10,2),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_despesa) REFERENCES Despesa(codigo)
);

CREATE TABLE PagarItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigo_pagar INT NOT NULL,
  valor_pago DECIMAL(10,2),
  codigo_pagamento INT NOT NULL,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigo_pagar) REFERENCES Pagar(codigo),
  FOREIGN KEY (codigo_pagamento) REFERENCES Pagamento(codigo)
);

-- INSERT
INSERT INTO Estado (estado, uf, data_cadastro) VALUES ('SÃO PAULO', 'SP', now());

INSERT INTO Cidade (cidade, codigo_estado, ibge, data_cadastro) VALUES ('SANTA CRUZ DO RIO PARDO', 1, '3546405', now());
INSERT INTO Cidade (cidade, codigo_estado, ibge, data_cadastro) VALUES ('SÃO PAULO', 1, '35', now());

INSERT INTO Bairro (bairro, data_cadastro) VALUES ('JARDIM SANTANA 1', now());
INSERT INTO Bairro (bairro, data_cadastro) VALUES ('CENTRO', now());
INSERT INTO Bairro (bairro, data_cadastro) VALUES ('PINHEIROS', now());

INSERT INTO Rua (rua, data_cadastro) VALUES ('R. BENEDITO PEDRO RAIMUNDO', now());
INSERT INTO Rua (rua, data_cadastro) VALUES ('AV. DR. PEDRO CAMARINHA', now());
INSERT INTO Rua (rua, data_cadastro) VALUES ('AV. DR. CYRO DE MELLO CAMARINHA', now());
INSERT INTO Rua (rua, data_cadastro) VALUES ('R. COSTA CARVALHO', now());

INSERT INTO Endereco (codigo_rua, numero, codigo_bairro, codigo_cidade, cep, data_cadastro) VALUES (1, '852', 1, 1, '18910038', now());
INSERT INTO Endereco (codigo_rua, numero, codigo_bairro, codigo_cidade, cep, data_cadastro) VALUES (2, '205', 2, 1, '18900082', now());
INSERT INTO Endereco (codigo_rua, numero, codigo_bairro, codigo_cidade, cep, data_cadastro) VALUES (3, '756', 2, 1, '18900073', now());
INSERT INTO Endereco (codigo_rua, numero, codigo_bairro, codigo_cidade, cep, data_cadastro) VALUES (4, '300', 3, 2, '05429000', now());

INSERT INTO Empresa (razao, fantasia, cnpj, im, codigo_endereco, data_cadastro) VALUES ('SALLES VISTORIAS AUTOMOTIVAS LTDA', '3 VISAO SANTA CRUZ DO RIO PARDO', '60808249000150', '3022017', 2, now());

INSERT INTO Empregado (nome, email, senha, codigo_endereco, data_cadastro, data_demissao) VALUES ('DANIEL PAIVA SALLES', 'danielpaivasalles@gmail.com', '$2y$12$26C4YyKQEEwoMu5/POM9b.Qs5OWGQyh67.dS7KW6qg4n0.XJ4ldei', 3, now(), NULL);
INSERT INTO Empregado (nome, email, senha, codigo_endereco, data_cadastro, data_demissao) VALUES ('ANESIO EVARISTO SALLES', 'anesiosalles@gmail.com', '$2y$12$Y9HaVLSMeBzviLGiisSiR.L/T3x/dtfatwfYivMU1yFPde5FsSsBa', 3, now(), NULL);

INSERT INTO Funcionario (codigo_empresa, codigo_empregado, data_cadastro) VALUES (1, 1, now());
INSERT INTO Funcionario (codigo_empresa, codigo_empregado, data_cadastro) VALUES (1, 2, now());

INSERT INTO Cliente (nome_razao, apelido_fantasia, cpf_cnpj, rg_ie, codigo_endereco, email, senha, desconto, data_cadastro) VALUES ('GABRIEL APARECIDO SALLES', 'SALLES', '38816815825', '416848525', 1, 'gabrielsallesbw@gmail.com', NULL, 0.00, now());

INSERT INTO Fornecedor (nome_razao, apelido_fantasia, cpf_cnpj, rg_ie, im, codigo_endereco, email, data_cadastro) VALUES ('CIA DE SANEAMENTO BASICO DO ESTADO DE SÃO PAULO', 'SABESP', '43776517000180', '109091792118', NULL, 4, NULL, now());

INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA TRANSFERÊNCIA CARRO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA CAUTELAR CARRO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA DESBLOQUEIO CARRO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA COLECIONADOR CARRO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA TRANSFERÊNCIA MOTO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA CAUTELAR MOTO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA DESBLOQUEIO MOTO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA COLECIONADOR MOTO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA TRANSFERÊNCIA REBOQUE', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA CAUTELAR REBOQUE', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA DESBLOQUEIO REBOQUE', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA COLECIONADOR REBOQUE', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA TRANSFERÊNCIA CAMINHÃO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA CAUTELAR CAMINHÃO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA DESBLOQUEIO CAMINHÃO', now());
INSERT INTO Atividade (atividade, data_cadastro) VALUES ('VISTORIA COLECIONADOR CAMINHÃO', now());

INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (120.00, 1, 1, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (300.00, 1, 1, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (170.00, 1, 1, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (300.00, 1, 1, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (100.00, 1, 2, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (250.00, 1, 2, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (150.00, 1, 2, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (250.00, 1, 2, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (100.00, 1, 3, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (250.00, 1, 3, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (150.00, 1, 3, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (250.00, 1, 3, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (240.00, 1, 4, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (600.00, 1, 4, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (290.00, 1, 4, now());
INSERT INTO Preco (preco, codigo_empresa, codigo_atividade, data_cadastro) VALUES (600.00, 1, 4, now());

INSERT INTO Servico (codigo_cliente, codigo_funcionario, data_cadastro) VALUES (1, 1, now());

INSERT INTO ServicoItem (codigo_preco, data_cadastro) VALUES (1, now());
INSERT INTO ServicoItem (codigo_preco, data_cadastro) VALUES (5, now());
INSERT INTO ServicoItem (codigo_preco, data_cadastro) VALUES (9, now());

INSERT INTO Pagamento (pagamento, data_cadastro) VALUES ('DINHEIRO', now());
INSERT INTO Pagamento (pagamento, data_cadastro) VALUES ('PIX', now());
INSERT INTO Pagamento (pagamento, data_cadastro) VALUES ('CRÉDITO', now());
INSERT INTO Pagamento (pagamento, data_cadastro) VALUES ('DÉBITO', now());

INSERT INTO Receber (codigo_servico, valor_total, valor_pago, data_cadastro) VALUES (1, 320.00, 120.00, now());

INSERT INTO ReceberItem (codigo_receber, valor_pago, codigo_pagamento, data_cadastro) VALUES (1, 120.00, 1, now());

INSERT INTO Despesa (codigo_fornecedor, codigo_funcionario, data_cadastro) VALUES (1, 1, now());

INSERT INTO Pagar (codigo_despesa, valor_total, valor_pago, data_cadastro) VALUES (1, 134.39, 134.39, now());

INSERT INTO PagarItem (codigo_pagar, valor_pago, codigo_pagamento, data_cadastro) VALUES (1, 134.39, 1, now());

