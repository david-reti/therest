import { Controller } from "@hotwired/stimulus"

const TOGGLE_CLASS_NAME = "hidden"

export default class extends Controller {
    toggle(event) {
        let element_to_toggle = null;
        if(element_to_toggle = document.querySelector(event.target.dataset.totoggle)) {
            if(element_to_toggle.classList.contains(TOGGLE_CLASS_NAME)) 
                element_to_toggle.classList.remove(TOGGLE_CLASS_NAME);
            else 
                element_to_toggle.classList.add(TOGGLE_CLASS_NAME);
        }
    }
}
