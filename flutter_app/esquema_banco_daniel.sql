DROP SCHEMA `certeira`;

CREATE SCHEMA `certeira` DEFAULT CHARACTER SET utf8 ;

-- Tabelas de localização
CREATE TABLE certeira.Estado (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  estado VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
);

CREATE TABLE certeira.Cidade (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  cidade VARCHAR(100) NOT NULL,
  codigoEstado INT NOT NULL,
  ibge VARCHAR(7),
  FOREIGN KEY (codigoEstado) REFERENCES Estado(codigo)
);

CREATE TABLE certeira.Bairro (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  bairro VARCHAR(100) NOT NULL,
);

CREATE TABLE certeira.Rua (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(100) NOT NULL,
);

CREATE TABLE certeira.Endereco (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  codigoRua  INT NOT NULL,
  numero VARCHAR(6),
  codigoBairro INT NOT NULL,
  codigoCidade INT NOT NULL,
  cep VARCHAR(10),
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
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SÃO PAULO', 1, '3550308', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('CAMPINAS', 1, '3509502', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('RIBEIRÃO PRETO', 1, '3543402', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SOROCABA', 1, '3552205', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SANTO ANDRÉ', 1, '3547809', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('SÃO JOSÉ DOS CAMPOS', 1, '3549904', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('PRESIDENTE PRUDENTE', 1, '3541406', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('BAURU', 1, '3506002', NOW());
INSERT INTO certeira.Cidade (cidade, codigoEstado, ibge, dataCadastro) VALUES ('JUNDIAÍ', 1, '3525904', NOW());

INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('CENTRO', now());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('VILA NOVA', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('JARDIM DAS FLORES', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('PARQUE SÃO JOSÉ', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('VILA INDUSTRIAL', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('RESIDENCIAL AQUARIUS', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('SÍTIO CERCADO', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('IPIRANGA', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('JARDIM LARANJEIRAS', NOW());
INSERT INTO certeira.Bairro (bairro, dataCadastro) VALUES ('VILA ITAPURA', NOW());

INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('R. BENEDITO PEDRO RAIMUNDO', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. DR. PEDRO CAMARINHA', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. DR. CYRO DE MELLO CAMARINHA', now());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('RUA AUGUSTA', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. BRIGADEIRO FARIA LIMA', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('RUA OSCAR FREIRE', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. ENGENHEIRO LUÍS CARLOS BERRINI', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('RUA HADDAD', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('RUA DA CONSOLAÇÃO', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. SÃO JOÃO', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('RUA VERGUEIRO', NOW());
INSERT INTO certeira.Rua (rua, dataCadastro) VALUES ('AV. NOVE DE JULHO', NOW());

INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (1, '852', 1, 1, '18910038', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (2, '205', 2, 1, '18900082', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (3, '756', 2, 1, '18900073', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (4, '300', 3, 2, '05429000', now(), null);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (5, '410', 3, 2, '05430001', NOW(), NULL);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (6, '112', 4, 3, '01001000', NOW(), NULL);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (7, '999', 4, 4, '14800100', NOW(), NULL);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (8, '530', 5, 5, '13010000', NOW(), NULL);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (9, '77', 5, 6, '18010000', NOW(), NULL);
INSERT INTO certeira.Endereco (codigoRua, numero, codigoBairro, codigoCidade, cep, dataCadastro, dataDesativado) VALUES (10, '185', 6, 7, '19010000', NOW(), NULL);

INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('SALLES VISTORIAS AUTOMOTIVAS LTDA', '3 VISAO SANTA CRUZ DO RIO PARDO', '60808249000150', '3022017', 1, now(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('ALFA SERVIÇOS VEICULARES LTDA', 'ALFA VISTORIAS SÃO PAULO', '12345678000190', '1002001', 2, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('BETA LAUDOS AUTOMOTIVOS LTDA', 'BETA LAUDOS CAMPINAS', '98765432000177', '1003002', 3, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('GAMMA INSPEÇÕES TÉCNICAS ME', 'GAMMA CHECKUP VEICULAR', '23456789000166', '1004003', 4, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('DELTA VISTORIAS AUTOMOTIVAS EIRELI', 'DELTA VISTORIA ARARAQUARA', '34567891000155', '1005004', 5, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('OMEGA LAUDOS TÉCNICOS LTDA', 'OMEGA PERÍCIAS VEICULARES', '45678912000144', '1006005', 6, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('INSPECAR SERVIÇOS ESPECIALIZADOS LTDA', 'INSPECAR SOROCABA', '56789123000133', '1007006', 7, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('MAXAUTO ANÁLISE VEICULAR ME', 'MAXAUTO VISTORIAS', '67891234000122', '1008007', 8, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('CHECKSAFE PERÍCIAS AUTOMOTIVAS EIRELI', 'CHECKSAFE GUARULHOS', '78912345000111', '1009008', 9, NOW(), NULL);
INSERT INTO certeira.Empresa (razao, fantasia, cnpj, im, codigoEndereco, dataCadastro, dataDesativado) VALUES ('VALIDCAR TECNOLOGIA EM VISTORIAS LTDA', 'VALIDCAR RIBEIRÃO PRETO', '89013456000100', '1010009', 10, NOW(), NULL);

INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('DANIEL PAIVA SALLES', 'danielpaivasalles@gmail.com', '$2y$12$26C4YyKQEEwoMu5/POM9b.Qs5OWGQyh67.dS7KW6qg4n0.XJ4ldei', 1, now(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('ANESIO EVARISTO SALLES', 'anesiosalles@gmail.com', '$2y$12$Y9HaVLSMeBzviLGiisSiR.L/T3x/dtfatwfYivMU1yFPde5FsSsBa', 2, now(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('CARLA MENEZES SOUZA', 'carlasouza@gmail.com', '$2y$12$L3fHJduU1RGm57oFpNqNWeNw9nXPZV1KzoqzKtxA3BdBpP5ay2iBe', 3, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('RAFAEL MOURA LIMA', 'rafaelmoura@gmail.com', '$2y$12$yUt1XtPqUo5qkqZH9a8F9OeJgFo3f5Nfz.x4QwP0E/TG5UXzPCE6G', 4, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('LUCAS SILVA RIBEIRO', 'lucas.ribeiro@gmail.com', '$2y$12$kGn0Kzp0ROArdkkAwPuU8.fCg.yG2D/OA9/OYduIvsh3ONvQ8bAE6', 5, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('FERNANDA ARAÚJO MARTINS', 'fernanda.araujo@gmail.com', '$2y$12$s6sFX5RQTAHiXaa/7/Yq2.OeMcdCHKhvLPS0ZkWsejbpYxKSlZbT2', 6, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('TIAGO HENRIQUE OLIVEIRA', 'tiagohenrique@gmail.com', '$2y$12$0RnQKR.X3LZ1guLaEdX2qOMZw1XqGVuT5n.nkjkRmU8DEcOa4D3Ey', 7, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('JULIANA CASTRO NEVES', 'juliana.neves@gmail.com', '$2y$12$U1yxuBOKX2.VgRcFSklfgeKAvFo2vdXAoPU7nZ1U9EtJ/T8a.Z1nC', 8, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('MARCOS ANTONIO SOUZA', 'marcossouza@gmail.com', '$2y$12$45yYPO.ZqAvoC6XW7E3WRu2o4KDs2c6vDPkqM5TuTWxljox5UhLe2', 9, NOW(), NULL);
INSERT INTO certeira.Empregado (nome, email, senha, codigoEndereco, dataCadastro, dataDesativado) VALUES ('PRISCILA ANDRADE MELO', 'priscila.melo@gmail.com', '$2y$12$Z8aFyP6tShmuUxgXe7G4kOBB3n1oU5K2Oa98ZB5UzNqV1Ux2AD.RG', 10, NOW(), NULL);

INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 1, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 2, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 3, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 4, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 5, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 6, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 7, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 8, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 9, now(), null);
INSERT INTO certeira.Funcionario (codigoEmpresa, codigoEmpregado, dataCadastro, dataDesativado) VALUES (1, 10, now(), null);

INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('GABRIEL APARECIDO SALLES', 'SALLES', '38816815825', '416848525', 1, 'gabrielsallesbw@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('MARIA HELENA RODRIGUES', 'MARIA R.', '42158936710', '298364785', 2, 'maria.rodrigues@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('JOÃO VITOR ALMEIDA', 'JOAO V.', '51789326451', '487951362', 3, 'joao.almeida@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('CAROLINA MOURA LIMA', 'CAROL M.', '69875124985', '332145678', 4, 'carol.moura@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('FERNANDO LOPES MARTINS', 'FER LOPES', '85214796300', '104859326', 5, 'fernando.lopes@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('ANA PAULA SOARES', 'ANA P.', '75968412300', '569841237', 6, 'ana.soares@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('RICARDO AUGUSTO NEVES', 'RIC NEVES', '31478596244', '284175396', 7, 'ricardo.neves@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('LARISSA ANDRADE MENEZES', 'LARI', '28479513658', '108745293', 8, 'larissa.andrade@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('PAULO HENRIQUE FREITAS', 'PAULINHO', '38479125633', '478563214', 9, 'paulo.freitas@gmail.com', NULL, 0.00, now(), null);
INSERT INTO certeira.Cliente (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, codigoEndereco, email, senha, desconto, dataCadastro, dataDesativado) VALUES ('JULIANA CASTRO VIEIRA', 'JU VIEIRA', '12986475901', '305894176', 10, 'juliana.vieira@gmail.com', NULL, 0.00, now(), null);

INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('CIA DE SANEAMENTO BASICO DO ESTADO DE SÃO PAULO', 'SABESP', '43776517000180', '109091792118', NULL, 4, NULL, now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('COMPANHIA PAULISTA DE FORÇA E LUZ', 'CPFL', '01478523000165', '123456789000', NULL, 5, NULL, now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('NET SERVIÇOS DE COMUNICAÇÃO S.A.', 'CLARO NET', '33456789000112', '987654321123', NULL, 6, 'contato@claronet.com.br', now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('TELEFÔNICA BRASIL S.A.', 'VIVO', '02558157000162', '102938475601', NULL, 7, 'atendimento@vivo.com.br', now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('DISTRIBUIDORA DE PEÇAS AUTOMOTIVAS LTDA', 'AUTOPECAS BRASIL', '45678912000177', '203948576102', NULL, 8, 'comercial@autopecasbrasil.com.br', now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('LUBRIFICANTES E SERVIÇOS AUTOMOTIVOS S.A.', 'POSTO 3 IRMÃOS', '37584912000109', '847362519843', NULL, 9, NULL, now(), null);
INSERT INTO certeira.Fornecedor (nomeRazao, apelidoFantasia, cpfCNPJ, rgIE, im, codigoEndereco, email, dataCadastro, dataDesativado) VALUES ('INFORTECH SOLUÇÕES EM TECNOLOGIA LTDA', 'INFORTECH', '48930156000120', '657483920198', NULL, 10, 'suporte@infotech.com.br', now(), null);

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
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (2, 2, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (3, 3, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (4, 4, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (5, 5, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (6, 6, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (7, 7, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (8, 8, now());
INSERT INTO certeira.Servico (codigoCliente, codigoFuncionario, dataCadastro) VALUES (9, 9, now());

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

