-- Police Information Department Database by Harsh Shah 001839466 --------------------------- 

use policeinformationdeparment;
-- privilege for police Officer --
create user PoliceOfficer identified by 'police1';
revoke all privileges,grant option from PoliceOfficer;
grant All on policeinformationdeparment.* to PoliceOfficer;
--  privilege for police Officer ends here --

-- privilege for police constaple --
create user constaple identified by 'police2';
revoke all privileges,grant option from constaple;
grant select on policeinformationdeparment.* to constaple;
-- privilege for police constaple ends here --

--                                      Privileges done    --


--            Starting with Procedure ----------------------------------

-- Created Procedure using join for police to get all information about departments , arrest , crime,  witness and criminals    --
--                                     Police Information    --------------------------------------------------------
 DELIMITER /)
create procedure PoliceInformation()
Begin 
SELECT distinct A.PoliceId , A.FirstName, A.LastName,A.Town,A.DateOfJoining,
B.VehicleId,B.VehicleType AS Type ,B.VehicleBrand AS Brand,B.VehicleModel AS Model,B.Seats AS Seats,
C.StationCode ,C.Street,C.City,C.State,C.ZipCode,
E.DepartmentName,
F.DateOfArrest,F.Reason,
G.ArrestedFirstName,G.ArrestedLastName,G.ArrestationCity,G.ArrestationState,G.ArrestationZipCode,G.Status,
H.CellNumber AS PrisonCellNumber,H.CAPACITY AS Capacity,
J.CRIMETYPE AS TypeOfCrime,
L.WitnessFirstName,L.WitnessLastName,L.CELLPHONE AS MobileNumber,L.WITNESSCITY As WitnessCity,L.WITNESSSTATE As State,L.WITNESSZIPCODE AS ZipCode
FROM POLICE AS A
INNER JOIN VEHICLE AS B
ON(A.VEHICLEID=B.VEHICLEID)
INNER JOIN POLICESTATION AS C
ON(A.STATIONCODE=C.STATIONCODE)
INNER JOIN departmentstation AS D
ON(D.stationCode=C.STAtioncode)
inner join department as E
ON (E.ClassCode=D.CLASSCODE)
INNER JOIN ARREST AS F
ON(F.POLICEID=A.POLICEID)
INNER JOIN ARRESTED AS G
ON(G.ARRESTEDID=F.ARRESTEDID) 
INNER JOIN PRISONCELL AS H
ON(H.STATIONCODE=C.STATIONCODE)
INNER JOIN ARRESTCRIME AS I
ON (I.ARRESTID=F.ARRESTID)
INNER JOIN CRIME AS J
ON(J.CRIMEID=I.CRIMEID)
INNER JOIN witnesscrime AS K
ON(K.CRIMEID=J.CRIMEID)
INNER JOIN WITNESS AS L
ON(L.WITNESSID=K.WITNESSID);
END;
/)
call PoliceInformation();

-- -------------------------------------------Police information ends here ------------------------------------------------------------------------------------------ 

-- 2-------------------------------------------------------------------------------------



-- PROCEDURE using Joins FOR POLICE WHO ARRESTED the CRIMINALs  --
DELIMITER /(
create procedure PoliceArrests()
begin
select distinct A.PoliceId AS PoliceId,A.FirstName,A.LastName,D.StationCode,B.DateOfArrest,E.ArrestedFirstName,E.ArrestedLastName ,B.Reason,E.ArrestationCity,E.ArrestationState,E.ArrestationZipCode,E.Status,C.CellNumber
from Police AS A Inner join arrest AS B
on (A.policeid=B.policeId)
inner join arrested AS E
on(E.ArrestedId = B.ArrestedId)
Inner join prisoncell AS C
on(B.cellNumber=C.CellNumber)
INNER JOIN policestation AS D
on(C.StationCode=D.StationCode);
end;
/(
CALL PoliceArrests();

--  POLICE ARREST ENDS HERE--  

--        All Procedure ends here --------------------------------------------------------------

--        Starting with views ---------------------------------------------------------
--                                        3     ---------------------------------------------------------------
--        Created a view for policevehcle, policestation and department Records------------------------------------------------
create view PoliceDepartmentVehicles AS
select DISTINCT A.FirstName,A.LastName,A.DateOfJoining,B.STATIONCODE,B.Street,B.City,B.State,B.ZipCode,D.DepartmentName,E.VEHICLETYPE,E.VEHICLEBRAND,E.VEHICLEMODEL,E.SEATS 
from Police AS A Inner join policestation AS B
on (A.StationCode=B.StationCode)
Inner join departmentstation AS C
on(B.StationCode=C.stationCode)
INNER JOIN department AS D
on(C.classCode=D.ClassCode)
INNER JOIN vehicle AS E
on(E.VehicleId=A.VehicleId)
GROUP BY A.FIRSTNAME,A.LASTNAME; 
select * from PoliceDepartmentVehicles;
--            view for policevehcle, policestation and department Records ends here ---------------------------------------------

                                          --
-- Created a View for Polce,Criminal and Witness Records ------------------------------------------------
--     CRIMINAL AND Police and witness --
create view PoliceWitnessCrim AS
select distinct A.firstname,A.lastname,B.Reason,C.ARRESTEDFIRSTNAME,C.ARRESTEDLASTNAME,C.STATUS,D.BloodTestResult,D.SpermTestResult,F.CRIMETYPE,H.witnessfirstname,h.witnesslastname from Police AS A 
LEFT JOIN Arrest AS B
on (A.policeId = B.policeId)
LEFT join Arrested as C
ON(B.ARRESTEDID=C.ARRESTEDID)
LEFT JOIN criminal D
ON(C.CRIMINALID=D.CRIMINALID)
LEFT JOIN ARRESTCRIME AS E 
ON (E.ARRESTID=B.ARRESTID)
LEFT JOIN CRIME AS F
ON(F.CRIMEID=E.CRIMEID)
left join witnesscrime as G
ON (G.CRIMEID=F.CRIMEID)
LEFT JOIN WITNESS as H
on(H.witnessid=G.witnessid);
SELECT * FROM PoliceWitnessCrim;
--                ends here ---------------------------------------------------------------------------         --

-- ALL VIEWS Ends here ------------------------------------------------------------------------------ 


--                        Inserting values -----------------------------------------------------------

-- Inserting data for Police vehicle --
Insert into Vehicle values('MA1234','SUV','Ford','Explorer',7);
Insert into Vehicle values('MA5678','Muscle','Ford','Mustang',5);
select * from vehicle;
-- Inserting data for Police vehicle ends here -----------------------------------

-- inserting data for police station ---------------------------------------------
Insert into policestation values('BOS2115','Fenway','Boston','MA',2115);
Insert into policestation values('BOS3116','Andheri','Mumbai','MH',3116);
select * from policestation;
-- inserting data for police station ----------------------------------------------
Insert into police values ('Pol1','Arlington','2017-01-01','James','Bond','BOS2115','MA1234');
Insert into police values ('Pol2','Churchgate','2016-02-02','Robo','Cop','BOS3116','MA5678');
select * from police;
-- inserting data for police station ends here -------------------------------------

-- inserting data for department -------------------------------------

insert into department values('CBI','BOSCBI');
insert into department values('FBI','BOSFBI');
select * from department;
-- inserting data for department ends here -------------------------------------

-- inserting data for department station  -------------------------------------
insert into departmentstation values('BOS2115','BOSCBI');
insert into departmentstation values('BOS3116','BOSFBI');
Select * from departmentstation;
-- inserting data for department station ends here -------------------------------------


-- inserting data for prison cell  -------------------------------------

insert into prisoncell values('BosCell00',100,'BOS2115');
insert into prisoncell values('IndCell01',200,'BOS3116');
select * from prisoncell;
-- inserting data for prison cell ends here -------------------------------------

-- inserting data for criminal  -------------------------------------
insert into criminal values('criminal1','Pablo', 'Escobar','B+','3');
insert into criminal values('criminal2','osama', 'laden','A+','2');
insert into criminal values('criminal3','Nikunj', 'Singh','O+','2');
insert into criminal values('criminal4','Chetan', 'Mistry','A-','3');
insert into criminal values('criminal5','Harsh', 'Shah','B+','1');
insert into criminal values('criminal6','Shreyas', 'Kal','0-','3');
select * from criminal;
-- inserting data for criminal ends here -------------------------------------


-- inserting data for Arrested  -------------------------------------

insert into arrested values('Arrested1','Pablo','Escobar','Boston','Ma',2115,'criminal1','Pending');
insert into arrested values('Arrested2','osama','laden','Boston','Ma',3116,'criminal2','Pending');
insert into arrested values('Arrested3','Nikunj','Singh','Boston','Ma',2115,'criminal3','Pending');
insert into arrested values('Arrested4','Chetan','Mistry','Boston','Ma',2115,'criminal4','Pending');
insert into arrested values('Arrested5','Harsh','Shah','Boston','Ma',2115,'criminal5','Pending');
insert into arrested values('Arrested6','Shreyas','Kal','Boston','Ma',2155,'criminal6','Pending');
Select * from arrested;
-- inserting data for arrested  ends here -------------------------------------

-- inserting data for arrest   -------------------------------------


insert into arrest values('Arr1','2017-04-04','Arrested for rough driving','Pol1','BosCell00','Arrested1');
insert into arrest values('Arr2','2017-05-05','Charges of Murder','Pol1','BosCell00','Arrested2');
insert into arrest values('Arr3','2017-05-05','Arrested for rough driving','Pol1','BosCell00','Arrested3');
insert into arrest values('Arr4','2017-06-07','Charges of Murder','Pol2','IndCell01','Arrested4');
insert into arrest values('Arr5','2017-07-08','Charges of Murder','Pol2','IndCell01','Arrested5');
insert into arrest values('Arr6','2017-08-09','Charges of Rape','Pol2','IndCell01','Arrested6');
select * from arrest;
-- inserting data for arrest  ends here -------------------------------------

-- inserting data for crime -------------------------------------
insert into crime values('crime1','Speeding');
insert into crime values('crime2','Murder');
insert into crime values('crime3','Rape');
select * from crime;
-- inserting data for crime ends here -------------------------------------


-- inserting data for arrest crime -------------------------------------
insert into arrestcrime values('crime1','Arr1');
insert into arrestcrime values('crime2','Arr2');
insert into arrestcrime values('crime1','Arr3');
insert into arrestcrime values('crime2','Arr4');
insert into arrestcrime values('crime2','Arr5');
insert into arrestcrime values('crime3','Arr6');
select * from arrestcrime;
-- inserting data for arrest crime ends here -------------------------------------

-- inserting data for Criminal crime ends here -------------------------------------
insert into criminalcrime values ('criminal1','crime1');
insert into criminalcrime values ('criminal2','crime2');
insert into criminalcrime values ('criminal3','crime1');
insert into criminalcrime values ('criminal4','crime2');
insert into criminalcrime values ('criminal5','crime2');insert into criminalcrime values ('criminal6','crime3');
select * from criminalcrime;
 -- inserting data for Criminal crime ends here -------------------------------------

-- inserting data for Witness -------------------------------------
insert into witness values ('witness1',11234567,'Yusuf','Ozbek','Boston','MA',2115);
insert into witness values ('witness2',11345667,'shruti','mehta','Mumbai','MH',2115);
insert into witness values ('witness3',93234598,'Tianqi','Singh','Dubai','UAE',3116);
select * from witness;
-- inserting data for witness ends here -------------------------------------

-- inserting data for witness crime  -------------------------------------
insert into witnesscrime values ('crime1','witness1');
insert into witnesscrime values ('crime2','witness2');
insert into witnesscrime values ('crime3','witness3');
SELECT * FROM witnesscrime;
-- inserting data for witness crime ends here -------------------------------------

-- inserting data for judge decision -------------------------------------
insert into judge_decision values ('judge1','Anil','Guilty','Arrested1');
insert into judge_decision values ('judge2','Punita','Guilty','Arrested2');
insert into judge_decision values ('judge3','Rima','Not Guilty','Arrested3');
insert into judge_decision values ('judge4','Maya','Not Guilty','Arrested4');
insert into judge_decision values ('judge5','Punita','Guilty','Arrested5');
insert into judge_decision values ('judge6','Mohini','Not Guilty','Arrested6');
select * from arrested;
-- inserting data for judge decision ends here -------------------------------------






-- analysis 1-------------------------------------------------
-- This analysis helps to understand for which particular location what is maximum crime thus helping police to be prepared --

select A.ArrestationZipCode,max(D.CRIMETYPE) AS Maximum_Crime  from crime as D inner join ARRESTCRIME AS C
ON(C.CRIMEID=D.CRIMEID)
inner join Arrest AS B
ON(B.ARRESTID=C.ARRESTID)
inner join arrested AS A
ON(A.ARRESTEDID=B.ARRESTEDID)
group by A.ArrestationZipCode;
 

-- Analysis ends here   --

-- analysis 2---
-- This analysis helps to understand the accuracy of police for tracing criminals i.e which police was more efficient --------------------------------
select distinct count(*) AS TOTAL, A.firstname,A.LastName,C.status from Police as A inner join Arrest AS B 
on(A.POLICEid=B.POLICEID)
inner join Arrested as C 
on (B.Arrestedid=C.arrestedId)
where c.status='Guilty'
group by A.firstname,A.lastNAME ;
-- analysis 2 ends here --

-- ALL ANALYSIS ENDS HERE ------------------------------------------------------------
-- Trigger starts here ----------------------------------------------------------------
SET SQL_SAFE_UPDATES=0
delimiter //
Create trigger Judgetrigger
After Insert on judge_decision
for each row
Begin
update arrested set status= 'Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='Guilty');
update arrested set status= 'Not Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='NOT Guilty');
End;
 //
 -- trigger ends here ---------------------------------------------------------
 
