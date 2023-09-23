const toastOptions = {
  duration: 6000,
  newWindow: true,
  gravity: "top",
  position: "right",
  stopOnFocus: true,
  style: {
    background: "linear-gradient(135deg, #BC170F, #E84753)",
    borderRadius: "6px",
  },
};

export const notificationObject = window.Notification;
export const isIOSButNotInstalled =
  "serviceWorker" in navigator && window.navigator.standalone === false;
export let permission = null;

export const displayNotification = {
  mounted() {
    window.addEventListener("showNotification", (event) => {
      checkPermissions(event);
    });
    window.addEventListener("requestNotificationPermission", (event) => {
      requestNotificationPermission(event);
    });
  },
};

const requestNotificationPermission = () => {
  if (window.Notification && Notification.permission === "granted") {
    permission = Notification.permission;
    console.info("granted");
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission((status) => {
      if (status === "granted") {
        permission = Notification.permission;
        console.info("granted");
      } else {
        Toastify({
          text: "You denied or dismissed permissions to notifications.",
          ...toastOptions,
        }).showToast();
      }
    });
  } else {
    Toastify({
      text: "You denied permissions to notifications. Please go to your browser or phone setting to allow notifications.",
      ...toastOptions,
    }).showToast();
  }
};

const checkPermissions = () => {
  if (window.Notification && Notification.permission === "granted") {
    notification();
  } else if (window.Notification && Notification.permission !== "denied") {
    Notification.requestPermission((status) => {
      if (status === "granted") {
        notification();
      } else {
        Toastify({
          text: "You denied or dismissed permissions to notifications.",
          ...toastOptions,
        }).showToast();
      }
    });
  } else {
    Toastify({
      text: "You denied permissions to notifications. Please go to your browser or phone setting to allow notifications.",
      ...toastOptions,
    }).showToast();
  }
};

const notification = () => {
  const notifBody = `Body`;
  const notifImg = `https://r2-cdn.insignia.live/Shl9AF66oSfXRmcAdNj580DyHtpLfm8ETKBnnD1i.png`;
  const options = {
    body: notifBody,
    icon: notifImg,
    badge: notifImg,
  };
  window.swRegistration.showNotification("PWA Notification!", options);
};
