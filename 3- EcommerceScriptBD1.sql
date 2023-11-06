-- Integrantes: (Grupo M)
-- Emile Vargas Bordin (23111271-5)
-- Felipe Souza Flores (23111293-9)
-- Gabriel Dorneles Rebello (23111573-4)

-- O que mudou?
-- Foram retiradas as tabelas ditas excedentes nos comentários do modelo relacional e transformadas em tipos ou atributos.
-- Foram criadas PKs não existentes na passagem para modelo ER, que facilitam a inserção e consulta de dados.
-- Foi feito o uso de checks para permitir valores específicos em alguns atributos, funcionando como o tipo ENUM.
-- Foi feito o uso de sequences e triggers para atribuição de valores nos ids, pela falta da possibilidade de usar auto_increment. (talvez em um BD grande possa ser uma má prática, mas aqui se encaixa)

CREATE TYPE ENDERECO AS OBJECT (
    Estado VARCHAR(30),
    Cidade VARCHAR(30),
    Bairro VARCHAR(30),
    Logradouro VARCHAR(30),
    Numero NUMBER,
    Complemento VARCHAR(30) 
);
/
    
CREATE TYPE ESTOQUE AS OBJECT (
    Quantidade INT,
    Setor VARCHAR(30)
);
/

CREATE TABLE CLIENTE (
    idCliente INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Endereco ENDERECO NOT NULL,
    Data_de_nascimento DATE NOT NULL,
    Email VARCHAR(60) NOT NULL UNIQUE,
    Telefone VARCHAR(15) NOT NULL
);
ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (idCliente);

CREATE TABLE FORNECEDOR (
    idFornecedor INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Razao_social VARCHAR(70) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Email VARCHAR(60) NOT NULL UNIQUE,
    Telefone VARCHAR(15) NOT NULL
);
ALTER TABLE FORNECEDOR ADD CONSTRAINT PK_FORNECEDOR PRIMARY KEY (idFornecedor);

CREATE TABLE PRODUTO (
    idProduto INT NOT NULL,
    idProdutoFornecedor INT,
    Categoria VARCHAR(20) NOT NULL,
    Descricao VARCHAR(90),
    Valor NUMBER NOT NULL,
    Endereco_estoque ENDERECO NOT NULL,
    Estoque ESTOQUE NOT NULL
);
ALTER TABLE PRODUTO ADD CONSTRAINT PK_PRODUTO PRIMARY KEY (idProduto);
ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_FORNECEDOR FOREIGN KEY (idProdutoFornecedor) REFERENCES FORNECEDOR(idFornecedor);

CREATE TABLE PEDIDO (
    idPedido INT NOT NULL,
    idPedidoCliente INT,
    idPedidoProduto INT,
    Descricao VARCHAR(90),
    Custo NUMBER NOT NULL,
    Data_pedido DATE NOT NULL
);
ALTER TABLE PEDIDO ADD CONSTRAINT PK_PEDIDO PRIMARY KEY (idPedido);
ALTER TABLE PEDIDO ADD CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (idPedidoCliente) REFERENCES CLIENTE(idCliente);
ALTER TABLE PEDIDO ADD CONSTRAINT FK_PEDIDO_PRODUTO FOREIGN KEY (idPedidoProduto) REFERENCES PRODUTO(idProduto);

CREATE TABLE DISPONIBILIDADE_PRODUTO (
    idDispProduto INT,
    idDispPedido INT,
    Quantidade INT NOT NULL,
    Status_disponibilidade VARCHAR(15) CHECK (Status_disponibilidade IN ('Disponível', 'Indisponível')) NOT NULL
);
ALTER TABLE DISPONIBILIDADE_PRODUTO ADD CONSTRAINT FK_DISPPROD_PRODUTO FOREIGN KEY (idDispProduto) REFERENCES PRODUTO(idProduto);
ALTER TABLE DISPONIBILIDADE_PRODUTO ADD CONSTRAINT FK_DISPPROD_PEDIDO FOREIGN KEY (idDispPedido) REFERENCES PEDIDO(idPedido);

CREATE TABLE PAGAMENTO (
    idPagamento INT NOT NULL,
    idPagamentoPedido INT,
    Tipo_pagamento VARCHAR(20) CHECK (Tipo_pagamento IN ('PIX', 'Débito', 'Crédito', 'Boleto bancário')) NOT NULL,
    Data_pagamento DATE
);
ALTER TABLE PAGAMENTO ADD CONSTRAINT PK_PAGAMENTO PRIMARY KEY (idPagamento);
ALTER TABLE PAGAMENTO ADD CONSTRAINT FK_PAGAMENTO_PEDIDO FOREIGN KEY (idPagamentoPedido) REFERENCES PEDIDO(idPedido);

CREATE TABLE ENTREGA (
    idEntrega INT NOT NULL,
    idEntregaPagamento INT,
    idEntregaPedido INT,
    Data_prevista DATE NOT NULL,
    Data_entregue DATE
);
ALTER TABLE ENTREGA ADD CONSTRAINT PK_ENTREGA PRIMARY KEY (idEntrega);
ALTER TABLE ENTREGA ADD CONSTRAINT PK_ENTREGA_PAGAMENTO FOREIGN KEY (idEntregaPagamento) REFERENCES PAGAMENTO(idPagamento);
ALTER TABLE ENTREGA ADD CONSTRAINT PK_ENTREGA_PEDIDO FOREIGN KEY (idEntregaPedido) REFERENCES PEDIDO(idPedido);

-- Sequence e Trigger para idCliente
CREATE SEQUENCE SEQ_CLIENTE
START WITH 100000
INCREMENT BY 1
MAXVALUE 199999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_CLIENTE
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
	SELECT SEQ_CLIENTE.NEXTVAL
	INTO :new.idCliente
	FROM dual;
END;
/

-- Sequence e Trigger para idFornecedor
CREATE SEQUENCE SEQ_FORNECEDOR
START WITH 200000
INCREMENT BY 1
MAXVALUE 299999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_FORNECEDOR
BEFORE INSERT ON FORNECEDOR
FOR EACH ROW
BEGIN
	SELECT SEQ_FORNECEDOR.NEXTVAL
	INTO :new.idFornecedor
	FROM dual;
END;
/

-- Sequence e Trigger para idProduto
CREATE SEQUENCE SEQ_PRODUTO
START WITH 300000
INCREMENT BY 1
MAXVALUE 399999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	SELECT SEQ_PRODUTO.NEXTVAL
	INTO :new.idProduto
	FROM dual;
END;
/

-- Sequence e Trigger para idPedido
CREATE SEQUENCE SEQ_PEDIDO
START WITH 400000
INCREMENT BY 1
MAXVALUE 499999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_PEDIDO
BEFORE INSERT ON PEDIDO
FOR EACH ROW
BEGIN
	SELECT SEQ_PEDIDO.NEXTVAL
	INTO :new.idPedido
	FROM dual;
END;
/

-- Sequence e Trigger para idPagamento
CREATE SEQUENCE SEQ_PAGAMENTO
START WITH 500000
INCREMENT BY 1
MAXVALUE 599999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_PAGAMENTO
BEFORE INSERT ON PAGAMENTO
FOR EACH ROW
BEGIN
	SELECT SEQ_PAGAMENTO.NEXTVAL
	INTO :new.idPagamento
	FROM dual;
END;
/

-- Sequence e Trigger para idEntrega
CREATE SEQUENCE SEQ_ENTREGA
START WITH 600000
INCREMENT BY 1
MAXVALUE 699999
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TRG_ENTREGA
BEFORE INSERT ON ENTREGA
FOR EACH ROW
BEGIN
	SELECT SEQ_ENTREGA.NEXTVAL
	INTO :new.idEntrega
	FROM dual;
END;
/

-- Inserção de dados nas tabelas

INSERT INTO CLIENTE (Nome, CPF, Endereco, Data_de_nascimento, Email, Telefone)
VALUES ('Maria da Silva', '12345678901', ENDERECO('SP', 'São Paulo', 'Centro', 'Avenida Paulista', 123, 'Apto 456'), TO_DATE('15-05-1990', 'DD-MM-YYYY'), 'maria@email.com', '11-9999-9999');
INSERT INTO CLIENTE (Nome, CPF, Endereco, Data_de_nascimento, Email, Telefone)
VALUES ('João Santos', '98765432109', ENDERECO('RJ', 'Rio de Janeiro', 'Copacabana', 'Avenida Atlântica', 456, 'Apto 789'), TO_DATE('20-03-1985', 'DD-MM-YYYY'), 'joao@email.com', '21-8888-8888');
INSERT INTO CLIENTE (Nome, CPF, Endereco, Data_de_nascimento, Email, Telefone)
VALUES ('Ana Pereira', '23456789012', ENDERECO('MG', 'Belo Horizonte', 'Savassi', 'Rua da Bahia', 789, 'Casa 101'), TO_DATE('10-11-1995', 'DD-MM-YYYY'), 'ana@email.com', '31-7777-7777');

INSERT INTO FORNECEDOR (Nome, Razao_social, CNPJ, Email, Telefone)
VALUES ('Fornecedor A', 'Razão A Ltda.', '12345678901234', 'fornecedora@email.com', '11-5555-5555');
INSERT INTO FORNECEDOR (Nome, Razao_social, CNPJ, Email, Telefone)
VALUES ('Fornecedor B', 'Razão B Ltda.', '98765432109876', 'fornecedorb@email.com', '21-4444-4444');
INSERT INTO FORNECEDOR (Nome, Razao_social, CNPJ, Email, Telefone)
VALUES ('Fornecedor C', 'Razão C Ltda.', '23456789012345', 'fornecedorc@email.com', '31-3333-3333');

INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200000, 'Eletrônicos', 'Smartphone', 999.99, ENDERECO('SP', 'São Paulo', 'Centro', 'Rua São João', 789, 'Loja 12'), ESTOQUE(50, 'Eletrônicos'));
INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200000, 'Eletrônicos', 'Playstation', 2999.99, ENDERECO('SP', 'São Paulo', 'Centro', 'Rua São João', 789, 'Loja 12'), ESTOQUE(12, 'Eletrônicos'));
INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200001, 'Moda', 'Camiseta', 29.99, ENDERECO('RJ', 'Rio de Janeiro', 'Ipanema', 'Rua Vinícius de Moraes', 123, 'Loja 3'), ESTOQUE(100, 'Roupas'));
INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200001, 'Moda', 'Calça', 59.99, ENDERECO('RJ', 'Rio de Janeiro', 'Ipanema', 'Rua Vinícius de Moraes', 123, 'Loja 3'), ESTOQUE(80, 'Roupas'));
INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200002, 'Eletrodomésticos', 'Liquidificador', 49.99, ENDERECO('MG', 'Belo Horizonte', 'Savassi', 'Av. Getúlio Vargas', 456, 'Loja 1'), ESTOQUE(30, 'Eletrodomésticos'));
INSERT INTO PRODUTO (idProdutoFornecedor, Categoria, Descricao, Valor, Endereco_estoque, Estoque)
VALUES (200002, 'Eletrodomésticos', 'Microondas', 299.99, ENDERECO('MG', 'Belo Horizonte', 'Savassi', 'Av. Getúlio Vargas', 456, 'Loja 1'), ESTOQUE(15, 'Eletrodomésticos'));

INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100000, 300000, 'Pedido 1 - Cliente Maria: Smartphone', 999.99, TO_DATE('05-11-2023', 'DD-MM-YYYY'));
INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100000, 300001, 'Pedido 2 - Cliente Maria: Playstation', 2999.99, TO_DATE('06-11-2023', 'DD-MM-YYYY'));
INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100001, 300002, 'Pedido 1 - Cliente João: Camiseta', 29.99, TO_DATE('06-11-2023', 'DD-MM-YYYY'));
INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100001, 300003, 'Pedido 2 - Cliente João: Calça', 59.99, TO_DATE('07-11-2023', 'DD-MM-YYYY'));
INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100002, 300004, 'Pedido 1 - Cliente Ana: Liquidificador', 49.99, TO_DATE('07-11-2023', 'DD-MM-YYYY'));
INSERT INTO PEDIDO (idPedidoCliente, idPedidoProduto, Descricao, Custo, Data_pedido)
VALUES (100002, 300005, 'Pedido 2 - Cliente Ana: Microondas', 299.99, TO_DATE('08-11-2023', 'DD-MM-YYYY'));

INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300000, 400000, 50, 'Disponível');
INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300001, 400001, 12, 'Disponível');
INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300002, 400002, 100, 'Disponível');
INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300003, 400003, 80, 'Disponível');
INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300004, 400004, 30, 'Disponível');
INSERT INTO DISPONIBILIDADE_PRODUTO (idDispProduto, idDispPedido, Quantidade, Status_disponibilidade)
VALUES (300005, 400005, 15, 'Disponível');

INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400000, 'PIX', TO_DATE('06-11-2023', 'DD-MM-YYYY'));
INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400001, 'Crédito', TO_DATE('07-11-2023', 'DD-MM-YYYY'));
INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400002, 'Débito', TO_DATE('07-11-2023', 'DD-MM-YYYY'));
INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400003, 'Boleto bancário', TO_DATE('08-11-2023', 'DD-MM-YYYY'));
INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400004, 'PIX', TO_DATE('08-11-2023', 'DD-MM-YYYY'));
INSERT INTO PAGAMENTO (idPagamentoPedido, Tipo_pagamento, Data_pagamento)
VALUES (400005, 'Crédito', TO_DATE('09-11-2023', 'DD-MM-YYYY'));

INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500000, 400000, TO_DATE('10-11-2023', 'DD-MM-YYYY'), TO_DATE('11-11-2023', 'DD-MM-YYYY'));
INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500001, 400001, TO_DATE('11-11-2023', 'DD-MM-YYYY'), TO_DATE('12-11-2023', 'DD-MM-YYYY'));
INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500002, 400002, TO_DATE('11-11-2023', 'DD-MM-YYYY'), TO_DATE('12-11-2023', 'DD-MM-YYYY'));
INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500003, 400003, TO_DATE('12-11-2023', 'DD-MM-YYYY'), NULL);
INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500004, 400004, TO_DATE('12-11-2023', 'DD-MM-YYYY'), NULL);
INSERT INTO ENTREGA (idEntregaPagamento, idEntregaPedido, Data_prevista, Data_entregue)
VALUES (500005, 400005, TO_DATE('13-11-2023', 'DD-MM-YYYY'), NULL);

-- Queries

-- Consulta 1:
SELECT
    c.Nome AS Nome_cliente,
    c.CPF AS CPF,
    p.Descricao AS Descricao_pedido,
    pr.Categoria AS Categoria_produto,
    f.Razao_social AS Razao_social_fornecedor,
    d.Status_disponibilidade AS Disponibilidade, 
    p.Custo AS Custo_pedido,
    pa.Tipo_pagamento AS Tipo_pagamento,
    e.Data_prevista AS Data_entrega_prevista
FROM CLIENTE c
INNER JOIN PEDIDO p ON c.idCliente = p.idPedidoCliente
INNER JOIN PRODUTO pr ON pr.idProduto = p.idPedidoProduto
INNER JOIN FORNECEDOR f ON f.idFornecedor = pr.idProdutoFornecedor
INNER JOIN DISPONIBILIDADE_PRODUTO d ON d.idDispProduto = pr.idProduto
INNER JOIN PAGAMENTO pa ON p.idPedido = pa.idPagamentoPedido
INNER JOIN ENTREGA e ON pa.idPagamento = e.idEntregaPagamento
WHERE p.Custo > 100 AND pa.Tipo_pagamento <> 'Boleto bancário'
ORDER BY c.Nome ASC, p.Custo DESC;

-- Consulta 2:
SELECT 
    c.Nome AS Nome, 
    p.Descricao AS Descricao_pedido, 
    p.Custo AS Custo_pedido,
    p.Data_pedido AS Data_pedido,
    e.Data_prevista AS Data_entrega_prevista
FROM CLIENTE c
INNER JOIN PEDIDO p ON c.idCliente = p.idPedidoCliente
INNER JOIN ENTREGA e ON p.idPedido = e.idEntregaPedido
WHERE p.Custo > (SELECT AVG(p.Custo) FROM PEDIDO p);

-- Consulta 3:
SELECT 
    p.idProduto AS id_produto, 
    p.Categoria AS Categoria_produto, 
    p.Descricao AS Descricao_produto, 
    p.Valor AS Valor_produto,
    f.Razao_social AS Razao_social_fornecedor,
    f.CNPJ AS CPNJ_fornecedor
FROM PRODUTO p
INNER JOIN FORNECEDOR f ON idFornecedor = idProdutoFornecedor
WHERE idProdutoFornecedor = 200000
UNION
SELECT
    p.idProduto AS id_produto, 
    p.Categoria AS Categoria_produto, 
    p.Descricao AS Descricao_produto, 
    p.Valor AS Valor_produto,
    f.Razao_social AS Razao_social_fornecedor,
    f.CNPJ AS CPNJ_fornecedor
FROM PRODUTO p
INNER JOIN FORNECEDOR f ON idFornecedor = idProdutoFornecedor
WHERE idProdutoFornecedor = 200001;

