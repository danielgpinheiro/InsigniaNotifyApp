import Toastify from "toastify-js";
import "toastify-js/src/toastify.css";

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

const getNotificationPermission = () => {
  const isIOSButNotInstalled =
    "serviceWorker" in navigator && window.navigator["standalone"] === false;
  const permission = isSupported() ? Notification.permission : "";

  const permissions = {
    isIOSButNotInstalled: isIOSButNotInstalled,
    permission: permission,
  };

  self.pushEvent("notification-permissions", permissions);
};

const requestPermission = () => {
  if (window.Notification && Notification.permission === "granted") {
    getNotificationPermission();
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

    getNotificationPermission();
  }
};

const requestNotification = {
  mounted() {
    window.addEventListener("requestNotificationPermission", () => {
      requestPermission();
    });

    window.addEventListener("phx:getNotificationPermission", () => {
      getNotificationPermission();
    });

    self = this;
  },
};

export default requestNotification;
