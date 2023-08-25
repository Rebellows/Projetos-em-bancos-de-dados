create database CarWorkshop;
use CarWorkshop;
show tables;

create table Clients (
	idClient int auto_increment primary key,
    Fname varchar(20) not null,
    Lname varchar(20) not null,
    CPF char(9) not null,
    Address varchar(70),
    constraint unique_cpf unique (CPF)
);

create table Owners (
	idOwner int auto_increment primary key,
	Fname varchar(20) not null,
    Lname varchar(20) not null,
    CNPJ char(9) not null,
    constraint unique_cnpj unique (CNPJ)
);

create table Cars (
	idCar int auto_increment primary key,
    idClient int not null,
	LicensePlate varchar(7) not null,
    Model varchar(30) not null,
    Year char(4) not null,
    constraint fk_cars_clients foreign key (idClient) references Clients(idClient),
    constraint unique_LicensePlate unique (LicensePlate)
);

create table Workshop (
	idWorkshop int auto_increment primary key,
    idOwner int not null,
    Address varchar(70),
	CorporateName varchar(40),
    constraint fk_workshop_owner foreign key (idOwner) references Owners(idOwner),
    constraint unique_CorporateName unique (CorporateName)
);

create table Issues (
	idIssue int auto_increment primary key,
    idCar int not null,
    Description varchar(255) not null,
    NeedPart tinyint,
    constraint fk_issues_cars foreign key (idCar) references Cars(idCar)
);

create table Payments (
	idPayment int auto_increment primary key,
    idIssue int not null,
    idClient int not null,
	Metod enum("Crédito","Débito","PIX") not null,
    constraint fk_payments_issues foreign key (idIssue) references Issues(idIssue),
    constraint fk_payments_clients foreign key (idClient) references Clients(idClient)
);

create table Employees (
	idEmployee int auto_increment primary key,
    idWorkshop int not null,
    Fname varchar(20) not null,
    Lname varchar(20) not null,
    CPF char(9) not null,
    Functions varchar(20) not null,
    constraint fk_employees_workshop foreign key (idWorkshop) references Workshop(idWorkshop),
	constraint unique_cpf unique (CPF)

);

create table Stocks (
	idStock int auto_increment primary key,
    idWorkshop int not null,
    Quantity int not null,
    Address varchar(70) not null,
	constraint fk_stocks_workshop foreign key (idWorkshop) references Workshop(idWorkshop)
);

create table Parts (
	idPart int auto_increment primary key,
    idIssue int not null,
	Description varchar(70) not null,
    Category enum("Máquina","Acessório","Lataria") not null,
    constraint fk_parts_issues foreign key (idIssue) references Issues(idIssue)
);

create table Employee_has_Issues (
	Quantity int not null,
    idEmployee int not null,
    idIssue int not null,
	constraint fk_empiss_issues foreign key (idIssue) references Issues(idIssue),
	constraint fk_empiss_employees foreign key (idEmployee) references Employees(idEmployee)
);

create table Stock_has_Parts (
	Quantity int not null,
    idStock int not null,
    idPart int not null,
    constraint fk_stopar_stocks foreign key (idStock) references Stocks(idStock),
    constraint fk_stopar_parts foreign key (idPart) references Parts(idPart)
);