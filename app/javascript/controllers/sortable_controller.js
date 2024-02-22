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
      group: this.groupValue,
      draggable: ".draggable"
    })
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    var newIndex = event.newIndex
    var sortableListId = event.to.dataset.sortableListId
    var itemType = event.to.dataset.sortableTypeValue

    // Check if the dragged item was moved to the last position
    const isLastPosition = newIndex === this.sortable.toArray().length - 1

    if (isLastPosition && itemType === "list") {
      // Cancel the drop and revert the item to its original position
      event.from.insertBefore(event.item, event.from.children[event.oldIndex])
    } else {
      // Update the database
      patch(sortableUpdateUrl, {
        body: JSON.stringify({ [itemType]: { row_order_position: newIndex, list_id: sortableListId } }), responseKind: "json"
      })
    }
  }
}
