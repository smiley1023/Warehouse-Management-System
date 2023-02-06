
var varsupplierid = null;
var varitemid = null;
$(document).ready(function () {
    document.getElementById("wmessage").value = "User: " + localStorage.getItem("currentoperatorfullname");

    //console.log(localStorage.getItem("currentoperatorfullname"));
    //console.log(localStorage.getItem("currentoperatorprimarykey"));

    //Load Supplier Information

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            if (this.readyState === 4) {
                optionoforsuppliersselectionvar = document.getElementById("optionoforsupplierselection");
                optionoforsuppliersselectionjson = JSON.parse(this.responseText);
                //console.log(optionoforstockselectionjson.length);

                for (let i = 0; i < optionoforsuppliersselectionjson.length; i++) {
                    //  console.log(optionoforstockselectionjson[i].PartNumber + "  ==>  " + optionoforstockselectionjson[i].PartDescription);
                    newOption = document.createElement("option");
                    newOption.value = optionoforsuppliersselectionjson[i].company;
                    newOption.text = optionoforsuppliersselectionjson[i].company;
                    optionoforsuppliersselectionvar.appendChild(newOption);
                    //  document.getElementById("wmessage").value = optionoforstockselectionjson[i].PartNumber + "==>" + optionoforstockselectionjson[i].PartDescription;

                }
                $('.selectpicker').selectpicker('refresh')

                //document.getElementById('optionofoperatornames').value = this.responseText.FirstName;
            }
        }
    });

    xhr.open("GET", "http://localhost:3000/Supplier?select=company");

    xhr.send();



    //Load Stock Information
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            optionoforstocksvar = document.getElementById("optionoforstockselection");
            optionoforstockselectionjson = JSON.parse(this.responseText);
            //console.log(optionoforstockselectionjson.length);

            for (let i = 0; i < optionoforstockselectionjson.length; i++) {
                //  console.log(optionoforstockselectionjson[i].PartNumber + "  ==>  " + optionoforstockselectionjson[i].PartDescription);
                newOption = document.createElement("option");
                newOption.value = optionoforstockselectionjson[i].PartNumber + ";" + optionoforstockselectionjson[i].PartDescription;
                newOption.text = optionoforstockselectionjson[i].PartNumber + ";" + optionoforstockselectionjson[i].PartDescription;
                optionoforstocksvar.appendChild(newOption);
                //  document.getElementById("wmessage").value = optionoforstockselectionjson[i].PartNumber + "==>" + optionoforstockselectionjson[i].PartDescription;

            }
            $('.selectpicker').selectpicker('refresh')

            //document.getElementById('optionofoperatornames').value = this.responseText.FirstName;
        }
    });

    xhr.open("GET", "http://localhost:3000/Stock?select=PartNumber,PartDescription");

    xhr.send();


});


// Create Replenishment Order
$("#replentoredercreatesubmitbtn").click(function () {

    //Get Supplier Vendor id

    var vendoridvar = null;
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            vendoidjson = JSON.parse(this.responseText);
            vendoridvar = vendoidjson[0].Vendorid;

            var xhr = new XMLHttpRequest();
            xhr.withCredentials = true;

            xhr.addEventListener("readystatechange", function () {
                if (this.readyState === 4) {
                    itemidjson = JSON.parse(this.responseText);
                    itemiddvar = itemidjson[0].Itemid;

                    var qtyvar = document.getElementById("Quantityinput").value;
                    var ETADatevar = $("#datepicker").data('datepicker').getFormattedDate('yyyy-mm-dd')
                    var CarrierNamevar = document.getElementById("CarrierNameinput").value;
                    var AirWayBillNumbervar = document.getElementById("AirWayBillNumberinput").value;

                    var ReplenishementOrderConstruct = {
                        "CreatedByid": vendoridvar,
                        "ASNItemid": itemiddvar,
                        "Quantity": parseInt(qtyvar),
                        "ETADate": ETADatevar,
                        "CarrierName": CarrierNamevar,
                        "AirWayBillNumber": AirWayBillNumbervar,
                        "Status": "NotReceived",
                        "ReceivedByid": null,
                        "ReceiptDate": null,
                        "PutAwayAisle": "",
                        "PutAwayBin": ""
                    };
                    var ReplenishementOrderConstructJSONString = JSON.stringify(ReplenishementOrderConstruct);

                    //console.log(ReplenishementOrderConstructJSONString);

                    var data = JSON.stringify(ReplenishementOrderConstruct);

                    var xhr = new XMLHttpRequest();
                    xhr.withCredentials = true;

                    xhr.addEventListener("readystatechange", function () {
                        if (this.readyState === 4) {
                            // console.log(this.responseText);
                            var asnorderidjson = JSON.parse(this.responseText);
                            alert("Your order created successfully!" + "Order id#: " + asnorderidjson[0].ASNorderid);
                        }
                    });

                    xhr.open("POST", "http://localhost:3000/ReplenishmentOrder");
                    xhr.setRequestHeader("Prefer", "return=representation");
                    xhr.setRequestHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid21zX3VzZXIifQ.rIjbyGUhUrJQ-mBCR_7Q5Q-WIDio_PpzRHSbWzjJYQw");
                    xhr.setRequestHeader("Content-Type", "application/json");

                    xhr.send(data);

                }
            });

            partnumpartdescarrayvar = gvaritemid.split(";");
            //console.log(firstnlastarrayvar);
            partnumvar = partnumpartdescarrayvar[0];

            xhr.open("GET", "http://localhost:3000/Stock?select=Itemid&PartNumber=eq." + partnumvar);

            xhr.send();





        }
    });

    // console.log(varsupplierid);

    xhr.open("GET", "http://localhost:3000/Supplier?select=Vendorid&company=eq." + gvarsupplierid);

    xhr.send();





});

$(function () {
    $("#datepicker").datepicker({
        autoclose: true,
        todayHighlight: true
    }).datepicker('update', new Date());
});





$('#optionoforsupplierselection').on('change', function () {
    gvarsupplierid = $(this).val();
    // console.log(varsupplierid);
});


$('#optionoforstockselection').on('change', function () {
    gvaritemid = $(this).val();
    // console.log(varsupplierid);
});