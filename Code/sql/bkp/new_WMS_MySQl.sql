CREATE TABLE `Supplier` (
  `Vendorid` int PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255),
  `Phone` varchar(255),
  `StreetAddress1` varchar(255) NOT NULL,
  `StreetAdress2` varchar(255) NOT NULL,
  `City` varchar(255) NOT NULL,
  `State` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `Zip_PostalCode` varchar(255) NOT NULL
);

CREATE TABLE `ReplenishmentOrder` (
  `ASNorderid` int PRIMARY KEY AUTO_INCREMENT,
  `CreatedByid` int NOT NULL,
  `ASNItemid` int NOT NULL,
  `Quantity` int NOT NULL,
  `ETADate` timestamp,
  `CarrierName` varchar(255),
  `AirWayBillNumber` varchar(255),
  `Status` varchar(255) NOT NULL,
  `ReceivedByid` int NOT NULL,
  `ReceiptDate` timestamp NOT NULL,
  `PutAwayAisle` varchar(255) NOT NULL,
  `PutAwayBin` varchar(255) NOT NULL
);

CREATE TABLE `Operator` (
  `Employeeid` int PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Wages` decimal,
  `Type` varchar(255),
  `Email` varchar(255),
  `Phone` varchar(255),
  `StreetAddress1` varchar(255) NOT NULL,
  `StreetAddress2` varchar(255) NOT NULL,
  `City` varchar(255) NOT NULL,
  `State` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `Zip_PostalCode` varchar(255) NOT NULL
);

CREATE TABLE `Stock` (
  `Itemid` int PRIMARY KEY AUTO_INCREMENT,
  `PartNumber` varchar(255) NOT NULL,
  `PartDescription` varchar(255),
  `active` boolean NOT NULL,
  `ItemCost` decimal,
  `ItemCurrencyCode` varchar(255) DEFAULT "USD",
  `Length` decimal,
  `Width` decimal,
  `Height` decimal,
  `DimensionUOM` varchar(255) DEFAULT "IN",
  `Weight` decimal,
  `WeightUOM` varchar(255) DEFAULT "LB",
  `Quantity` int
);

CREATE TABLE `EndUser` (
  `Userid` int PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255),
  `Phone` varchar(255),
  `StreetAddress1` varchar(255) NOT NULL,
  `StreetAddress2` varchar(255) NOT NULL,
  `City` varchar(255) NOT NULL,
  `State` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `Zip_PostalCode` varchar(255) NOT NULL
);

CREATE TABLE `Partner` (
  `Partnerid` int PRIMARY KEY AUTO_INCREMENT,
  `Partnername` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(255) NOT NULL,
  `StreetAddress1` varchar(255) NOT NULL,
  `StreetAddress2` varchar(255) NOT NULL,
  `City` varchar(255) NOT NULL,
  `State` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `Zip_PostalCode` varchar(255) NOT NULL
);

CREATE TABLE `Carrier` (
  `Carrierid` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `SLA` varchar(255),
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255),
  `Phone` varchar(255) NOT NULL,
  `StreetAddress1` varchar(255) NOT NULL,
  `StreetAddress2` varchar(255) NOT NULL,
  `City` varchar(255) NOT NULL,
  `State` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `Zip_PostalCode` varchar(255) NOT NULL
);

CREATE TABLE `ShippingOrder` (
  `ShippingOrderid` int PRIMARY KEY AUTO_INCREMENT,
  `SLA` varchar(255),
  `Status` varchar(255),
  `ShipToUserid` int NOT NULL,
  `ShippingItemid` int NOT NULL,
  `Quantity` int NOT NULL,
  `ETADate` timestamp,
  `AirWayBillNumber` varchar(255),
  `CreatedByid` int NOT NULL,
  `FulfilledBy` int NOT NULL,
  `FulfilledDate` timestamp NOT NULL,
  `Packing` varchar(255) NOT NULL,
  `PackageLength` decimal,
  `PackageWidth` decimal,
  `PackageHeight` decimal,
  `PackageDimensionUOM` varchar(255) DEFAULT "IN",
  `PackageWeight` decimal,
  `PackageWeightUOM` varchar(255) DEFAULT "LB",
  `Carrierid` int NOT NULL,
  `CarrierSLA` varchar(255),
  `AWB` varchar(255) NOT NULL,
  `RAWB` varchar(255)
);

ALTER TABLE `ReplenishmentOrder` ADD FOREIGN KEY (`CreatedByid`) REFERENCES `Supplier` (`Vendorid`);

ALTER TABLE `ReplenishmentOrder` ADD FOREIGN KEY (`ASNItemid`) REFERENCES `Stock` (`Itemid`);

ALTER TABLE `ReplenishmentOrder` ADD FOREIGN KEY (`ReceivedByid`) REFERENCES `Operator` (`Employeeid`);

ALTER TABLE `ShippingOrder` ADD FOREIGN KEY (`ShipToUserid`) REFERENCES `EndUser` (`Userid`);

ALTER TABLE `ShippingOrder` ADD FOREIGN KEY (`CreatedByid`) REFERENCES `Partner` (`Partnerid`);

ALTER TABLE `ShippingOrder` ADD FOREIGN KEY (`Carrierid`) REFERENCES `Carrier` (`Carrierid`);

ALTER TABLE `ShippingOrder` ADD FOREIGN KEY (`ShippingItemid`) REFERENCES `Stock` (`Itemid`);

ALTER TABLE `ShippingOrder` ADD FOREIGN KEY (`FulfilledBy`) REFERENCES `Operator` (`Employeeid`);
