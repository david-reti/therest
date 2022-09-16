import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        let opened = false;
        this.element.onclick = event => {
            if(!opened) {
                event.target.classList.add("options-menu--open")
            } else {
                event.target.classList.remove("options-menu--open")
            }
            opened = !opened;
        }
    }
}