export const toggleAccordion = {
  mounted() {
    window.addEventListener("phx:toggleAccordion", (event) => {
      const buttonId = event.detail.id
      const button = document.querySelector(buttonId)
      const accordion = button.closest('.accordion')
      accordion.classList.toggle('active')
    });
  }
}