import { initialize } from "./initialize";
import { generate } from "./token";

let self = null;

const readFbToken = () => {
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");
  const oldFbToken = window.localStorage.getItem("oldFbToken");

  console.log("currentFbToken", currentFbToken);
  console.log("oldFbToken", oldFbToken);

  self.pushEvent("generatedFbToken", {
    current_fb_token: currentFbToken,
    old_fb_token: oldFbToken,
  });
};

const firebase = {
  mounted() {
    window.addEventListener("phx:readFbToken", () => {
      readFbToken();
    });

    window.addEventListener("phx:generateFirebaseToken", () => {
      generateFirebaseToken();
    });

    self = this;

    initialize();
  },
};

export const generateFirebaseToken = async () => {
  const token = await generate();
  const currentFbToken = window.sessionStorage.getItem("currentFbToken");
  const oldFbToken = window.localStorage.getItem("oldFbToken");

  if (currentFbToken != token) {
    window.sessionStorage.setItem("currentFbToken", token);
  }

  if (oldFbToken != currentFbToken) {
    window.localStorage.setItem("oldFbToken", currentFbToken);
  }

  self.pushEvent("fbTokenCreated", token);
};

export default firebase;
