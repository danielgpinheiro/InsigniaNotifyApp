import { getToken, getMessaging } from "firebase/messaging";
import { vapidKey } from "./firebase/config";

let self;

const toastOptions = {
  duration: 3000,
  newWindow: true,
  gravity: "top",
  position: "right",
  style: {
    background: "linear-gradient(135deg, #BC170F, #E84753)",
    borderRadius: "6px",
  },
};

const isSupported = () =>
  "Notification" in window &&
  "serviceWorker" in navigator &&
  "PushManager" in window;

const pushEvent = () => {
  const isIOSButNotInstalled =
    "serviceWorker" in navigator && window.navigator.standalone === false;
  const permission = isSupported() ? Notification.permission : "";

  const permissions = {
    isIOSButNotInstalled: isIOSButNotInstalled,
    permission: permission,
  };

  if (window.Notification && Notification.permission === "granted") {
    generateFirebaseToken();
  }

  self.pushEventTo(
    "#request-notification-permission",
    "notification-permissions",
    permissions
  );
};

const generateFirebaseToken = async () => {
  const messaging = getMessaging();
  const token = await getToken(messaging, { vapidKey: vapidKey });
  console.log("token", token);
  window.sessionStorage.setItem("fbToken", token);
};

const requestPermission = () => {
  if (window.Notification && Notification.permission === "granted") {
    pushEvent();
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission((status) => {
      if (status !== "granted") {
        Toastify({
          text: "You denied or dismissed permissions to notifications.",
          ...toastOptions,
        }).showToast();
      }

      window.location.reload(true);
    });
  } else {
    Toastify({
      text: "You denied permissions to notifications. Please go to your browser or phone setting to allow notifications.",
      ...toastOptions,
    }).showToast();

    pushEvent();
  }
};

const requestNotification = {
  mounted() {
    window.addEventListener("requestNotificationPermission", () => {
      requestPermission();
    });

    self = this;

    pushEvent();
  },
};

export default requestNotification;
