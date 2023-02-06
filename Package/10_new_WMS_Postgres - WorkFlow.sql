
/*Warehouse Operation - Replenishment order Workflow */
  /*1) Replenishment order Creation */

  INSERT INTO api."ReplenishmentOrder"
  ("CreatedByid", "ASNItemid", "Quantity", "ETADate", "CarrierName", "AirWayBillNumber", "Status", "ReceivedByid", "ReceiptDate", "PutAwayAisle", "PutAwayBin")
  VALUES(1, 2, 3, '2021-11-30', 'FedEx', '9999 9999 9999', 'NotReceived', null , null, '', '') RETURNING  "ASNorderid";

  /*2) Receive Replenishment order */

  UPDATE api."ReplenishmentOrder"
  SET "Status" = 'Received' , "ReceivedByid" = 4  , "ReceiptDate" = '2021-11-30' 
  WHERE "ASNorderid" = 16;

  /*3) Put Away Replenishment order */

  /* A) Update ReplenishmentOrder Table for status change*/

  UPDATE api."ReplenishmentOrder"
  SET "Status" = 'PutAway' , "PutAwayAisle" = 'A' , "PutAwayBin" = '1' 
  WHERE "ASNorderid" = 16;

  /* B) Update Stock Table by adding inventory*/

  UPDATE api."Stock"
  SET "Quantity" = "Quantity" + 3
  WHERE "Itemid" = 2;

/*Warehouse Operation - ShippingOrder order Workflow */
  /*1) ShippingOrder order Creation */

  INSERT INTO api."ShippingOrder"
  ("SLA", "Status", "ShipToUserid", "ShippingItemid", "Quantity", "ETADate",  "CreatedByid", "FulfilledBy", "FulfilledDate", "Packing", "PackageLength", "PackageWidth", "PackageHeight", "PackageDimensionUOM", "PackageWeight", "PackageWeightUOM", "Carrierid", "CarrierSLA", "AWB", "RAWB")
  VALUES('2DAY_Air_Saver', 'New', 2, 653, 1, '2021-12-24',  2, null, null, null, null, null, null, null, null, null, null, null, null, null);


  /*2) Reserve ShippingOrder order */

  /* A) Update ShippingOrder Table for status change*/

  UPDATE api."ShippingOrder"
  SET "Status" = 'Reserved' , "FulfilledBy" = 4   
  WHERE "ShippingOrderid" = 2;

  /* B) Update Stock Table by subtracting inventory*/

  UPDATE api."Stock"
  SET "Quantity" = "Quantity" - 1
  WHERE "Itemid" = 653;

  /*3) Pick ShippingOrder order */
 
  UPDATE api."ShippingOrder"
  SET "Status" = 'Picked'  
  WHERE "ShippingOrderid" = 2;

  /*4) Pack ShippingOrder order */

  UPDATE api."ShippingOrder"
  SET "Status" = 'Packed' , "Packing" = 'Box', "PackageLength" = 1.1 , "PackageWidth" = 2.2 , "PackageHeight" = 3.3 , "PackageDimensionUOM" = 'IN', "PackageWeight" = 4.56, "PackageWeightUOM" = 'LB' 
  WHERE "ShippingOrderid" = 2;

  /*5) Ship (or) Transport ShippingOrder order */

  UPDATE api."ShippingOrder"
  SET "Status" = 'Shipped'  ,  "FulfilledDate" = '2021-12-01' ,   "Carrierid" = 10, "CarrierSLA" = '2DAY_Air_Saver', "AWB" = '1Z12345678901' ,"RAWB" = '1Z12345678902' 
  WHERE "ShippingOrderid" = 2;
