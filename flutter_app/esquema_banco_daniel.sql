DROP SCHEMA `certeira`;

CREATE SCHEMA `certeira` DEFAULT CHARACTER SET utf8 ;

-- Tabelas de localização
CREATE TABLE certeira.Estado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  estado VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certeira.Cidade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  cidade VARCHAR(100) NOT NULL,
  codigoEstado INT NOT NULL,
  ibge VARCHAR(7),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEstado) REFERENCES Estado(codigo)
);

CREATE TABLE certeira.Bairro (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  bairro VARCHAR(100) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certeira.Rua (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(100) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certeira.Endereco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoRua  INT NOT NULL,
  numero VARCHAR(6),
  codigoBairro INT NOT NULL,
  codigoCidade INT NOT NULL,
  cep VARCHAR(10),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoBairro) REFERENCES Bairro(codigo),
  FOREIGN KEY (codigoCidade) REFERENCES Cidade(codigo),
  FOREIGN KEY (codigoRua) REFERENCES Rua(codigo)
);

-- Empresa e pessoas
CREATE TABLE certeira.Empresa (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  razao VARCHAR(150),
  fantasia VARCHAR(150),
  cnpj VARCHAR(14),
  im VARCHAR(10),
  codigoEndereco INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

CREATE TABLE certeira.Empregado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100),
  senha VARCHAR(100),
  codigoEndereco INT,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

CREATE TABLE certeira.Funcionario (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoEmpresa INT NOT NULL,
  codigoEmpregado INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEmpresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigoEmpregado) REFERENCES Empregado(codigo)
);

-- Clientes e fornecedores
CREATE TABLE certeira.Cliente (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nomeRazao VARCHAR(150),
  apelidoFantasia VARCHAR(150),
  cpfCNPJ VARCHAR(14),
  rgIE VARCHAR(15),
  codigoEndereco INT,
  email VARCHAR(100),
  senha VARCHAR(100),
  desconto DECIMAL(10,2) DEFAULT 0.00,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

CREATE TABLE certeira.Fornecedor (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nomeRazao VARCHAR(150),
  apelidoFantasia VARCHAR(150),
  cpfCNPJ VARCHAR(14),
  rgIE VARCHAR(15),
  im VARCHAR(10),
  codigoEndereco INT,
  email VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

-- Serviços e ordens
CREATE TABLE certeira.Atividade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  atividade VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certeira.Preco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  preco DECIMAL(10,2),
  codigoEmpresa INT NOT NULL,
  codigoAtividade INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEmpresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigoAtividade) REFERENCES Atividade(codigo)
);

CREATE TABLE certeira.Servico (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoCliente INT NOT NULL,
  codigoFuncionario INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo),
  FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE certeira.ServicoItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoPreco INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoPreco) REFERENCES Preco(codigo)
);

-- Financeiro: receber
CREATE TABLE certeira.Pagamento (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  pagamento VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certeira.Receber (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoServico INT NOT NULL,
  valorTotal DECIMAL(10,2),
  valorPago DECIMAL(10,2),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoServico) REFERENCES Servico(codigo)
);

CREATE TABLE certeira.ReceberItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoReceber INT NOT NULL,
  valorPago DECIMAL(10,2),
  codigoPagamento INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoReceber) REFERENCES Receber(codigo),
  FOREIGN KEY (codigoPagamento) REFERENCES Pagamento(codigo)
);

-- Financeiro: pagar
CREATE TABLE certeira.Despesa (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoFornecedor INT NOT NULL,
  codigoFuncionario INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoFornecedor) REFERENCES Fornecedor(codigo),
  FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE certeira.Pagar (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoDespesa INT NOT NULL,
  valorTotal DECIMAL(10,2),
  valorPago DECIMAL(10,2),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoDespesa) REFERENCES Despesa(codigo)
);

CREATE TABLE certeira.PagarItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoPagar INT NOT NULL,
  valorPago DECIMAL(10,2),
  codigoPagamento INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoPagar) REFERENCES Pagar(codigo),
  FOREIGN KEY (codigoPagamento) REFERENCES Pagamento(codigo)
);

-- INSERT
INSERT INTO certeira.Estado (estado, uf, dataCadastro) VALUES ('SÃO PAULO', 'SP', now());

INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SANTA CRUZ DO RIO PARDO', 1, '3546405', now());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SÃO PAULO', 1, '35', now());

INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('JARDIM SANTANA 1', now());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('CENTRO', now());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('PINHEIROS', now());

INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('R. BENEDITO PEDRO RAIMUNDO', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. DR. PEDRO CAMARINHA', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. DR. CYRO DE MELLO CAMARINHA', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('R. COSTA CARVALHO', now());

INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (1, '852', 1, 1, '18910038', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (2, '205', 2, 1, '18900082', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (3, '756', 2, 1, '18900073', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (4, '300', 3, 2, '05429000', now(), null);

INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('SALLES VISTORIAS AUTOMOTIVAS LTDA', '3 VISAO SANTA CRUZ DO RIO PARDO', '60808249000150', '3022017', 2, now(), NULL);

INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('DANIEL PAIVA SALLES', 'danielpaivasalles@gmail.com', '$2y$12$26C4YyKQEEwoMu5/POM9b.Qs5OWGQyh67.dS7KW6qg4n0.XJ4ldei', 3, now(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('ANESIO EVARISTO SALLES', 'anesiosalles@gmail.com', '$2y$12$Y9HaVLSMeBzviLGiisSiR.L/T3x/dtfatwfYivMU1yFPde5FsSsBa', 3, now(), NULL);

INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 1, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 2, now(), null);

INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('GABRIEL APARECIDO SALLES', 'SALLES', '38816815825', '416848525', 1, 'gabrielsallesbw@gmail.com', NULL, 0.00, now(), null);

INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('CIA DE SANEAMENTO BASICO DO ESTADO DE SÃO PAULO', 'SABESP', '43776517000180', '109091792118', NULL, 4, NULL, now(), null);

INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA TRANSFERÊNCIA CARRO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA CAUTELAR CARRO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA DESBLOQUEIO CARRO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA COLECIONADOR CARRO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA TRANSFERÊNCIA MOTO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA CAUTELAR MOTO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA DESBLOQUEIO MOTO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA COLECIONADOR MOTO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA TRANSFERÊNCIA REBOQUE', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA CAUTELAR REBOQUE', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA DESBLOQUEIO REBOQUE', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA COLECIONADOR REBOQUE', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA TRANSFERÊNCIA CAMINHÃO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA CAUTELAR CAMINHÃO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA DESBLOQUEIO CAMINHÃO', now(), null);
INSERT INTO certeira.Atividade (atividade, dataCadastro, dataDesativado) VALUES ('VISTORIA COLECIONADOR CAMINHÃO', now(), null);

INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (120.00, 1, 1, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (300.00, 1, 1, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (170.00, 1, 1, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (300.00, 1, 1, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (100.00, 1, 2, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (250.00, 1, 2, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (150.00, 1, 2, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (250.00, 1, 2, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (100.00, 1, 3, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (250.00, 1, 3, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (150.00, 1, 3, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (250.00, 1, 3, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (240.00, 1, 4, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (600.00, 1, 4, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (290.00, 1, 4, now(), null);
INSERT INTO certeira.Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro, dataDesativado) VALUES (600.00, 1, 4, now(), null);

INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (1, 1, now());

INSERT INTO certeira.ServicoItem (codigoPreco, dataCadastro) VALUES (1, now());
INSERT INTO certeira.ServicoItem (codigoPreco, dataCadastro) VALUES (5, now());
INSERT INTO certeira.ServicoItem (codigoPreco, dataCadastro) VALUES (9, now());

INSERT INTO certeira.Pagamento (pagamento, dataCadastro) VALUES ('DINHEIRO', now());
INSERT INTO certeira.Pagamento (pagamento, dataCadastro) VALUES ('PIX', now());
INSERT INTO certeira.Pagamento (pagamento, dataCadastro) VALUES ('CRÉDITO', now());
INSERT INTO certeira.Pagamento (pagamento, dataCadastro) VALUES ('DÉBITO', now());

INSERT INTO certeira.Receber (codigoServico, valorTotal, valorPago, dataCadastro) VALUES (1, 320.00, 120.00, now());

INSERT INTO certeira.ReceberItem (codigoReceber, valorPago, codigoPagamento, dataCadastro) VALUES (1, 120.00, 1, now());

INSERT INTO certeira.Despesa (codigoFornecedor, codigoFuncionario, dataCadastro) VALUES (1, 1, now());

INSERT INTO certeira.Pagar (codigoDespesa, valorTotal, valorPago, dataCadastro) VALUES (1, 134.39, 134.39, now());

INSERT INTO certeira.PagarItem (codigoPagar, valorPago, codigoPagamento, dataCadastro) VALUES (1, 134.39, 1, now());

