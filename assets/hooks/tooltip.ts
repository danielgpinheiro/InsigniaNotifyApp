import tippy from "tippy.js";

const tooltip = {
  mounted() {
    window.addEventListener("phx:initializeTooltip", () => {
      tippy("[data-tippy-content]");
    });
  },
};

export default tooltip;
