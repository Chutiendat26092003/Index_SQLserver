CREATE DATABASE Lab8_Index
GO

USE Lab8_Index
GO 

-- Phần 2
CREATE TABLE Classes
(
    ClassName CHAR(6),
	Teacher VARCHAR(30),
	TimeSlot VARCHAR(30),
	Class INT,
	Lab INT 
)
go

CREATE UNIQUE INDEX MyClusteredIndex ON dbo.Classes(ClassName) WITH( PAD_INDEX = ON, FILLFACTOR = 70, IGNORE_DUP_KEY = ON)

CREATE NONCLUSTERED INDEX TeacherIndex ON dbo.Classes(Teacher)

DROP INDEX TeacherIndex ON dbo.Classes

CREATE INDEX ClassLabIndex ON dbo.Classes(Class, Lab)


SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
AND o.type = 'U'
ORDER BY o.name, i.type 




-- Phần 3
CREATE TABLE Student
(
    StudentNo INT PRIMARY KEY,
	StudentName VARCHAR(50),
	StudentAddress VARCHAR(100),
	PhoneNo INT
)
GO

CREATE TABLE Department
(
    DeptNo INT PRIMARY KEY,
	DeptName VARCHAR(50),
	ManagerName CHAR(30)
)
GO

CREATE TABLE Assignment
(
    AssignmentNo INT PRIMARY KEY,
	DescriptionA VARCHAR(100),
)
GO

CREATE TABLE Works_Assign
(
    JobID INT PRIMARY KEY,
	StudentNo INT FOREIGN KEY REFERENCES dbo.Student(StudentNo),
	AssignmentNo INT FOREIGN KEY REFERENCES dbo.Assignment(AssignmentNo),
	TotalHours INT,
	JobDetails XML
)
GO


CREATE INDEX IX_StudentNo ON dbo.Student(StudentNo)

ALTER INDEX IX_StudentNo ON dbo.Student REBUILD WITH(ONLINE = ON )

CREATE NONCLUSTERED INDEX IX_Dept ON dbo.Department(DeptNo, DeptName,ManagerName)
