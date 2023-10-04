import { getToken, getMessaging } from "firebase/messaging";
import { vapidKey } from "./firebase-config"

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

const pushEvent = async () => {
  const isIOSButNotInstalled =
    "serviceWorker" in navigator && window.navigator.standalone === false;
  const permission = isSupported() ? Notification.permission : "";

  const permissions = {
    isIOSButNotInstalled: isIOSButNotInstalled,
    permission: permission,
  };

  const messaging = getMessaging()
  const token = await getToken(messaging, { vapidKey: vapidKey })

  console.log('token do usuário:', token)

  if (window.location.pathname !== "/login") {
    self.pushEvent("notification-params", {
      params: {
        permissions: permissions,
        firebaseUserToken: token
      }
    });
  }
};

export const requestNotificationPermission = {
  mounted() {
    window.addEventListener("requestNotificationPermission", () => {
      requestPermission();
    });

    self = this;

    pushEvent();
  },
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

      window.location.reload();
    });
  } else {
    Toastify({
      text: "You denied permissions to notifications. Please go to your browser or phone setting to allow notifications.",
      ...toastOptions,
    }).showToast();

    pushEvent();
  }
};