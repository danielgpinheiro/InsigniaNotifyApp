import { initialize } from "./initialize";
import { generate } from "./token";

let self = null;

const readFbToken = () => {
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");
  const oldFbToken = window.localStorage.getItem("oldFbToken");

  self.pushEvent("generatedFbToken", {
    current_fb_token: currentFbToken,
    old_fb_token: oldFbToken,
  });
};

const updateFbOldToken = (params) => {
  window.localStorage.setItem("oldFbToken", params.detail.token);
  window.location.reload(true);
};

const firebase = {
  mounted() {
    window.addEventListener("phx:readFbToken", () => {
      readFbToken();
    });

    window.addEventListener("phx:generateFirebaseToken", () => {
      generateFirebaseToken();
    });

    window.addEventListener("phx:updateFbOldToken", (params) => {
      updateFbOldToken(params);
    });

    self = this;

    initialize();
  },
};

export const generateFirebaseToken = async () => {
  const token = await generate();
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");

  if (currentFbToken != token) {
    window.sessionStorage.setItem("currentFbToken", token);
  }

  window.localStorage.setItem("oldFbToken", currentFbToken);

  self.pushEvent("fbTokenCreated", token);
};

export default firebase;
