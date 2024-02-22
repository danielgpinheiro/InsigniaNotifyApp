import { initialize } from "./initialize";
import { generate } from "./token";

let _this;

const readFbToken = () => {
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");
  const oldFbToken = window.localStorage.getItem("oldFbToken");

  _this.pushEvent("generatedFbToken", {
    current_fb_token: currentFbToken,
    old_fb_token: oldFbToken,
  });
};

const updateFbOldToken = (params) => {
  window.localStorage.setItem("oldFbToken", params.detail.token);
  window.location.reload();
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

    _this = this;

    initialize();
  },
};

export const generateFirebaseToken = async () => {
  const token = await generate();
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");

  if (currentFbToken != token) {
    window.sessionStorage.setItem("currentFbToken", token);
  }

  window.localStorage.setItem("oldFbToken", currentFbToken ?? "");

  _this.pushEvent("fbTokenCreated", token);
};

export default firebase;
