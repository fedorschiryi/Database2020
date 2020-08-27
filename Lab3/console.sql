CREATE DATABASE hospital;

DROP TABLE patient;

CREATE TABLE patient (
patient_id int NOT NULL,
patient_name varchar(50) NOT NULL,
patient_surname varchar(50) NOT NULL,
patient_phone int NOT NULL,
patient_date_of_birth date NOT NULL,
PRIMARY KEY (patient_id)
);

CREATE TABLE chems (
chem_id int NOT NULL primary key,
chem_name varchar(50) NOT NULL,
chem_price int NOT NULL,
chem_tested boolean NOT NULL
);

INSERT INTO chems VALUES (1, 'analgin', 700, true);
INSERT INTO chems VALUES (2, 'pentabarbital', 8600, true);
INSERT INTO chems VALUES (3, 'triptofan', 700, false);
INSERT INTO chems VALUES (4, 'fenibyt', 800, false);
INSERT INTO chems VALUES (5, 'aspart', 1950, true);

INSERT INTO patient VALUES(1, 'Nikita', 'Vorozhbitov', 4786543, '1991-12-25T15:32:06.427');
INSERT INTO patient VALUES(2, 'Genadiy', 'Nozdrev', 4746542, '1990-11-25T15:32:06.427');
INSERT INTO patient VALUES(3, 'Fedor', 'Pogrom', 4776542, '2000-10-23T15:32:06.427');
INSERT INTO patient VALUES(4, 'Nikolay', 'Berserkov', 4786942, '1999-12-25T15:42:02.427');
INSERT INTO patient VALUES(5, 'Alexey', 'Rokotov', 8786542, '1992-12-25T15:32:06.427');
INSERT INTO patient VALUES(6, 'Roman', 'Glucharov', 4786542, '1983-12-25T14:32:06.427');
INSERT INTO patient VALUES(7, 'Svatoslav', 'Chernobrov', 4786591, '1994-12-15T15:32:06.427');
INSERT INTO patient VALUES(8, 'Kostya', 'Cherep', 4780987, '1990-02-28T15:32:06.427');
INSERT INTO patient VALUES(9, 'Yaroslav', 'Topolev', 4786542, '1993-12-25T15:32:06.427');

drop table medicalcard;
drop table clinic;

CREATE TABLE clinic (
clinic_id int NOT NULL PRIMARY KEY,
adress varchar(50) NOT NULL,
post_index int
);

CREATE TABLE morgue (
morgue_id int NOT NULL PRIMARY KEY,
morg_adress varchar(50) NOT NULL,
morg_post_index int
);

INSERT INTO clinic VALUES(1, 'cyBoPoBcKaya 14', 12349);
INSERT INTO clinic VALUES(2, 'chernigovskih partizanov 17', 01488);
INSERT INTO clinic VALUES(3, 'krasnoarmeiskaya 16', 14084);
INSERT INTO clinic VALUES(4, 'belogvardeyskaya 20', 16016);
INSERT INTO clinic VALUES(5, 'berezovaya 1', 11000);


CREATE TABLE medicalcard (
card_id int NOT NULL,
card_owner_id int NOT NULL,
telephone_number varchar(12) NOT NULL,
hospital_id int NOT NULL,
FOREIGN KEY (hospital_id) REFERENCES clinic(clinic_id),
place_of_registration varchar(50) NOT NULL,
PRIMARY KEY (card_id),
FOREIGN KEY (card_owner_id) REFERENCES patient(patient_id)
);

INSERT INTO medicalcard VALUES(1, 1, +79877000001, 1, 'Republic of Dagestan');
INSERT INTO medicalcard VALUES(2, 2, +79877000002, 2, 'Nizhegorodsky Region');
INSERT INTO medicalcard VALUES(3, 3, +79877000003, 4, 'Republic of Dagestan');
INSERT INTO medicalcard VALUES(4, 4, +79877000004, 3, 'Republic of Dagestan');
INSERT INTO medicalcard VALUES(5, 5, +79877000005, 2, 'Republic of Dagestan');
INSERT INTO medicalcard VALUES(6, 6, +79877000006, 2, 'Nizhegorodsky Region');
INSERT INTO medicalcard VALUES(7, 7, +79877000007, 1, 'Republic of Mari El');
INSERT INTO medicalcard VALUES(8, 8, +79877000008, 4, 'Republic of Mari El');
INSERT INTO medicalcard VALUES(9, 9, +79877000009, 3, 'Republic of Mari El');

CREATE TABLE appointments (
appointment_id int NOT NULL,
chems_id int NOT NULL,
patients_id int NOT NULL,
chem_amount int NOT NULL,
date_of_appointment date NOT NULL,
PRIMARY KEY (appointment_id),
FOREIGN KEY (chems_id) REFERENCES chems(chem_id),
FOREIGN KEY (patients_id) REFERENCES patient(patient_id)
);


INSERT INTO appointments VALUES (0, 2, 1, 6, '1997-12-25T15:32:06.427');
INSERT INTO appointments VALUES (1, 5, 5, 5, '1998-12-25T15:32:06.427');
INSERT INTO appointments VALUES (2, 1, 3, 1, '1999-12-25T15:32:06.427');
INSERT INTO appointments VALUES (3, 3, 3, 1, '2000-12-25T15:32:06.427');
INSERT INTO appointments VALUES (4, 4, 2, 6, '2000-11-25T15:32:06.427');
INSERT INTO appointments VALUES (5, 2, 4, 1, '1999-10-25T15:32:06.427');
INSERT INTO appointments VALUES (6, 1, 1, 10, '1992-12-25T15:32:06.427');

-- 1.INSERT
---- 1.1 Áåç óêàçàíèÿ ñïèñêà ïîëåé
		INSERT INTO patient VALUES(48, 'Alexey', 'Borovikov', 7829499, '1994-12-15T15:32:06.427');
---- 1.2 Ñ óêàçàíèå ñïèñêà ïîëåé
		INSERT INTO clinic (clinic_id, adress, post_index) VALUES (6, 'partizanskaya 715', 97250);
---- 1.3 Ñ ÷òåíèåì çíà÷åíèé èç äðóãîé òàáëèöû
		INSERT INTO clinic(clinic_id, adress, post_index) SELECT morgue_id, morgue_id, morg_post_index FROM morgue;

-- 2.DELETE
---- 2.1 Âñåõ çàïèñåé
		DELETE chems;
---- 2.2 Ïî óñëîâèþ
		DELETE FROM chems WHERE chem_id = 1;
---- 2.3 Î÷èñòèòü òàáëèöà
		TRUNCATE TABLE chems;

-- 3.UPDATE
---- 3.1 Âñåõ çàïèñåé
		UPDATE chems SET chem_price = 0;
---- 3.2 Ïî óñëîâèþ, îáíîâëÿÿ îäèí àòðèáóò
		UPDATE chems SET chem_price = 10 WHERE chem_tested = false;
---- 3.3 Ïî óñëîâèþ îáíîâëÿÿ íåñêîëüêî àòðèáóòîâ
		UPDATE chems SET chem_tested = true, chem_price = 1000 WHERE chem_id = 3;

-- 4.SELECT
---- 4.1 Ñ îïðåäåëåííûì íàáîðîì èçâëåêàåìûõ àòðèáóòîâ (SELECT atr1, atr2 FROM...)
		SELECT chem_price, chem_id, chem_name FROM chems;
---- 4.2 Ñî âñåìè àòðèáóòàìè (SELECT * FROM...)
		SELECT * FROM chems;
---- 4.3 Ñ óñëîâèåì ïî àòðèáóòó (SELECT * FROM ... WHERE atr1 = "")
		SELECT * FROM chems WHERE chem_id = 0;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 Ñ ñîðòèðîâêîé ïî âîçðàñòàíèþ ASC + îãðàíè÷åíèå âûâîäà êîëè÷åñòâà çàïèñåé
		SELECT * FROM patient ORDER BY patient_name ASC limit 3;
---- 5.2 Ñ ñîðòèðîâêîé ïî óáûâàíèþ DESC
		SELECT * FROM patient ORDER BY patient_name DESC;
---- 5.3 Ñ ñîðòèðîâêîé ïî äâóì àòðèáóòàì + îãðàíè÷åíèå âûâîäà êîëè÷åñòâà çàïèñåé
		SELECT * FROM patient ORDER BY patient_name, patient_surname DESC limit 3;
---- 5.4 Ñ ñîðòèðîâêîé ïî ïåðâîìó àòðèáóòó, èç ñïèñêà èçâëåêàåìûõ
		SELECT * FROM patient ORDER BY patient_surname;

-- 6. Ðàáîòà ñ äàòàìè. Íåîáõîäèìî, ÷òîáû îäíà èç òàáëèö ñîäåðæàëà àòðèáóò ñ òèïîì DATETIME.
---- 6.1 WHERE ïî äàòå
		SELECT * FROM appointments WHERE date_of_appointment = '2000-12-25T15:32:06.427';
---- 6.2 Èçâëå÷ü èç òàáëèöû íå âñþ äàòó, à òîëüêî ãîä. Íàïðèìåð, ãîä ðîæäåíèÿ àâòîðà.
		SELECT extract(year from patient_date_of_birth) AS year_of_birth FROM patient;

-- 7. SELECT GROUP BY ñ ôóíêöèÿìè àãðåãàöèè
----7.1 MIN
		SELECT chem_name, min(chem_price) AS min_price FROM chems GROUP BY chem_name;
----7.2 MAX
		SELECT chem_name, max(chem_price) AS max_price FROM chems GROUP BY chem_name;
----7.3 AVG
		SELECT chem_name, avg(chem_price) AS avg_price FROM chems GROUP BY chem_name;
----7.4 SUM
		SELECT chem_name, sum(chem_price) AS sum_price FROM chems
		LEFT JOIN medicalcard ON chems.chem_id = medicalcard.card_id
		GROUP BY chem_name;
----7.5 COUNT
		SELECT chem_name, count(chem_id) AS count_of_chems FROM chems
		LEFT JOIN medicalcard ON chems.chem_id = medicalcard.card_id
		GROUP BY chem_name;

-- 8. SELECT GROUP BY + HAVING
----8.1 Íàïèñàòü 3 ðàçíûõ çàïðîñà ñ èñïîëüçîâàíèåì GROUP BY + HAVING
		SELECT chem_name, min(chem_price) AS min_price FROM chems GROUP BY chem_name having min(chem_price) < 200;

		SELECT chem_name, max(chem_price) AS max_price FROM chems GROUP BY chem_name having max(chem_price) > 200;

		SELECT chem_name, count(chem_name) AS count_of_chems FROM chems
		LEFT JOIN medicalcard ON chems.chem_id = medicalcard.card_id
		GROUP BY chem_name having count(chem_name) = 1;

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN äâóõ òàáëèö è WHERE ïî îäíîìó èç àòðèáóòîâ
		SELECT * FROM patient LEFT JOIN medicalcard ON patient.patient_id = medicalcard.card_owner_id WHERE patient_name = 'Nikita';
---- 9.2 RIGHT JOIN. Ïîëó÷èòü òàêóþ æå âûáîðêó, êàê è â 5.1
		SELECT * FROM patient RIGHT JOIN medicalcard ON patient.patient_id = medicalcard.card_owner_id WHERE patient_name = 'Nikita';;
---- 9.3 LEFT JOIN òðåõ òàáëèö + WHERE ïî àòðèáóòó èç êàæäîé òàáëèöû
		SELECT patient.patient_id, patient.patient_name, patient.patient_surname, patient.patient_date_of_birth, patient.patient_phone, hospital.public.medicalcard.card_owner_id, hospital.public.medicalcard.hospital_id
		FROM patient
		LEFT JOIN clinic ON patient.patient_id = clinic.clinic_id
		LEFT JOIN hospital.public.medicalcard ON patient.patient_id = clinic.clinic_id
        WHERE patient.patient_id >= 0 AND patient_surname = 'Gromov' AND clinic_id = 0;
---- 9.4 FULL OUTER JOIN äâóõ òàáëèö
		SELECT * FROM patient FULL OUTER JOIN appointments ON patient.patient_id = appointments.appointment_id;

-- 10. Ïîäçàïðîñû
---- 10.1 Íàïèñàòü çàïðîñ ñ WHERE IN (ïîäçàïðîñ)
		SELECT * FROM patient
		LEFT JOIN appointments ON patient.patient_id = appointments.appointment_id
		WHERE patient.patient_phone IN (SELECT patient_id FROM patient WHERE patient_phone > 10000);
---- 10.2 Íàïèñàòü çàïðîñ SELECT atr1, atr2, (ïîäçàïðîñ) FROM ...
		SELECT chem_id, chem_name, chem_tested,
		(SELECT max(chem_amount) FROM appointments WHERE appointments.chems_id = chems.chem_id) AS chem_am FROM
		chems