--Client

CREATE TABLE Client (
    CNP VARCHAR(13) PRIMARY KEY,   
    Nume VARCHAR(30) NOT NULL,    
    Prenume VARCHAR(30) NOT NULL,
    Email VARCHAR(50) UNIQUE,     
    Telefon VARCHAR(15),
    CHECK (SUBSTR(CNP, 1, 1) IN ('1', '2', '5', '6')) 
);
ALTER TABLE Client 
ADD CONSTRAINT CK_Client_CNP_Format CHECK (LENGTH(CNP) = 13);

--Comanda
CREATE TABLE Comanda (
    ID_Comanda INT PRIMARY KEY,       
    Data_Plasarii DATE DEFAULT SYSDATE,    
    Total DECIMAL(10, 2) NOT NULL      
);


ALTER TABLE Comanda 
ADD CONSTRAINT CK_Comanda_Total CHECK (Total > 0);

ALTER TABLE Comanda
ADD CNP VARCHAR(13) NOT NULL;

ALTER TABLE Comanda
ADD CONSTRAINT FK_Comanda_Client FOREIGN KEY (CNP)
REFERENCES Client(CNP) ON DELETE CASCADE;

--Metoda_Plata
CREATE TABLE Metoda_Plata (
    ID_Metoda INT PRIMARY KEY,          
    Tip_plata VARCHAR(30) NOT NULL,    
    Status VARCHAR(10) NOT NULL,        
    Data_adaugare DATE NOT NULL         
);

ALTER TABLE Comanda
ADD ID_Metoda INT NOT NULL;

ALTER TABLE Comanda
ADD CONSTRAINT FK_Comanda_Metoda FOREIGN KEY (ID_Metoda)
REFERENCES Metoda_Plata(ID_Metoda) ON DELETE CASCADE;

--Produs
CREATE TABLE Produs (
    ID_Produs INT PRIMARY KEY,         
    Nume_Produs VARCHAR(50) NOT NULL, 
    Pret DECIMAL(10, 2) NOT NULL                    
);


--Categorie
CREATE TABLE Categorie (
    ID_Categorie INT PRIMARY KEY,    
    Nume_Categorie VARCHAR(30) NOT NULL, 
    Status VARCHAR(10) NOT NULL       
);

ALTER TABLE Produs
ADD ID_Categorie INT NOT NULL;

ALTER TABLE Produs
ADD CONSTRAINT FK_Produs_Categorie FOREIGN KEY (ID_Categorie)
REFERENCES Categorie(ID_Categorie) ON DELETE CASCADE;

--Magazin
CREATE TABLE Magazin (
    ID_Magazin INT PRIMARY KEY,         
    Nume_Magazin VARCHAR(50) NOT NULL, 
    Telefon VARCHAR(15)                
);

--Locatie
CREATE TABLE Locatie (
    ID_Locatie INT PRIMARY KEY,        
    Strada VARCHAR(50) NOT NULL,     
    Numar_Strada VARCHAR(10),          
    Oras VARCHAR(30) NOT NULL,        
    Cod_Postal VARCHAR(10)             
);


ALTER TABLE Magazin
ADD ID_Locatie INT NOT NULL;

ALTER TABLE Magazin
ADD CONSTRAINT FK_Magazin_Locatie FOREIGN KEY (ID_Locatie)
REFERENCES Locatie(ID_Locatie) ON DELETE CASCADE;


--Angajat
CREATE TABLE Angajat (
    ID_Angajat INT PRIMARY KEY,                    
    Nume VARCHAR(30) NOT NULL,        
    Prenume VARCHAR(30) NOT NULL,     
    Email VARCHAR(50) UNIQUE,        
    Telefon VARCHAR(15),              
    Salariu DECIMAL(10, 2)         
);


ALTER TABLE Angajat
ADD ID_Magazin INT NOT NULL;

ALTER TABLE Angajat
ADD CONSTRAINT FK_Angajat_Magazin FOREIGN KEY (ID_Magazin)
REFERENCES Magazin(ID_Magazin) ON DELETE CASCADE;

--Detalii_Comanda_auxiliar
CREATE TABLE Detalii_Comanda (
    ID_Comanda INT NOT NULL,
    ID_Produs INT NOT NULL,
    Cantitate INT NOT NULL,
    Pret_Unitar DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Detalii_Comanda PRIMARY KEY (ID_Comanda, ID_Produs),
    CONSTRAINT FK_Detalii_Comanda_Comanda FOREIGN KEY (ID_Comanda)
        REFERENCES Comanda(ID_Comanda) ON DELETE CASCADE,
    CONSTRAINT FK_Detalii_Comanda_Produs FOREIGN KEY (ID_Produs)
        REFERENCES Produs(ID_Produs) ON DELETE CASCADE
);

--Stoc_auxiliar
CREATE TABLE Stoc (
    ID_Produs INT NOT NULL,
    ID_Magazin INT NOT NULL,
    Cantitate INT NOT NULL,
    Stare_Stoc VARCHAR(15) DEFAULT 'Disponibil' NOT NULL,
    CONSTRAINT PK_Stoc PRIMARY KEY (ID_Produs, ID_Magazin),
    CONSTRAINT FK_Stoc_Produs FOREIGN KEY (ID_Produs)
        REFERENCES Produs(ID_Produs) ON DELETE CASCADE,
    CONSTRAINT FK_Stoc_Magazin FOREIGN KEY (ID_Magazin)
        REFERENCES Magazin(ID_Magazin) ON DELETE CASCADE
);



--Inserari

--Client


INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('2800129076532', 'Popescu', 'Maria', 'maria.popescu@cti.com', '0722123456');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('5050923075141', 'Ionescu', 'Alexandru', 'alex.ionescu@fmi.com', '0734567890');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('2990529077520', 'Dumitrescu', 'Ioana', 'ioana.dumitrescu@unibuc.com', '0741234567');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('5051015075959', 'Radu', 'Andrei', 'andrei.radu@apanova.com', '0759876543');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('2602042907564', 'Enescu', 'Elena', 'elena.enescu@austria.com', '0765432123');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('5020619074364', 'Popa', 'Mihai', 'mihai.popa@info.com', '0776543210');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('6050411074101', 'Vasile', 'Ana', 'ana.vasile@stb.com', '0787654321');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('5241225073610', 'Marinescu', 'Cristian', 'cristian.marinescu@ratb.com', '0791234560');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('6050623078797', 'Iliescu', 'Raluca', 'raluca.iliescu@domain.com', '0701234567');

INSERT INTO Client (CNP, Nume, Prenume, Email, Telefon) 
VALUES ('1970725070980', 'Gheorghe', 'Dan', 'dan.gheorghe@salcia.com', '0712345678');


--Metoda_Plata

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (1, 'Card bancar', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (2, 'Numerar', 'Inactiv', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (3, 'Transfer bancar', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (4, 'PayPal', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (5, 'Bitcoin', 'Inactiv', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (6, 'Apple Pay', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (7, 'Google Pay', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (8, 'SMS Pay', 'Inactiv', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (9, 'Revolut', 'Activ', SYSDATE);

INSERT INTO Metoda_Plata (ID_Metoda, Tip_plata, Status, Data_adaugare)
VALUES (10, 'Western Union', 'Inactiv', SYSDATE);


--Categorie

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (1, 'Costume de balet', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (2, 'Incaltaminte de balet', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (3, 'Accesorii balet', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (4, 'Echipamente antrenament', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (5, 'Produse ingrijire', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (6, 'Decoruri si recuzite', 'Activ');

INSERT INTO Categorie (ID_Categorie, Nume_Categorie, Status)
VALUES (7, 'Materiale didactice', 'Activ');


--Locatie

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (1, 'Bulevardul Constantin Brancoveanu', '15', 'Bucuresti', '041543');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (2, 'Strada Brazda lui Novac', '25', 'Craiova', '200690');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (3, 'Strada Unirii', '8', 'Cluj-Napoca', '400394');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (4, 'Strada Traian', '15', 'Constanta', '900743');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (5, 'Strada Vasile Alecsandri', '10', 'Iasi', '700054');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (6, 'Strada Florilor', '20', 'Timisoara', '300454');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (7, 'Strada Primaverii', '5', 'Brasov', '500321');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (8, 'Bulevardul Revolutiei', '18', 'Oradea', '410067');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (9, 'Strada Rozelor', '11', 'Arad', '310123');

INSERT INTO Locatie (ID_Locatie, Strada, Numar_Strada, Oras, Cod_Postal)
VALUES (10, 'Strada Mihai Eminescu', '2', 'Deva', '330104');


--Magazin

-- Bucuresti
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (1, 'Ballet Elegance', '0211234567', 1);

-- Craiova
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (2, 'Dance Pointe', '0251245789', 2);

-- Cluj-Napoca
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (3, 'PrimaBallet', '0264376890', 3);

-- Constanta
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (4, 'Aria Ballet', '0241443291', 4);

-- Iasi
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (5, 'Pas de Deux', '0232321523', 5);

-- Timisoara
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (6, 'Ballet Boutique', '0256492034', 6);

-- Brasov
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (7, 'En Pointe Dance Shop', '0268427365', 7);

-- Oradea
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (8, 'Ballet Dreams', '0257482910', 8);

-- Arad
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (9, 'Jovial Ballet Shop', '0251357924', 9);

-- Deva
INSERT INTO Magazin (ID_Magazin, Nume_Magazin, Telefon, ID_Locatie)
VALUES (10, 'Le Petit Ballet', '0254890321', 10);


--Angajat
-- Bucuresti
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (100, 'Popescu', 'Andrei', 'andrei.popescu@balletelegance.ro', '0211234567', 3500.00, 1);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (101, 'Ionescu', 'Maria', 'maria.ionescu@balletelegance.ro', '0212345678', 3200.00, 1);

-- Craiova
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (102, 'Georgescu', 'Elena', 'elena.georgescu@dancepointe.ro', '0251245789', 3400.00, 2);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (103, 'Dumitru', 'Victor', 'victor.dumitru@dancepointe.ro', '0251987654', 3300.00, 2);

-- Cluj
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (104, 'Mihai', 'Lucian', 'lucian.mihai@primaballet.ro', '0264376890', 3550.00, 3);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (105, 'Vasile', 'Ioana', 'ioana.vasile@primaballet.ro', '0265389101', 3250.00, 3);

-- Constanta
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (106, 'Nistor', 'Cosmin', 'cosmin.nistor@ariaballet.ro', '0241443291', 3400.00, 4);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (107, 'Dobre', 'Alina', 'alina.dobre@ariaballet.ro', '0241530284', 3100.00, 4);

--Iasi
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (108, 'Marinescu', 'Adrian', 'adrian.marinescu@pasdedeux.ro', '0232321523', 3550.00, 5);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (109, 'Popa', 'Simona', 'simona.popa@pasdedeux.ro', '0232448679', 3300.00, 5);

-- Timisoara
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (110, 'Ciobanu', 'Daniela', 'daniela.ciobanu@balletboutique.ro', '0256492034', 3400.00, 6);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (111, 'Niculae', 'Florin', 'florin.niculae@balletboutique.ro', '0256890247', 3250.00, 6);

-- Brasov
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (112, 'Stanciu', 'Ioana', 'ioana.stanciu@enpointedanceshop.ro', '0268427365', 3500.00, 7);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (113, 'Toma', 'Vasile', 'vasile.toma@enpointedanceshop.ro', '0268349201', 3200.00, 7);

-- Oradea
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (114, 'Dragomir', 'Anca', 'anca.dragomir@balletdreams.ro', '0257482910', 3300.00, 8);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (115, 'Calin', 'Mihai', 'mihai.calin@balletdreams.ro', '0257109876', 3100.00, 8);

-- Arad
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (116, 'Paun', 'Elena', 'elena.paun@jovialballetshop.ro', '0251357924', 3450.00, 9);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (117, 'Albu', 'Iulia', 'iulia.albu@jovialballetshop.ro', '0251456789', 3300.00, 9);

-- Deva
INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (118, 'Moraru', 'Florentina', 'florentina.moraru@lepetitballet.ro', '0254890321', 3250.00, 10);

INSERT INTO Angajat (ID_Angajat, Nume, Prenume, Email, Telefon, Salariu, ID_Magazin)
VALUES (119, 'Chirila', 'Radu', 'radu.chirila@lepetitballet.ro', '0254782903', 3150.00, 10);

 
--Produs

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (101, 'Costum clasic tutu', 250.00, 1);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (102, 'Costum modern body', 180.00, 1);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (103, 'Rochie balet', 320.00, 1);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (201, 'Pantofi demi-pointe din panza', 120.00, 2);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (202, 'Pantofi pointe satin', 300.00, 2);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (203, 'Cizme de incalzire', 200.00, 2);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (301, 'Geanta pentru echipamente', 150.00, 3);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (302, 'Plasturi pentru protectia picioarelor', 50.00, 3);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (303, 'Elastic pentru exercitii', 70.00, 3);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (401, 'Colanti termici', 180.00, 4);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (402, 'Hanorac de incalzire', 250.00,4);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (403, 'Genunchiere', 80.00, 4);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (501, 'Spray anti-alunecare', 60.00,5);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (502, 'Balsam pentru picioare', 40.00, 5);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (503, 'Crema hidratanta pentru piele', 50.00, 5);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (601, 'Esarfe colorate pentru dans', 90.00, 6);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (602, 'Flori artificiale pentru recuzita', 120.00, 6);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (603, 'Spada decorativa pentru spectacole', 250.00, 6);

INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (701, 'DVD lectii de balet clasic', 100.00, 7);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (702, 'Carte Tehnici de balet', 80.00, 7);
INSERT INTO Produs (ID_Produs, Nume_Produs, Pret, ID_Categorie) VALUES (703, 'Poster anatomie pentru balerini', 50.00, 7);


--Stoc
-- Bucuresti
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (101, 1, 15, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (102, 1, 8, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (201, 1, 20, 'Disponibil');

-- Craiova
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (103, 2, 5, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (202, 2, 6, 'Stoc redus');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (302, 2, 18, 'Disponibil');

-- Cluj-Napoca
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (301, 3, 12, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (203, 3, 7, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (303, 3, 15, 'Disponibil');

-- Constanta
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (401, 4, 10, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (402, 4, 6, 'Stoc redus');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (501, 4, 12, 'Disponibil');

-- Iasi
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (601, 5, 8, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (602, 5, 3, 'Stoc redus');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (701, 5, 15, 'Disponibil');

-- Timisoara
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (703, 6, 5, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (502, 6, 10, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (102, 6, 8, 'Disponibil');

-- Brasov
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (503, 7, 6, 'Stoc redus');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (403, 7, 12, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (302, 7, 18, 'Disponibil');

-- Oradea
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (101, 8, 10, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (601, 8, 7, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (202, 8, 9, 'Stoc redus');

-- Arad
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (203, 9, 4, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (702, 9, 6, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (501, 9, 14, 'Disponibil');

-- Deva
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (103, 10, 3, 'Stoc redus');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (403, 10, 8, 'Disponibil');
INSERT INTO Stoc (ID_Produs, ID_Magazin, Cantitate, Stare_Stoc) VALUES (703, 10, 5, 'Disponibil');


--Comanda

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (1, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 450.00, '2800129076532', 1);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (2, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 250.00, '5050923075141', 3);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (3, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 320.00, '2990529077520', 4);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (4, TO_DATE('2024-12-04', 'YYYY-MM-DD'), 150.00, '5051015075959', 6);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (5, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 280.00, '2602042907564', 7);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (6, TO_DATE('2024-12-06', 'YYYY-MM-DD'), 300.00, '5020619074364', 9);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii, Total, CNP, ID_Metoda)
VALUES (7, TO_DATE('2024-12-07', 'YYYY-MM-DD'), 210.00, '6050411074101', 1);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii,  Total, CNP, ID_Metoda)
VALUES (8, TO_DATE('2024-12-08', 'YYYY-MM-DD'),  400.00, '5241225073610', 4);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii,  Total, CNP, ID_Metoda)
VALUES (9, TO_DATE('2024-12-09', 'YYYY-MM-DD'),  370.00, '6050623078797', 6);

INSERT INTO Comanda (ID_Comanda, Data_Plasarii,  Total, CNP, ID_Metoda)
VALUES (10, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 220.00, '1970725070980', 7);

--Detalii_Comanda

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (1, 101, 2, 250.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (1, 201, 1, 120.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (2, 102, 1, 180.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (2, 301, 2, 150.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (3, 103, 1, 320.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (3, 402, 1, 250.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (4, 501, 3, 60.00);

INSERT INTO Detalii_Comanda (ID_Comanda, ID_Produs, Cantitate, Pret_Unitar)
VALUES (4, 702, 1, 80.00);




--Stergerea tabelelor
ALTER TABLE DETALII_COMANDA DROP CONSTRAINT FK_DETALII_COMANDA_COMANDA;
ALTER TABLE DETALII_COMANDA DROP CONSTRAINT FK_DETALII_COMANDA_PRODUS;

ALTER TABLE STOC DROP CONSTRAINT FK_STOC_PRODUS;
ALTER TABLE STOC DROP CONSTRAINT FK_STOC_MAGAZIN;

DROP TABLE DETALII_COMANDA CASCADE CONSTRAINTS;
DROP TABLE STOC CASCADE CONSTRAINTS;
DROP TABLE COMANDA CASCADE CONSTRAINTS;
DROP TABLE PRODUS CASCADE CONSTRAINTS;
DROP TABLE CATEGORIE CASCADE CONSTRAINTS;
DROP TABLE MAGAZIN CASCADE CONSTRAINTS;
DROP TABLE LOCATIE CASCADE CONSTRAINTS;
DROP TABLE CLIENT CASCADE CONSTRAINTS;
DROP TABLE ANGAJAT CASCADE CONSTRAINTS;
DROP TABLE METODA_PLATA CASCADE CONSTRAINTS;




