-- DROP SCHEMA `certeira`;

-- CREATE SCHEMA `certeira` DEFAULT CHARACTER SET utf8 ;

-- Tabelas de localização
CREATE TABLE Estado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  estado VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Cidade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  cidade VARCHAR(100) NOT NULL,
  codigoEstado INT NOT NULL,
  ibge VARCHAR(7),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEstado) REFERENCES Estado(codigo)
);

CREATE TABLE Bairro (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  bairro VARCHAR(100) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Rua (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(100) NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Endereco (
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
CREATE TABLE Empresa (
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

CREATE TABLE Empregado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100),
  senha VARCHAR(100),
  codigoEndereco INT,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  dataDesativado DATETIME,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

CREATE TABLE Funcionario (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoEmpresa INT NOT NULL,
  codigoEmpregado INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEmpresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigoEmpregado) REFERENCES Empregado(codigo)
);

-- Clientes e fornecedores
CREATE TABLE Cliente (
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
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

CREATE TABLE Fornecedor (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nomeRazao VARCHAR(150),
  apelidoFantasia VARCHAR(150),
  cpfCNPJ VARCHAR(14),
  rgIE VARCHAR(15),
  im VARCHAR(10),
  codigoEndereco INT,
  email VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEndereco) REFERENCES Endereco(codigo)
);

-- Serviços e ordens
CREATE TABLE Atividade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  atividade VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Preco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  preco DECIMAL(10,2),
  codigoEmpresa INT NOT NULL,
  codigoAtividade INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoEmpresa) REFERENCES Empresa(codigo),
  FOREIGN KEY (codigoAtividade) REFERENCES Atividade(codigo)
);

CREATE TABLE Servico (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoCliente INT NOT NULL,
  codigoFuncionario INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo),
  FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE ServicoItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoPreco INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoPreco) REFERENCES Preco(codigo)
);

-- Financeiro: receber
CREATE TABLE Pagamento (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  pagamento VARCHAR(100),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Receber (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoServico INT NOT NULL,
  valorTotal DECIMAL(10,2),
  valorPago DECIMAL(10,2),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoServico) REFERENCES Servico(codigo)
);

CREATE TABLE ReceberItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoReceber INT NOT NULL,
  valorPago DECIMAL(10,2),
  codigoPagamento INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoReceber) REFERENCES Receber(codigo),
  FOREIGN KEY (codigoPagamento) REFERENCES Pagamento(codigo)
);

-- Financeiro: pagar
CREATE TABLE Despesa (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoFornecedor INT NOT NULL,
  codigoFuncionario INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoFornecedor) REFERENCES Fornecedor(codigo),
  FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigo)
);

CREATE TABLE Pagar (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoDespesa INT NOT NULL,
  valorTotal DECIMAL(10,2),
  valorPago DECIMAL(10,2),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoDespesa) REFERENCES Despesa(codigo)
);

CREATE TABLE PagarItem (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoPagar INT NOT NULL,
  valorPago DECIMAL(10,2),
  codigoPagamento INT NOT NULL,
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codigoPagar) REFERENCES Pagar(codigo),
  FOREIGN KEY (codigoPagamento) REFERENCES Pagamento(codigo)
);

-- INSERT
INSERT INTO Estado (estado, uf, dataCadastro) VALUES ('SÃO PAULO', 'SP', now());

INSERT INTO Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SANTA CRUZ DO RIO PARDO', 1, '3546405', now());
INSERT INTO Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SÃO PAULO', 1, '35', now());

INSERT INTO Bairro (bairro, dataCadastro) VALUES ('JARDIM SANTANA 1', now());
INSERT INTO Bairro (bairro, dataCadastro) VALUES ('CENTRO', now());
INSERT INTO Bairro (bairro, dataCadastro) VALUES ('PINHEIROS', now());

INSERT INTO Rua (rua, dataCadastro) VALUES ('R. BENEDITO PEDRO RAIMUNDO', now());
INSERT INTO Rua (rua, dataCadastro) VALUES ('AV. DR. PEDRO CAMARINHA', now());
INSERT INTO Rua (rua, dataCadastro) VALUES ('AV. DR. CYRO DE MELLO CAMARINHA', now());
INSERT INTO Rua (rua, dataCadastro) VALUES ('R. COSTA CARVALHO', now());

INSERT INTO Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro) VALUES (1, '852', 1, 1, '18910038', now());
INSERT INTO Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro) VALUES (2, '205', 2, 1, '18900082', now());
INSERT INTO Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro) VALUES (3, '756', 2, 1, '18900073', now());
INSERT INTO Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro) VALUES (4, '300', 3, 2, '05429000', now());

INSERT INTO Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('SALLES VISTORIAS AUTOMOTIVAS LTDA', '3 VISAO SANTA CRUZ DO RIO PARDO', '60808249000150', '3022017', 2, now(), NULL);

INSERT INTO Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('DANIEL PAIVA SALLES', 'danielpaivasalles@gmail.com', '$2y$12$26C4YyKQEEwoMu5/POM9b.Qs5OWGQyh67.dS7KW6qg4n0.XJ4ldei', 3, now(), NULL);
INSERT INTO Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('ANESIO EVARISTO SALLES', 'anesiosalles@gmail.com', '$2y$12$Y9HaVLSMeBzviLGiisSiR.L/T3x/dtfatwfYivMU1yFPde5FsSsBa', 3, now(), NULL);

INSERT INTO Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro) VALUES (1, 1, now());
INSERT INTO Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro) VALUES (1, 2, now());

INSERT INTO Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro) VALUES ('GABRIEL APARECIDO SALLES', 'SALLES', '38816815825', '416848525', 1, 'gabrielsallesbw@gmail.com', NULL, 0.00, now());

INSERT INTO Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro) VALUES ('CIA DE SANEAMENTO BASICO DO ESTADO DE SÃO PAULO', 'SABESP', '43776517000180', '109091792118', NULL, 4, NULL, now());

INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA TRANSFERÊNCIA CARRO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA CAUTELAR CARRO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA DESBLOQUEIO CARRO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA COLECIONADOR CARRO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA TRANSFERÊNCIA MOTO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA CAUTELAR MOTO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA DESBLOQUEIO MOTO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA COLECIONADOR MOTO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA TRANSFERÊNCIA REBOQUE', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA CAUTELAR REBOQUE', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA DESBLOQUEIO REBOQUE', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA COLECIONADOR REBOQUE', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA TRANSFERÊNCIA CAMINHÃO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA CAUTELAR CAMINHÃO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA DESBLOQUEIO CAMINHÃO', now());
INSERT INTO Atividade (atividade, dataCadastro) VALUES ('VISTORIA COLECIONADOR CAMINHÃO', now());

INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (120.00, 1, 1, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (300.00, 1, 1, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (170.00, 1, 1, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (300.00, 1, 1, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (100.00, 1, 2, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (250.00, 1, 2, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (150.00, 1, 2, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (250.00, 1, 2, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (100.00, 1, 3, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (250.00, 1, 3, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (150.00, 1, 3, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (250.00, 1, 3, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (240.00, 1, 4, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (600.00, 1, 4, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (290.00, 1, 4, now());
INSERT INTO Preco (preco, codigoEmpresa, codigoAtividade, dataCadastro) VALUES (600.00, 1, 4, now());

INSERT INTO Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (1, 1, now());

INSERT INTO ServicoItem (codigoPreco, dataCadastro) VALUES (1, now());
INSERT INTO ServicoItem (codigoPreco, dataCadastro) VALUES (5, now());
INSERT INTO ServicoItem (codigoPreco, dataCadastro) VALUES (9, now());

INSERT INTO Pagamento (pagamento, dataCadastro) VALUES ('DINHEIRO', now());
INSERT INTO Pagamento (pagamento, dataCadastro) VALUES ('PIX', now());
INSERT INTO Pagamento (pagamento, dataCadastro) VALUES ('CRÉDITO', now());
INSERT INTO Pagamento (pagamento, dataCadastro) VALUES ('DÉBITO', now());

INSERT INTO Receber (codigoServico, valorTotal, valorPago, dataCadastro) VALUES (1, 320.00, 120.00, now());

INSERT INTO ReceberItem (codigoReceber, valorPago, codigoPagamento, dataCadastro) VALUES (1, 120.00, 1, now());

INSERT INTO Despesa (codigoFornecedor, codigoFuncionario, dataCadastro) VALUES (1, 1, now());

INSERT INTO Pagar (codigoDespesa, valorTotal, valorPago, dataCadastro) VALUES (1, 134.39, 134.39, now());

INSERT INTO PagarItem (codigoPagar, valorPago, codigoPagamento, dataCadastro) VALUES (1, 134.39, 1, now());

