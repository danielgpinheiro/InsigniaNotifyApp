export const displayNotification = {
  mounted() {
    window.addEventListener("showNotification", (event) => {
      checkPermissions(event);
    });
  },
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
          duration: 6000,
          newWindow: true,
          gravity: "top",
          position: "right",
          stopOnFocus: true,
          style: {
            background: "linear-gradient(to right, #00b09b, #96c93d)",
            borderRadius: "6px",
          },
        }).showToast();
      }
    });
  } else {
    Toastify({
      text: "You denied permissions to notifications. Please go to your browser or phone setting to allow notifications.",
      duration: 6000,
      newWindow: true,
      gravity: "top",
      position: "right",
      stopOnFocus: true,
      style: {
        background: "linear-gradient(to right, #00b09b, #96c93d)",
        borderRadius: "6px",
      },
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
