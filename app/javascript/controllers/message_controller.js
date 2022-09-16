import { Controller } from "@hotwired/stimulus"
import anime from "animejs"

export default class extends Controller {
  connect() {
    setTimeout(() => {
        anime({
            targets: this.element,
            translateY: -100,
            duration: 800,
            complete: () => {
                this.element.remove()
            }
        })
    }, 750)
  }
}