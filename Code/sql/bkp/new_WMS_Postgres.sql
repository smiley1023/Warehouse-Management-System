CREATE TABLE "Supplier" (
  "Vendorid" SERIAL PRIMARY KEY,
  "FirstName" varchar NOT NULL,
  "LastName" varchar NOT NULL,
  "Email" varchar,
  "Phone" varchar,
  "StreetAddress1" varchar NOT NULL,
  "StreetAdress2" varchar NOT NULL,
  "City" varchar NOT NULL,
  "State" varchar NOT NULL,
  "Country" varchar NOT NULL,
  "Zip_PostalCode" varchar NOT NULL
);

CREATE TABLE "ReplenishmentOrder" (
  "ASNorderid" SERIAL PRIMARY KEY,
  "CreatedByid" int NOT NULL,
  "ASNItemid" int NOT NULL,
  "Quantity" int NOT NULL,
  "ETADate" timestamp,
  "CarrierName" varchar,
  "AirWayBillNumber" varchar,
  "Status" varchar NOT NULL,
  "ReceivedByid" int NOT NULL,
  "ReceiptDate" timestamp NOT NULL,
  "PutAwayAisle" varchar NOT NULL,
  "PutAwayBin" varchar NOT NULL
);

CREATE TABLE "Operator" (
  "Employeeid" SERIAL PRIMARY KEY,
  "FirstName" varchar NOT NULL,
  "LastName" varchar NOT NULL,
  "Wages" decimal,
  "Type" varchar,
  "Email" varchar,
  "Phone" varchar,
  "StreetAddress1" varchar NOT NULL,
  "StreetAddress2" varchar NOT NULL,
  "City" varchar NOT NULL,
  "State" varchar NOT NULL,
  "Country" varchar NOT NULL,
  "Zip_PostalCode" varchar NOT NULL
);

CREATE TABLE "Stock" (
  "Itemid" SERIAL PRIMARY KEY,
  "PartNumber" varchar NOT NULL,
  "PartDescription" varchar,
  "active" boolean NOT NULL,
  "ItemCost" decimal,
  "ItemCurrencyCode" varchar DEFAULT 'USD',
  "Length" decimal,
  "Width" decimal,
  "Height" decimal,
  "DimensionUOM" varchar DEFAULT 'IN',
  "Weight" decimal,
  "WeightUOM" varchar DEFAULT 'LB',
  "Quantity" int
);

CREATE TABLE "EndUser" (
  "Userid" SERIAL PRIMARY KEY,
  "FirstName" varchar NOT NULL,
  "LastName" varchar NOT NULL,
  "Email" varchar,
  "Phone" varchar,
  "StreetAddress1" varchar NOT NULL,
  "StreetAddress2" varchar NOT NULL,
  "City" varchar NOT NULL,
  "State" varchar NOT NULL,
  "Country" varchar NOT NULL,
  "Zip_PostalCode" varchar NOT NULL
);

CREATE TABLE "Partner" (
  "Partnerid" SERIAL PRIMARY KEY,
  "Partnername" varchar NOT NULL,
  "Email" varchar NOT NULL,
  "Phone" varchar NOT NULL,
  "StreetAddress1" varchar NOT NULL,
  "StreetAddress2" varchar NOT NULL,
  "City" varchar NOT NULL,
  "State" varchar NOT NULL,
  "Country" varchar NOT NULL,
  "Zip_PostalCode" varchar NOT NULL
);

CREATE TABLE "Carrier" (
  "Carrierid" SERIAL PRIMARY KEY,
  "name" varchar,
  "SLA" varchar,
  "FirstName" varchar NOT NULL,
  "LastName" varchar NOT NULL,
  "Email" varchar,
  "Phone" varchar NOT NULL,
  "StreetAddress1" varchar NOT NULL,
  "StreetAddress2" varchar NOT NULL,
  "City" varchar NOT NULL,
  "State" varchar NOT NULL,
  "Country" varchar NOT NULL,
  "Zip_PostalCode" varchar NOT NULL
);

CREATE TABLE "ShippingOrder" (
  "ShippingOrderid" SERIAL PRIMARY KEY,
  "SLA" varchar,
  "Status" varchar,
  "ShipToUserid" int NOT NULL,
  "ShippingItemid" int NOT NULL,
  "Quantity" int NOT NULL,
  "ETADate" timestamp,
  "AirWayBillNumber" varchar,
  "CreatedByid" int NOT NULL,
  "FulfilledBy" int NOT NULL,
  "FulfilledDate" timestamp NOT NULL,
  "Packing" varchar NOT NULL,
  "PackageLength" decimal,
  "PackageWidth" decimal,
  "PackageHeight" decimal,
  "PackageDimensionUOM" varchar DEFAULT 'IN',
  "PackageWeight" decimal,
  "PackageWeightUOM" varchar DEFAULT 'LB',
  "Carrierid" int NOT NULL,
  "CarrierSLA" varchar,
  "AWB" varchar NOT NULL,
  "RAWB" varchar
);

ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("CreatedByid") REFERENCES "Supplier" ("Vendorid");

ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("ASNItemid") REFERENCES "Stock" ("Itemid");

ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("ReceivedByid") REFERENCES "Operator" ("Employeeid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("ShipToUserid") REFERENCES "EndUser" ("Userid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("CreatedByid") REFERENCES "Partner" ("Partnerid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("Carrierid") REFERENCES "Carrier" ("Carrierid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("ShippingItemid") REFERENCES "Stock" ("Itemid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("FulfilledBy") REFERENCES "Operator" ("Employeeid");
