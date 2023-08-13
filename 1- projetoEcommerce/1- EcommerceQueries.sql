use ecommerce;
show tables;

select * from clients;
select * from productStorage;
select * from orders where orderDescription = 'compra via aplicativo';
select * from seller where location = 'Rio de Janeiro';
select * from productStorage where storageLocation = 'Rio de Janeiro' or storageLocation = 'Brasília';
select sum(quantity) from productStorage;
select concat(c.Fname,' ', c.Lname), c.CPF, o.orderStatus, o.orderDescription from clients c join orders o on c.idClient = o.idOrderClient;
select idProdStorage, storageLocation, quantity from productStorage group by idProdStorage having quantity < 50;
select s.SocialName, s.CNPJ, p.idPsProduct, p.quantity from supplier s join productSupplier p on s.idSupplier - p.idPsSupplier order by s.SocialName;
select p.idProduct, po.poQuantity, po.poStatus from product p join productOrder po on p.idProduct = po.idPOproduct order by po.poStatus;