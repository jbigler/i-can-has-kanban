import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    type: String,
    group: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    })
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    var newIndex = event.newIndex
    var sortableListId = event.to.dataset.sortableListId
    var itemType = event.to.dataset.sortableTypeValue
    console.log(event.to.dataset)
    console.log(sortableUpdateUrl)
    console.log(newIndex)
    console.log(sortableListId)
    patch(sortableUpdateUrl, {
      body: JSON.stringify({ [itemType]: { row_order_position: newIndex, list_id: sortableListId } }), responseKind: "json"
    })
  }
}
