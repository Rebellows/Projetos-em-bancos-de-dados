-- 1: Consultar quantos pedidos pendentes a transportadora tem
SELECT 
    t.nome AS Nome_da_transportadora,
    p.id_pedido AS Id_do_pedido,
    pr.nome AS Nome_do_produto,
    pp.quantidade AS Quantidade_de_itens,
    pp.data_entrega AS Data_de_entrega,
    pp.status_entrega AS Status_da_entrega
FROM Transportadora t
INNER JOIN Pedido_has_produto pp ON t.id_transportadora = pp.id_transportadora
INNER JOIN Pedido p ON pp.id_pedido = p.id_pedido
INNER JOIN Produto pr ON pp.id_produto = pr.id_produto
WHERE pp.status_entrega = 'Pendente';

-- 2: Consultar quais pessoas compraram produtos acima de mil reais e como foi pago
SELECT
    c.nome AS Nome_do_cliente,
    pr.nome AS Nome_do_produto,
    pr.preco AS Preco_do_produto,
    p.forma_pgto AS Forma_de_pagamento
FROM Cliente c
INNER JOIN Pedido p ON c.id_cliente = p.id_cliente
INNER JOIN Pedido_has_produto pp ON p.id_pedido = pp.id_pedido
INNER JOIN Produto pr ON pp.id_produto = pr.id_produto
WHERE pr.preco > 1000.00;

-- 3: Consultar a quantidade total de produtos de cada categoria foram comprados e o valor total
SELECT
    ca.nome AS Nome_da_categoria,
    SUM(pp.quantidade) AS Quantidade_de_itens,
    SUM(pr.preco * pp.quantidade) AS Preco_total
FROM Pedido_has_produto pp
INNER JOIN Produto pr ON pp.id_produto = pr.id_produto
INNER JOIN Categoria ca ON pr.id_categoria = ca.id_categoria
GROUP BY ca.nome;

-- 4: Consultar os produtos com uma nota média acima de 4.0 e os clientes que os compraram
SELECT
    c.nome AS Nome_do_cliente,
    pr.nome AS Nome_do_produto,
    AVG(a.nota) AS Media_de_avaliacao
FROM Cliente c
INNER JOIN Pedido p ON c.id_cliente = p.id_cliente
INNER JOIN Pedido_has_produto pp ON p.id_pedido = pp.id_pedido
INNER JOIN Produto pr ON pp.id_produto = pr.id_produto
INNER JOIN Avaliacao a ON pr.id_produto = a.id_produto
WHERE pr.id_produto IN (
    SELECT id_produto
    FROM Avaliacao
    GROUP BY id_produto
    HAVING AVG(nota) > 4.0)
GROUP BY c.nome, pr.nome;

-- 5: Consultar os emails dos clientes e transportadoras cadastrados (particularmente achei uma consulta bem sem fraca, mas acabaram as ideias)
SELECT 
    c.nome AS Nome,
    c.email AS Email
FROM Cliente c
UNION
SELECT
    t.nome AS Nome,
    t.email AS Email
FROM Transportadora t;