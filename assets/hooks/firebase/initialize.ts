import { initializeApp } from "firebase/app";
import { getMessaging, onMessage } from "firebase/messaging";
import Toastify from "toastify-js";
import "toastify-js/src/toastify.css";

import { firebaseConfig } from "./config";
import { play } from "../sound";

export let messaging;

const toastOptions = {
  duration: 3000,
  newWindow: true,
  gravity: "top",
  position: "right",
  style: {
    background: "linear-gradient(135deg, #8dc103, #147c1a)",
    borderRadius: "6px",
  },
};

export const initialize = () => {
  const app = initializeApp(firebaseConfig);
  messaging = getMessaging(app);

  onMessage(messaging, (payload) => {
    const options = {
      body: payload?.notification?.body,
      icon: payload?.notification?.image,
      badge: payload?.notification?.image,
    };

    if (document.hasFocus()) {
      Toastify({
        text: payload?.notification?.body,
        ...toastOptions,
      }).showToast();

      play({ detail: "juntos" });
    } else {
      new Notification(payload?.notification?.title ?? "", options);
    }
  });
};
