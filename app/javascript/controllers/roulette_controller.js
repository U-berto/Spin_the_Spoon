import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const wrapper      = document.getElementById('spinner-wrapper');
    const slots        = Array.from(wrapper.querySelectorAll('.rating-slot'));
    const btn          = document.getElementById('spin-btn');
    const count        = slots.length;
    const slice        = 360 / count;
    const half         = slice / 2;
    const redirectRoot = "/restaurants/";

    btn.addEventListener('click', () => {
      // ▶️ Pick the one slot that actually has a data-id
      const chosen = slots.findIndex(slot => slot.dataset.id && slot.dataset.id.trim());
      if (chosen < 0) {
        console.warn("No restaurant slot found with a valid data-id");
        return;
      }

      const rotation = 360 * 5 + chosen * slice + half;
      btn.disabled   = true;
      wrapper.style.transform = `rotate(${rotation}deg)`;

      wrapper.addEventListener('transitionend', function handler() {
        slots.forEach((s, idx) => {
          s.classList.toggle('selected', idx === chosen);
          s.classList.toggle('dimmed',    idx !== chosen);
        });

        setTimeout(() => {
          window.location.href = redirectRoot + slots[chosen].dataset.id;
        }, 500);

        wrapper.removeEventListener('transitionend', handler);
      });
    });
  }
}
