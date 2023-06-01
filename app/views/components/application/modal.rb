# frozen_string_literal: true

module Application
  class Modal < ApplicationComponent
    include Phlex::Rails::Helpers::TurboFrameTag

    def template
      div(class: "hidden relative z-50", aria_labelledby: "modal-title", role: "dialog", aria_modal: "true", data: {"modal-target": "container"}) do
        div(
          class: "hidden fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity modal-backdrop",
          data_controller: "backdrop",
          data_backdrop_target: "backdrop",
          data_transition_enter_active: "transition-opacity ease-linear duration-200",
          data_transition_enter_from: "opacity-0",
          data_transition_enter_to: "opacity-100",
          data_transition_leave_active: "transition-opacity ease-linear duration-200",
          data_transition_leave_from: "opacity-100",
          data_transition_leave_to: "opacity-0"
        )
        div(class: "fixed inset-0 z-10 overflow-y-auto") do
          div(
            class: "hidden flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0",
            data_modal_target: "modal",
            data_transition_enter_active: "ease-out duration-300",
            data_transition_enter_from: "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
            data_transition_enter_to: "opacity-100 translate-y-0 sm:scale-100",
            data_transition_leave_active: "ease-in duration-200",
            data_transition_leave_from: "opacity-100 translate-y-0 sm:scale-100",
            data_transition_leave_to: "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
          ) do
            div(class: "relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6") do
              div(class: "absolute right-0 top-0 hidden pr-4 pt-4 sm:block") do
                button(type: "button", class: "rounded-md bg-white text-skin-dimmed hover:text-skin-muted focus:outline-none focus:ring-2 focus:ring-skin-accented focus:ring-offset-2", data: {action: "modal#close"}) do
                  span(class: "sr-only") { "Close" }
                  svg(class: "h-6 w-6", fill: "none", viewbox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", aria_hidden: "true") do |s|
                    s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
                  end
                end
              end
              div do
                turbo_frame_tag(:modal_content, src: "", data: {"modal-target": "frame"}, class: "sm:flex sm:items-start") do
                end
              end
              div(class: "mt-5 sm:mt-4 sm:flex sm:flex-row-reverse") do
                button(type: "button", class: "button button-accented inline-flex w-full justify-center sm:ml-3 sm:w-auto", data: {action: "modal#submit", "modal-target": "submit"}) { "" }
                button(type: "button", class: "button mt-3 inline-flex w-full justify-center sm:mt-0 sm:w-auto", data: {action: "modal#close"}) { "Cancel" }
              end
            end
          end
        end
      end
    end
  end
end
