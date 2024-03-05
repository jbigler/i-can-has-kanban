import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"

import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    type: String,
    group: String
  }

  connect() {
    var role = document.getElementById("lists_frame").dataset.role
    if (role !== "viewer") {
      this.sortable = Sortable.create(this.element, {
        onEnd: this.onEnd.bind(this),
        group: this.groupValue,
        draggable: ".draggable"
      })
    }
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    var newIndex = event.newIndex
    var sortableListId = event.to.dataset.sortableListId
    var itemType = event.to.dataset.sortableTypeValue

    patch(sortableUpdateUrl, {
      body: JSON.stringify({ [itemType]: { row_order_position: newIndex, list_id: sortableListId } })
    })
  }
}
