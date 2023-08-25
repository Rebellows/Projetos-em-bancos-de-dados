use CarWorkshop;

INSERT INTO Clients (Fname, Lname, CPF, Address) VALUES
('John', 'Doe', '123456789', '123 Main St'),
('Jane', 'Smith', '987654321', '456 Elm Ave');

INSERT INTO Owners (Fname, Lname, CNPJ) VALUES
('Car Workshop Inc.', 'Owner', '123456789'),
('Auto Care Services', 'Group', '987654321');

INSERT INTO Cars (idClient, LicensePlate, Model, Year) VALUES
(1, 'ABC1234', 'Toyota Camry', '2022'),
(2, 'XYZ5678', 'Honda Civic', '2020');

INSERT INTO Workshop (idOwner, Address, CorporateName) VALUES
(1, '789 Industrial Blvd', 'Car Workshop Inc.'),
(2, '456 Repair Ave', 'Auto Care Services');

INSERT INTO Issues (idCar, Description, NeedPart) VALUES
(1, 'Engine Check Light On', 1),
(2, 'Brakes Squeaking', 1);

INSERT INTO Payments (idIssue, idClient, Metod) VALUES
(1, 1, 'Crédito'),
(2, 2, 'PIX');

INSERT INTO Employees (idWorkshop, Fname, Lname, CPF, Functions) VALUES
(1, 'Mike', 'Johnson', '111222333', 'Mechanic'),
(2, 'Lisa', 'Williams', '444555666', 'Service Manager');

INSERT INTO Stocks (idWorkshop, Quantity, Address) VALUES
(1, 100, '789 Industrial Blvd'),
(2, 150, '456 Repair Ave');

INSERT INTO Parts (idIssue, Description, Category) VALUES
(1, 'Spark Plugs', 'Máquina'),
(2, 'Brake Pads', 'Acessório');

INSERT INTO Employee_has_Issues (Quantity, idEmployee, idIssue) VALUES
(1, 1, 1),
(2, 2, 2);

INSERT INTO Stock_has_Parts (Quantity, idStock, idPart) VALUES
(50, 1, 1),
(75, 2, 2);
