$(document).ready(function () {
    document.getElementById("wmessage").value = "User: " + localStorage.getItem("currentoperatorfullname");
});


// View Replenishment Order




$("#replentorederviewsubmitbtn").click(function () {


    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            statusofasnorderjson = JSON.parse(this.responseText);
            statusofasnorder = statusofasnorderjson[0].Status;
            document.getElementById("modalbodyid").innerHTML = statusofasnorder;



        }
    });
    var asnorderid = document.getElementById("asnordernumberinput").value;

    xhr.open("GET", "http://localhost:3000/ReplenishmentOrder?ASNorderid=eq." + asnorderid);

    xhr.send();

});



// Receive Replenishment Order

$("#replentorederreceivesubmitbtn").click(function () {
    var ReceivedByidvar = localStorage.getItem("currentoperatorprimarykey");
    var today = new Date();
    var ReceiptDatevar = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    // console.log(ReceiptDatevar);
    var data = JSON.stringify({

        "Status": "Received",
        "ReceivedByid": parseInt(ReceivedByidvar),
        "ReceiptDate": ReceiptDatevar
    });

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            //console.log(this.responseText);

            alert("Order#: " + asnorderid + " received successfully!");
        }
    });


    var asnorderid = document.getElementById("asnordernumberinput").value;
    xhr.open("PATCH", "http://localhost:3000/ReplenishmentOrder?ASNorderid=eq." + asnorderid);
    xhr.setRequestHeader("Prefer", "return=representation");
    xhr.setRequestHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid21zX3VzZXIifQ.rIjbyGUhUrJQ-mBCR_7Q5Q-WIDio_PpzRHSbWzjJYQw");
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.send(data);

});



// Putaway Replenishment Order

$("#replentorederputawaysubmitbtn").click(function () {

    var putawayaislevar = document.getElementById("PutAwayAisleinput").value;
    var putawaybinvar = document.getElementById("PutAwayBininput").value;

    var data = JSON.stringify({

        "Status": "PutAway",
        "PutAwayAisle": putawayaislevar,
        "PutAwayBin": putawaybinvar
    });

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            //console.log(this.responseText);
            alert("Order#: " + asnorderid + " putaway successfully!");
        }
    });


    var asnorderid = document.getElementById("asnordernumberinput").value;
    xhr.open("PATCH", "http://localhost:3000/ReplenishmentOrder?ASNorderid=eq." + asnorderid);
    xhr.setRequestHeader("Prefer", "return=representation");
    xhr.setRequestHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid21zX3VzZXIifQ.rIjbyGUhUrJQ-mBCR_7Q5Q-WIDio_PpzRHSbWzjJYQw");
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.send(data);

});