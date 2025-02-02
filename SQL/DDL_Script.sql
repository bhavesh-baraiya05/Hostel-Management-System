create schema Hotel_Management;
set search_path to Hotel_Management;


-- ****************  Hotel   *******************

Create table Hotel(
	Hotel_ID varchar(12) primary key,
	Hotel_Name varchar(30),
	City varchar(20),
	State varchar(12),
	Pincode varchar(9),
	Contact_No varchar(15),
	Stars smallint not null,
	Service varchar(100)
);

-- ****************  Room Category  **************

Create table Room_Category(
	Hotel_ID varchar(12),
	Category_ID varchar(5),
	Name varchar(20),
	Facilities varchar(100) ARRAY[3],
	Primary key(Hotel_ID,Category_ID),
	Foreign key (Hotel_ID) references Hotel(Hotel_ID) on delete cascade on update cascade
);

--***************  Room  *******************

Create table Rooms(
	Category_ID varchar(5),
	Room_No integer,
	Hotel_ID varchar(12),
	Floor_No integer not null,
	Primary key(Room_No,Hotel_ID),
	Foreign key (Hotel_ID) references Hotel(Hotel_ID) on delete cascade on update cascade,
	Foreign key (Category_ID,Hotel_ID) references Room_Category(Category_ID,Hotel_ID) on delete cascade on update cascade
);

-- ****************  Today Price  **************

create table Today_Price(
	Hotel_ID varchar(12),
	Category_ID varchar(5),
	Price decimal(10,2),
	Available_Rooms integer,
	Date date,
	Primary key(Date,Category_Id,Hotel_ID),
	Foreign key(Hotel_ID, Category_ID) references Room_Category(Hotel_ID,Category_ID)  on delete cascade on update cascade
);


-- *************  Customer  *****************

create table Customer(
	Cust_id varchar(12) primary key,
	"Name" varchar(30),
	DOB date,
	Contact_No varchar(15),
	Email varchar(30),
	Street_Name varchar(20),
	City varchar(20),
	"State" varchar(20),
	Pincode varchar(9)
);

-- **************  reservation On  ****************

Create table Reservation_On(
	"Date" date,
	Hotel_ID varchar(12),
	Category_ID varchar(5),
	Cust_ID varchar(12),
	Reservation_ID varchar(10) not null,
	Start_Date date,
	End_date date,
	Primary key("Date",Category_ID,Hotel_ID,Cust_ID),
	Foreign key("Date",Category_ID,Hotel_ID) references Today_Price(Date,Category_ID,Hotel_ID)  on delete cascade on update cascade,
	Foreign key (Cust_id) references Customer(Cust_id) on delete cascade on update cascade
);


-- **************  Check In/Out  ****************

Create table check_in_out(
	Hotel_ID varchar(12),
	Cust_ID varchar(12),
	Room_No integer,
	Check_In_Date date,
	Check_Out_Date date,
	Primary key(Cust_id,Room_No,Hotel_ID),
	Foreign key(Room_No,Hotel_ID) references Rooms(Room_No,Hotel_ID)  on delete cascade on update cascade,
	Foreign key (Cust_id) references Customer(Cust_id) on delete cascade on update cascade
);


-- **************  Department  ****************

Create table Department(
	Hotel_ID varchar(12),
	Dept_ID varchar(5),
	Name varchar(50),
	Manager_eno varchar(5),
	Primary key(Hotel_ID,Dept_ID),
	Foreign key (Hotel_ID) references Hotel(Hotel_ID) on delete cascade on update cascade
);

-- Here two tables referencing to each other that's why first we had inserted data then referenced key.

--  alter table department add foreign key (manager_eno,Hotel_ID) references employee(emp_no,Hotel_ID);


-- ***************  Employee  ***************

Create table Employee(
	Emp_No varchar(5),
	Gender varchar(10),
	"Name" varchar(20),
	Hotel_ID varchar(12),
	DOB date,
	Salary decimal(10,2),
	Super_eno varchar(5),
	Dept_ID varchar(5),
	Primary key(Hotel_ID,Emp_NO),
	Foreign key(Dept_ID,Hotel_ID) references Department(Dept_ID,Hotel_ID) on delete cascade on update cascade,
	Foreign key(Super_eno,Hotel_ID) references Employee(Emp_No,Hotel_ID) on delete cascade on update cascade,
	Foreign key(Hotel_ID) references Hotel(Hotel_ID) on delete cascade on update cascade
);


-- **************  Food  ****************

Create table Food(
	Food_No integer,
	"Name" Varchar(20),
	Hotel_ID varchar(12),
	Category varchar(30),
	Rate decimal(10,2),
	Primary key (Food_No,Hotel_ID),
	Foreign key(Hotel_ID) references Hotel(Hotel_ID) on delete cascade on update cascade
);


-- **************  Ordered By  ****************

Create table Ordered_By(
	Food_NO integer,
	Cust_ID varchar(12),
	Hotel_ID varchar(12),
	Ordered_date date,
	Review varchar(100),
	primary key(Food_NO,Cust_ID,Hotel_ID),
	Foreign key (Cust_ID) references Customer(Cust_ID) on delete cascade on update cascade,
	Foreign key(Food_No,Hotel_ID) references Food(Food_No,Hotel_ID)
);

-- **************  Bills  ****************

Create table Bills(
	Bill_ID varchar(10) primary key,
	"Name" varchar(20),
	Type varchar(20),
	Amount decimal(10,2),
	Date date
);
-- ***************  Invoice  ***************

Create table Invoice(
	Invoice_No Varchar(10) Primary key,
	Cust_id Varchar(12),
	Invoice_Description Varchar(30),
	"Date" date,
	Amount_Payable decimal(10,2),
	Status Varchar(10),
	Payment_Method Varchar(20),
	Bill_ID Varchar(10),
	Foreign key (Cust_id) references Customer(Cust_id) on delete cascade on update cascade,
	Foreign key (Bill_ID) references Bills(Bill_ID) on delete cascade on update cascade
);





