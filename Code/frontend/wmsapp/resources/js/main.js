

$(document).ready(function () {
    //Load Operator names
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {

        if (this.readyState === 4) {
            const optionofoperatornamesvar = document.getElementById("optionofoperatornames");
            optionofoperatornamesjson = JSON.parse(this.responseText);
            // console.log(optionofoperatornamesjson.length);

            for (let i = 0; i < optionofoperatornamesjson.length; i++) {
                // console.log(optionofoperatornamesjson[i].FirstName + " " + optionofoperatornamesjson[i].LastName);
                const newOption = document.createElement("option");
                newOption.value = optionofoperatornamesjson[i].FirstName + " " + optionofoperatornamesjson[i].LastName;
                newOption.text = optionofoperatornamesjson[i].FirstName + " " + optionofoperatornamesjson[i].LastName;
                optionofoperatornamesvar.appendChild(newOption);

            }

            //document.getElementById('optionofoperatornames').value = this.responseText.FirstName;
        }
    });

    xhr.open("GET", "http://localhost:3000/Operator?select=FirstName,LastName");

    xhr.send();

});

// Capture Operator names and store the primary key
$("#operatorselectedsubmitbtn").click(function () {

    var e = document.getElementById("optionofoperatornames");
    optionofoperatornamesvar = e.options[e.selectedIndex].value;
    // alert(optionofoperatornamesvar)
    firstnlastarrayvar = optionofoperatornamesvar.split(" ");
    //console.log(firstnlastarrayvar);
    firstnamevar = firstnlastarrayvar[0];
    lastnamevar = firstnlastarrayvar[1];

    //console.log(firstnamevar + " " + lastnamevar);
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === 4) {
            //  console.log(this.responseText);
            Employeeidvar = JSON.parse(this.responseText);
            // Store
            localStorage.setItem("currentoperatorfullname", optionofoperatornamesvar);
            localStorage.setItem("currentoperatorprimarykey", Employeeidvar[0].Employeeid);
            window.location.assign("operatorhome.html");
            // Retrieve

            //   console.log(localStorage.getItem("currentoperatorprimarykey"));
        }
    });

    xhr.open("GET", "http://localhost:3000/Operator?select=Employeeid&FirstName=eq." + firstnamevar + "&LastName=eq." + lastnamevar);

    xhr.send();


});

window.myApp = {
    showInfo: () => {
        document.getElementById('info').innerHTML = `
            ${NL_APPID} is running on port ${NL_PORT}  inside ${NL_OS} 
            <br/><br/>
            <span>server: v${NL_VERSION} . client: v${NL_CVERSION}</span>
            `;
    },
    openDocs: () => {
        Neutralino.os.open("https://neutralino.js.org/docs");
    },
    openTutorial: () => {
        Neutralino.os.open("https://www.youtube.com/watch?v=txDlNNsgSh8&list=PLvTbqpiPhQRb2xNQlwMs0uVV0IN8N-pKj");
    },
    setTray: () => {
        if (NL_MODE != "window") {
            console.log("INFO: Tray menu is only available in the window mode.");
            return;
        }
        let tray = {
            icon: "/resources/icons/trayIcon.png",
            menuItems: [
                { id: "VERSION", text: "Get version" },
                { id: "SEP", text: "-" },
                { id: "QUIT", text: "Quit" }
            ]
        };
        Neutralino.os.setTray(tray);
    },
    onTrayMenuItemClicked: (event) => {
        switch (event.detail.id) {
            case "VERSION":
                Neutralino.os.showMessageBox("Version information",
                    `Neutralinojs server: v${NL_VERSION} | Neutralinojs client: v${NL_CVERSION}`);
                break;
            case "QUIT":
                Neutralino.app.exit();
                break;
        }
    },
    onWindowClose: () => {
        Neutralino.app.exit();
    }
};

// Initialize native API communication. This is non-blocking
// use 'ready' event to run code on app load.
// Avoid calling API functions before init or after init.
Neutralino.init();

Neutralino.events.on("trayMenuItemClicked", myApp.onTrayMenuItemClicked);
Neutralino.events.on("windowClose", myApp.onWindowClose);
Neutralino.events.on("ready", () => {
    if (NL_OS != "Darwin") { // TODO: Fix https://github.com/neutralinojs/neutralinojs/issues/615
        window.myApp.setTray();
    }
})

window.myApp.showInfo();
