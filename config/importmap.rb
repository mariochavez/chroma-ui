# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.1
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "stimulus-use" # @0.52.0
pin "hotkeys-js" # @3.10.2

pin_all_from "app/javascript/controllers", under: "controllers"
