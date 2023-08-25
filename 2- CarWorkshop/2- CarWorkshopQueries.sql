use CarWorkshop;
show tables;

select * from clients;
select * from issues;
select * from cars where year = '2022';
select * from clients where idClient = '2';
select * from payments where Metod = 'PIX' or idClient = '2';
select sum(quantity) from stocks;
select concat(c.Fname,' ', c.Lname), c.CPF, ca.Model, ca.Year from clients c join cars ca on c.idClient = ca.idCar;
select idWorkshop, Address, quantity from stocks group by idStock having quantity > 100;
