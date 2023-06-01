# frozen_string_literal: true

module Collections
  class IndexEmpty < ApplicationComponent
    include Phlex::Rails::Helpers::LinkTo

    def template
      div(class: "bg-white") do
        div(class: "px-6 py-24 sm:px-6 sm:py-32 lg:px-8") do
          div(class: "mx-auto max-w-2xl text-center") do
            svg(
              xmlns: "http://www.w3.org/2000/svg",
              class: "h-20 w-20 shrink-0 text-skin-accented mx-auto mb-4",
              fill: "none",
              viewbox: "0 0 24 24",
              stroke_width: "1.5",
              stroke: "currentColor"
            ) do |s|
              s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d: t("menu.icons.collections")
              )
            end
            h2(
              class:
                "text-3xl font-bold tracking-tight text-skin-base sm:text-4xl"
            ) { t(".empty.title") }
            p(class: "mx-auto mt-6 max-w-xl text-lg leading-8 text-skin-muted") do
              t(".empty.description")
            end
            div(class: "mt-10 flex items-center justify-center gap-x-6") do
              link_to t(".actions.create"),
                new_collection_path,
                class: "button button-accented",
                data: {
                  action: "modal#open",
                  "submit-label": "Create collection"
                }
              a(
                href: "https://docs.trychroma.com/usage-guide#using-collections",
                target: "_blank",
                class: "button"
              ) do
                t(".actions.learn_more")
                span(aria_hidden: "true") { "→" }
              end
            end
          end
        end
      end
    end
  end
end
