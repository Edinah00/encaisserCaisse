DROP DATABASE IF EXISTS encaisserCaisse;
CREATE DATABASE encaisserCaisse;
use encaisserCaisse;
CREATE Table Cheque(
    id_cheque INT AUTO_INCREMENT PRIMARY KEY,
    numero_cheque VARCHAR(20),
    numero_compte VARCHAR(20),
    date_limite DATE


);
CREATE table EtatCheque(
    id_etat INT AUTO_INCREMENT PRIMARY KEY,
    etat VARCHAR(10)
);
CREATE TABLE ChequeEtat(
    id_chequeEtat INT AUTO_INCREMENT PRIMARY KEY,
    id_cheque INT,
    id_etat INT ,
    FOREIGN KEY (id_etat) REFERENCES EtatCheque(id_etat),
    date_etat DATE,
    beneficiaire VARCHAR(50),
    FOREIGN KEY (id_cheque) REFERENCES Cheque(id_cheque)
);
CREATE TABLE mouvement (
    id_mouvement INT AUTO_INCREMENT PRIMARY KEY,
    numero_compte VARCHAR(20),
    date_mouvement DATE ,
    type VARCHAR(10),
    montant DECIMAL(10,5)

);

INSERT INTO Cheque (numero_cheque, numero_compte, date_limite)
VALUES 
('CHQ001', 'ACC12345', '2025-02-10'),
('CHQ002', 'ACC98765', '2025-03-01'),
('CHQ003', 'ACC45678', '2025-01-25'),
('CHQ004', 'ACC74125', '2025-04-15');
INSERT INTO Cheque (numero_cheque, numero_compte, date_limite)
VALUES 
('CHQ005', 'ACC74126', '2025-12-15');
UPDATE Cheque
SET date_limite = '2025-12-31'
WHERE numero_cheque = 'CHQ005';

WHERE numero_cheque = 'CHQ005';

INSERT INTO EtatCheque (etat)
VALUES
('OK'),
('Volé'),
('Encaissé');


INSERT INTO ChequeEtat (id_cheque, id_etat, date_etat, beneficiaire)
VALUES
(1, 1, '2025-01-05',null),
(2, 2, '2025-01-18', null),
(3, 3, '2025-01-27', 'Entreprise BETA'),
(4, 1, '2025-02-02', null),
(1, 3, '2025-12-02', 'RABE'),
(5, 1, '2025-12-02', 'RABE');


INSERT INTO mouvement (numero_compte, date_mouvement, type, montant)
VALUES
('ACC12345', '2025-03-15', 'debit', 650.25),
('ACC98765', '2025-03-18', 'credit', 2100.00),
('ACC45678', '2025-03-20', 'debit', 320.10),
('ACC74125', '2025-03-22', 'credit', 5400.90),
('ACC12345', '2025-04-01', 'credit', 1900.00),
('ACC98765', '2025-04-03', 'debit', 770.50),
('ACC45678', '2025-04-05', 'credit', 675.00),
('ACC74125', '2025-04-06', 'debit', 310.40),
('ACC12345', '2025-04-10', 'debit', 250.00),
('ACC98765', '2025-04-12', 'credit', 3800.00);


INSERT INTO mouvement (numero_compte, date_mouvement, type, montant)
VALUES
('ACC74126', '2025-04-05', 'credit', 675.00),
('ACC74126', '2025-04-06', 'debit', 310.40),
('ACC74126', '2025-04-10', 'debit', 250.00),
('ACC74126', '2025-04-12', 'credit', 3800.00);
