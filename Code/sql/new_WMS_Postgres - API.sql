
/* GUI API Section */
  
 create role web_anon nologin;

grant usage on schema api to web_anon;

grant select on api."Supplier" to web_anon;
grant select on api."ReplenishmentOrder" to web_anon;
grant select on api."Operator" to web_anon;
grant select on api."Stock" to web_anon;
grant select on api."EndUser" to web_anon;
grant select on api."Partner" to web_anon;
grant select on api."Carrier" to web_anon;
grant select on api."ShippingOrder" to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;



create role wms_user nologin;
grant wms_user to authenticator;

grant usage on schema api to wms_user;

grant all on api."Supplier" to wms_user;
grant usage, select on sequence api."Supplier_Vendorid_seq" to wms_user;

grant all on api."ReplenishmentOrder" to wms_user;
grant usage, select on sequence api."ReplenishmentOrder_ASNorderid_seq" to wms_user;

grant all on api."Operator" to wms_user;
grant usage, select on sequence api."Operator_Employeeid_seq" to wms_user;

grant all on api."Stock" to wms_user;
grant usage, select on sequence api."Stock_Itemid_seq" to wms_user;

grant all on api."EndUser" to wms_user;
grant usage, select on sequence api."EndUser_Userid_seq" to wms_user;

grant all on api."Partner" to wms_user;
grant usage, select on sequence api."Partner_Partnerid_seq" to wms_user;

grant all on api."Carrier" to wms_user;
grant usage, select on sequence api."Carrier_Carrierid_seq" to wms_user;

grant all on api."ShippingOrder" to wms_user;
grant usage, select on sequence api."ShippingOrder_ShippingOrderid_seq" to wms_user;
