# frozen_string_literal: true

module Application
  class MobileBar < ApplicationComponent
    def initialize(controller_name:)
      @controller_name = controller_name
    end

    def template
      div(class: "sticky top-0 z-40 flex items-center gap-x-6 bg-white px-4 py-4 shadow-sm sm:px-6 lg:hidden") do
        button(type: "button", class: "-m-2.5 p-2.5 text-skin-muted lg:hidden", data_action: "sidebar#toggleSidebar") do
          span(class: "sr-only") { "Open sidebar" }
          svg(class: "h-6 w-6", fill: "none", viewbox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", aria_hidden: "true") do |s|
            s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5")
          end
        end
        div(class: "flex-1 text-sm font-semibold leading-6 text-skin-base") { t("menu.#{@controller_name}") }
        div
      end
    end
  end
end
