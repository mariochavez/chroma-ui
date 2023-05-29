# frozen_string_literal: true

module Application
  class Logo < ApplicationComponent
    include Phlex::Rails::Helpers::TokenList

    def initialize(name: "", css_class: "")
      @css_class = css_class
      @name = name
    end

    def template
      svg(
        xmlns: "http://www.w3.org/2000/svg",
        fill: "none",
        viewbox: "0 0 24 24",
        stroke_width: "1.5",
        stroke: "currentColor",
        class: "h-11 text-skin-accented #{@css_class}"
      ) do |s|
        s.path(
          stroke_linecap: "round",
          stroke_linejoin: "round",
          d:
            "M21 7.5l-2.25-1.313M21 7.5v2.25m0-2.25l-2.25 1.313M3 7.5l2.25-1.313M3 7.5l2.25 1.313M3 7.5v2.25m9 3l2.25-1.313M12 12.75l-2.25-1.313M12 12.75V15m0 6.75l2.25-1.313M12 21.75V19.5m0 2.25l-2.25-1.313m0-16.875L12 2.25l2.25 1.313M21 14.25v2.25l-2.25 1.313m-13.5 0L3 16.5v-2.25"
        )
      end
      span(class: "pl-3 text-skin-accented uppercase font-semibold leading-6 tracking-wider") { @name }
    end
  end
end