// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import {
  SupportHook,
  AuthenticationHook,
  RegistrationHook,
} from "webauthn_components";

import topbar from "../vendor/topbar";

import { displayNotification } from "../scripts/notification";
import { playSound } from "../scripts/sound";
import { toggleAccordion } from "../scripts/toggle_accordion";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: { SupportHook, AuthenticationHook, RegistrationHook, displayNotification, playSound, toggleAccordion },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#8DC103", 0.5: "#63CA14" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// Service Worker Register
window.addEventListener("load", () => {
  if ("serviceWorker" in navigator && "PushManager" in window) {
    console.info("Service Worker and Push is supported");

    navigator.serviceWorker
      .register("/sw.js", { scope: "./" })
      .then((swReg) => {
        console.info("Service Worker is registered", swReg);
        window.swRegistration = swReg;
      })
      .catch((error) => {
        console.error("Service Worker Error", error);
      });
  } else {
    console.warn("Push messaging is not supported");
  }
});