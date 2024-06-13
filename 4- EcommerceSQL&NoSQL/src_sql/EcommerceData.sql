INSERT INTO Cliente (nome, cpf, email) VALUES ('Charles Oliveira', '12345678901', 'charles.oliveira@gmail.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Amanda Nunes', '23456789012', 'amanda.nunes@outlook.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Alex Pereira', '34567890123', 'alex.pereira@ig.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Virna Jandiroba', '45678901234', 'virna.jandiroba@yahoo.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Caio Borralho', '56789012345', 'caio.borralho@protonmail.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Paulo Costa', '67890123456', 'paulo.costa@gmail.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Amanda Lemos', '78901234567', 'amanda.lemos@outlook.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Rafael dos Anjos', '89012345678', 'rafael.anjos@ig.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Taila Santos', '90123456789', 'taila.santos@yahoo.com');
INSERT INTO Cliente (nome, cpf, email) VALUES ('Diego Lopes', '01234567890', 'diego.lopes@protonmail.com');

INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('01001000', 123, 'Apto 101', 1);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('02002000', 456, NULL, 2);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('03003000', 789, 'Bloco B', 3);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('04004000', 101, 'Casa 2', 4);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('05005000', 202, 'Apto 305', 5);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('06006000', 303, 'Bloco C', 1);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('07007000', 404, 'Apto 402', 6);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('08008000', 505, NULL, 7);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('09009000', 606, 'Bloco A', 8);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('10010000', 707, 'Casa 3', 9);
INSERT INTO Endereco (cep, numero, complemento, id_cliente) VALUES ('11011000', 808, 'Apto 808', 10);

INSERT INTO Categoria (nome) VALUES ('Eletrônicos');
INSERT INTO Categoria (nome) VALUES ('Livros');
INSERT INTO Categoria (nome) VALUES ('Roupas');

INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Samsung A34', 1500.00, 1);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Notebook Gamer Lenovo LOQ 15', 3500.00, 1);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Tablet Xixaomiro 10.1', 800.00, 1);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Câmera Nikon D60', 1200.00, 1);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('O Pequeno Príncipe', 50.00, 2);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Ayrton - O herói Revelado', 70.00, 2);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Diário de um Banana: Dias de Cão', 90.00, 2);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Crepúsculo', 60.00, 2);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Camiseta Estampa The Beatles', 30.00, 3);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Calça Jeans Boca de Sino', 100.00, 3);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Vestido de Pijama Selfie', 150.00, 3);
INSERT INTO Produto (nome, preco, id_categoria) VALUES ('Chinelo Havaianas One Piece', 200.00, 3);

INSERT INTO Transportadora (nome, email) VALUES ('Correios', 'contato@correios.com.br');
INSERT INTO Transportadora (nome, email) VALUES ('Sedex', 'contato@sedex.com.br');

INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('05-01-2024 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'Cartão', 1, 1);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('06-02-2024 11:45:00', 'DD-MM-YYYY HH24:MI:SS'), 'Boleto', 2, 2);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('07-03-2024 15:20:00', 'DD-MM-YYYY HH24:MI:SS'), 'Pix', 3, 3);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('08-04-2024 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'Cartão', 4, 4);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('09-05-2024 14:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'Boleto', 5, 5);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('11-04-2024 12:15:00', 'DD-MM-YYYY HH24:MI:SS'), 'Pix', 6, 6);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('10-06-2024 16:45:00', 'DD-MM-YYYY HH24:MI:SS'), 'Cartão', 7, 7);
INSERT INTO Pedido (data_hora, forma_pgto, id_cliente, id_endereco) VALUES (TO_DATE('12-03-2024 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'Boleto', 8, 8);

INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 1, 1, 1, TO_DATE('02-07-2024', 'DD-MM-YYYY'), 'Enviado');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 2, 1, 1, TO_DATE('02-07-2024', 'DD-MM-YYYY'), 'Enviado');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (2, 5, 2, 2, TO_DATE('05-09-2024', 'DD-MM-YYYY'), 'Pendente');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (2, 6, 2, 1, TO_DATE('05-09-2024', 'DD-MM-YYYY'), 'Pendente');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 9, 3, 3, TO_DATE('23-03-2024', 'DD-MM-YYYY'), 'Entregue');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 10, 3, 1, TO_DATE('23-03-2024', 'DD-MM-YYYY'), 'Entregue');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 3, 4, 1, TO_DATE('10-07-2024', 'DD-MM-YYYY'), 'Enviado');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 4, 4, 1, TO_DATE('10-07-2024', 'DD-MM-YYYY'), 'Enviado');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (2, 7, 5, 2, TO_DATE('12-09-2024', 'DD-MM-YYYY'), 'Pendente');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (2, 8, 5, 1, TO_DATE('12-09-2024', 'DD-MM-YYYY'), 'Pendente');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 11, 6, 3, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 'Entregue');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 12, 6, 1, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 'Entregue');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 7, 7, 1, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 'Pendente');
INSERT INTO Pedido_has_produto (id_transportadora, id_produto, id_pedido, quantidade, data_entrega, status_entrega) VALUES (1, 9, 8, 2, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 'Enviado');

INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (1, 1, 4.5, 'Produto muito custo-benefício, uma pena que com três meses de uso fica uma carroça.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (5, 7, 5.0, 'Excelente leitura, um livro que redefine o conceito de filosofia pós-moderna e repensa toda a estrutura social.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (3, 9, 3.2, 'Comprei para minha filha e ela não gostou, agora quem usa sou eu.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (1, 2, 4.8, 'Produto excelente! Consigo jogar até Alan Wake II.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (2, 5, 3.5, 'Comprei errado, queria O Príncipe do Nicolau Maquiavel, mas meu filho gostou.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (3, 10, 5.0, 'Adorei a calça, muito confortável e estilosa, as vezes arrasta no chão, mas vale a pena.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (4, 4, 3.8, 'Câmera boa, mas achei na Shoppe pela metade do preço.');
INSERT INTO Avaliacao (id_cliente, id_produto, nota, comentario) VALUES (6, 12, 2.1, 'Enquenta muito caminhando no asfalto.');
