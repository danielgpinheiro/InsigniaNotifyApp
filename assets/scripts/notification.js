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

let self;

const isSupported = () =>
  "Notification" in window &&
  "serviceWorker" in navigator &&
  "PushManager" in window;

const pushEvent = () => {
  const isIOSButNotInstalled =
    "serviceWorker" in navigator && window.navigator.standalone === false;
  const permission = isSupported() ? Notification.permission : "";

  const notification = {
    isIOSButNotInstalled: isIOSButNotInstalled,
    permission: permission,
  };

  if (window.location.pathname !== "/login") {
    self.pushEvent("notification-params", { params: notification });
  }
};

export const displayNotification = {
  mounted() {
    window.addEventListener("showNotification", (event) => {
      checkPermissions(event);
    });
    window.addEventListener("requestNotificationPermission", () => {
      requestNotificationPermission();
    });
    window.addEventListener("phx:showNotification", (event) => {
      checkPermissions(event);
    });

    self = this;

    pushEvent();
  },
};

const requestNotificationPermission = () => {
  if (window.Notification && Notification.permission === "granted") {
    console.info("granted");
    pushEvent();
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission((status) => {
      if (status === "granted") {
        console.info("granted");
      } else {
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

const checkPermissions = (event) => {
  console.log("AAAAAAAAAAA")
  if (window.Notification && Notification.permission === "granted") {
    notification(event);
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission((status) => {
      if (status === "granted") {
        notification(event);
      } else {
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
  }
};

const notification = (event) => {
  pushEvent();

  console.log(event)

  const notifBody = `Body`;
  const notifImg = `https://r2-cdn.insignia.live/Shl9AF66oSfXRmcAdNj580DyHtpLfm8ETKBnnD1i.png`;
  const options = {
    body: notifBody,
    icon: notifImg,
    badge: notifImg,
  };

  window.swRegistration.showNotification("PWA Notification!", options);
};
