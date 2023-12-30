import { initializeApp } from "firebase/app";
import { getMessaging, onMessage } from "firebase/messaging";
import { firebaseConfig } from "./config";

import { play } from "../sound";

const firebase = {
  mounted() {
    const app = initializeApp(firebaseConfig);
    const messaging = getMessaging(app);

    onMessage(messaging, (payload) => {
      const options = {
        body: payload.notification.body,
        // icon: payload.notification.image,
        // badge: payload.notification.image,
      };

      console.log("payload brabo", payload);

      new Notification(payload.notification.title, options);

      // play({ detail: "juntos" });
      // play({ detail: payload.data.sound });
    });
  },
};

export default firebase;
