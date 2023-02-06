/* Schema Creation */

 CREATE SCHEMA api;

/* Create Supplier Table - Supplier is the one who does replenishment of manufactured finished goods*/
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
  "Zip_PostalCode" varchar NOT NULL,
  "company" varchar UNIQUE NOT NULL

);

/* Create ReplenishmentOrder Table - Replenishment order adds inventory into the warehouse*/

CREATE TABLE "ReplenishmentOrder" (
  "ASNorderid" SERIAL PRIMARY KEY,
  "CreatedByid" int NOT NULL,
  "ASNItemid" int NOT NULL,
  "Quantity" int NOT NULL,
  "ETADate" timestamp,
  "CarrierName" varchar,
  "AirWayBillNumber" varchar,
  "Status" varchar NOT NULL,
  "ReceivedByid" int ,
  "ReceiptDate" timestamp  ,
  "PutAwayAisle" varchar  ,
  "PutAwayBin" varchar  
);

/* Create Operator Table - Operator is the employee at  the warehouse who work on the floor receiving , put away, pick , pack and ship orders */

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

/* Create Stock Table - Realtime view of Inventory in the warehouse is maintanined in this table */

CREATE TABLE "Stock" (
  "Itemid" SERIAL PRIMARY KEY,
  "PartNumber" varchar UNIQUE NOT NULL,
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

/* Create EndUser Table - Here we store the customer of our business Partners who orders products that needs to be shipped out of the warehouse */

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

/* Create Partner Table - They provide the 3PL oppurtunity to run a warehouse business   */


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

/* Create Carrier Table - They transport the Shipments of various orders out of warehouse to End User/customer   */


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

/* Create ShippingOrder Table - ShippingOrder order reduces the  inventory in the warehouse to fulfill the end user of Partner's  orders */


CREATE TABLE "ShippingOrder" (
  "ShippingOrderid" SERIAL PRIMARY KEY,
  "SLA" varchar,
  "Status" varchar NOT NULL,
  "ShipToUserid" int NOT NULL,
  "ShippingItemid" int NOT NULL,
  "Quantity" int NOT NULL,
  "ETADate" timestamp,
  "CreatedByid" int NOT NULL,
  "FulfilledBy" int  ,
  "FulfilledDate" timestamp  ,
  "Packing" varchar  ,
  "PackageLength" decimal,
  "PackageWidth" decimal,
  "PackageHeight" decimal,
  "PackageDimensionUOM" varchar DEFAULT 'IN',
  "PackageWeight" decimal,
  "PackageWeightUOM" varchar DEFAULT 'LB',
  "Carrierid" int  ,
  "CarrierSLA" varchar,
  "AWB" varchar  ,
  "RAWB" varchar
);

/* Create foreign keys */
ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("CreatedByid") REFERENCES "Supplier" ("Vendorid");

ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("ASNItemid") REFERENCES "Stock" ("Itemid");

ALTER TABLE "ReplenishmentOrder" ADD FOREIGN KEY ("ReceivedByid") REFERENCES "Operator" ("Employeeid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("ShipToUserid") REFERENCES "EndUser" ("Userid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("CreatedByid") REFERENCES "Partner" ("Partnerid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("Carrierid") REFERENCES "Carrier" ("Carrierid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("ShippingItemid") REFERENCES "Stock" ("Itemid");

ALTER TABLE "ShippingOrder" ADD FOREIGN KEY ("FulfilledBy") REFERENCES "Operator" ("Employeeid");


  
