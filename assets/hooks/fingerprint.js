import FingerprintJS from "@fingerprintjs/fingerprintjs";

let self = "";

const fpPromise = FingerprintJS.load();

const readVisitorId = () => {
  const currentVisitorId = window.sessionStorage.getItem("currentVisitorId");
  const oldVisitorId = window.localStorage.getItem("oldVisitorId");

  self.pushEvent("readVisitorId", {
    current_visitor_id: currentVisitorId,
    old_visitor_id: oldVisitorId,
  });
};

const gererateVisitorId = async () => {
  const fp = await fpPromise;
  const result = await fp.get();
  const { visitorId } = result;
  const currentVisitorId = window.sessionStorage.getItem("currentVisitorId");
  const oldVisitorId = window.localStorage.getItem("oldVisitorId");

  if (currentVisitorId !== visitorId) {
    window.sessionStorage.setItem("currentVisitorId", visitorId);
  }

  if (oldVisitorId !== currentVisitorId) {
    window.localStorage.setItem("oldVisitorId", currentVisitorId);
  }

  self.pushEvent("visitorIdCreated", visitorId);
};

const fingerprint = {
  mounted() {
    window.addEventListener("phx:readVisitorId", () => {
      readVisitorId();
    });

    window.addEventListener("phx:gererateVisitorId", () => {
      gererateVisitorId();
    });

    self = this;
  },
};

export default fingerprint;
