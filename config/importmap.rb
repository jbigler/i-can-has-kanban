# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.turbo.min.js"
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.8
pin "sortablejs" # @1.15.2
