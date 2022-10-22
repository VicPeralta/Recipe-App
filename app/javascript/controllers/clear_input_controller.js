import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-input"
export default class extends Controller {
  static targets = ["inputQty"];
  connect() {
    console.log("connected");
  }

  clear() {
   this.inputQtyTarget.value=''; 
  }
}
