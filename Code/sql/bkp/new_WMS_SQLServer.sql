CREATE TABLE [Supplier] (
  [Vendorid] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] nvarchar(255) NOT NULL,
  [LastName] nvarchar(255) NOT NULL,
  [Email] nvarchar(255),
  [Phone] nvarchar(255),
  [StreetAddress1] nvarchar(255) NOT NULL,
  [StreetAdress2] nvarchar(255) NOT NULL,
  [City] nvarchar(255) NOT NULL,
  [State] nvarchar(255) NOT NULL,
  [Country] nvarchar(255) NOT NULL,
  [Zip_PostalCode] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [ReplenishmentOrder] (
  [ASNorderid] int PRIMARY KEY IDENTITY(1, 1),
  [CreatedByid] int NOT NULL,
  [ASNItemid] int NOT NULL,
  [Quantity] int NOT NULL,
  [ETADate] timestamp,
  [CarrierName] nvarchar(255),
  [AirWayBillNumber] nvarchar(255),
  [Status] nvarchar(255) NOT NULL,
  [ReceivedByid] int NOT NULL,
  [ReceiptDate] timestamp NOT NULL,
  [PutAwayAisle] nvarchar(255) NOT NULL,
  [PutAwayBin] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Operator] (
  [Employeeid] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] nvarchar(255) NOT NULL,
  [LastName] nvarchar(255) NOT NULL,
  [Wages] decimal,
  [Type] nvarchar(255),
  [Email] nvarchar(255),
  [Phone] nvarchar(255),
  [StreetAddress1] nvarchar(255) NOT NULL,
  [StreetAddress2] nvarchar(255) NOT NULL,
  [City] nvarchar(255) NOT NULL,
  [State] nvarchar(255) NOT NULL,
  [Country] nvarchar(255) NOT NULL,
  [Zip_PostalCode] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Stock] (
  [Itemid] int PRIMARY KEY IDENTITY(1, 1),
  [PartNumber] nvarchar(255) NOT NULL,
  [PartDescription] nvarchar(255),
  [active] boolean NOT NULL,
  [ItemCost] decimal,
  [ItemCurrencyCode] nvarchar(255) DEFAULT 'USD',
  [Length] decimal,
  [Width] decimal,
  [Height] decimal,
  [DimensionUOM] nvarchar(255) DEFAULT 'IN',
  [Weight] decimal,
  [WeightUOM] nvarchar(255) DEFAULT 'LB',
  [Quantity] int
)
GO

CREATE TABLE [EndUser] (
  [Userid] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] nvarchar(255) NOT NULL,
  [LastName] nvarchar(255) NOT NULL,
  [Email] nvarchar(255),
  [Phone] nvarchar(255),
  [StreetAddress1] nvarchar(255) NOT NULL,
  [StreetAddress2] nvarchar(255) NOT NULL,
  [City] nvarchar(255) NOT NULL,
  [State] nvarchar(255) NOT NULL,
  [Country] nvarchar(255) NOT NULL,
  [Zip_PostalCode] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Partner] (
  [Partnerid] int PRIMARY KEY IDENTITY(1, 1),
  [Partnername] nvarchar(255) NOT NULL,
  [Email] nvarchar(255) NOT NULL,
  [Phone] nvarchar(255) NOT NULL,
  [StreetAddress1] nvarchar(255) NOT NULL,
  [StreetAddress2] nvarchar(255) NOT NULL,
  [City] nvarchar(255) NOT NULL,
  [State] nvarchar(255) NOT NULL,
  [Country] nvarchar(255) NOT NULL,
  [Zip_PostalCode] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Carrier] (
  [Carrierid] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [SLA] nvarchar(255),
  [FirstName] nvarchar(255) NOT NULL,
  [LastName] nvarchar(255) NOT NULL,
  [Email] nvarchar(255),
  [Phone] nvarchar(255) NOT NULL,
  [StreetAddress1] nvarchar(255) NOT NULL,
  [StreetAddress2] nvarchar(255) NOT NULL,
  [City] nvarchar(255) NOT NULL,
  [State] nvarchar(255) NOT NULL,
  [Country] nvarchar(255) NOT NULL,
  [Zip_PostalCode] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [ShippingOrder] (
  [ShippingOrderid] int PRIMARY KEY IDENTITY(1, 1),
  [SLA] nvarchar(255),
  [Status] nvarchar(255),
  [ShipToUserid] int NOT NULL,
  [ShippingItemid] int NOT NULL,
  [Quantity] int NOT NULL,
  [ETADate] timestamp,
  [AirWayBillNumber] nvarchar(255),
  [CreatedByid] int NOT NULL,
  [FulfilledBy] int NOT NULL,
  [FulfilledDate] timestamp NOT NULL,
  [Packing] nvarchar(255) NOT NULL,
  [PackageLength] decimal,
  [PackageWidth] decimal,
  [PackageHeight] decimal,
  [PackageDimensionUOM] nvarchar(255) DEFAULT 'IN',
  [PackageWeight] decimal,
  [PackageWeightUOM] nvarchar(255) DEFAULT 'LB',
  [Carrierid] int NOT NULL,
  [CarrierSLA] nvarchar(255),
  [AWB] nvarchar(255) NOT NULL,
  [RAWB] nvarchar(255)
)
GO

ALTER TABLE [ReplenishmentOrder] ADD FOREIGN KEY ([CreatedByid]) REFERENCES [Supplier] ([Vendorid])
GO

ALTER TABLE [ReplenishmentOrder] ADD FOREIGN KEY ([ASNItemid]) REFERENCES [Stock] ([Itemid])
GO

ALTER TABLE [ReplenishmentOrder] ADD FOREIGN KEY ([ReceivedByid]) REFERENCES [Operator] ([Employeeid])
GO

ALTER TABLE [ShippingOrder] ADD FOREIGN KEY ([ShipToUserid]) REFERENCES [EndUser] ([Userid])
GO

ALTER TABLE [ShippingOrder] ADD FOREIGN KEY ([CreatedByid]) REFERENCES [Partner] ([Partnerid])
GO

ALTER TABLE [ShippingOrder] ADD FOREIGN KEY ([Carrierid]) REFERENCES [Carrier] ([Carrierid])
GO

ALTER TABLE [ShippingOrder] ADD FOREIGN KEY ([ShippingItemid]) REFERENCES [Stock] ([Itemid])
GO

ALTER TABLE [ShippingOrder] ADD FOREIGN KEY ([FulfilledBy]) REFERENCES [Operator] ([Employeeid])
GO
