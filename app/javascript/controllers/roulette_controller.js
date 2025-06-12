import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    const wrapper      = document.getElementById('spinner-wrapper');
    const slots        = Array.from(wrapper.querySelectorAll('.rating-slot'));
    const count        = slots.length;
    const slice        = 360 / count;
    const half         = slice / 2;
    const redirectRoot = "/restaurants/";



      // ▶️ Pick the one slot that actually has a data-id
      const chosen = slots.findIndex(slot => slot.dataset.chosen == "true");
      if (chosen < 0) {
        console.warn("No restaurant slot found with a valid data-id");
        return;
      }

      setTimeout(() => {
        const rotation = 360 * 8 + chosen * slice + half;
        wrapper.style.transform = `rotate(${rotation}deg)`;
        }, 500);

      wrapper.addEventListener('transitionend', function handler() {
        slots.forEach((s, idx) => {
          s.classList.toggle('selected', idx === chosen);
          s.classList.toggle('dimmed',    idx !== chosen);
        });

        setTimeout(() => {
          window.location.href = redirectRoot + slots[chosen].dataset.id;
        }, 2000);

        wrapper.removeEventListener('transitionend', handler);
      });
  }
}
