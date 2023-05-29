# frozen_string_literal: true

module Home
  class ConnectForm < ApplicationComponent
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::LabelTag
    include Phlex::Rails::Helpers::SubmitTag
    include Phlex::Rails::Helpers::TextFieldTag
    include Phlex::Rails::Helpers::TokenList
    include Phlex::Rails::Helpers::TurboFrameTag

    def initialize(host = "", valid = true)
      @valid = valid
      @host = host
    end

    def template
      turbo_frame_tag :connect_form do
        form_with url: connect_path, class: "flex items-baseline gap-x-3", data: {"turbo-frame": "_top"} do |form|
          div(class: "w-full") do
            label_tag :host, t("connect.host"), class: "sr-only"

            text_field_tag :host,
              @host,
              placeholder: t("connect.placeholder.host"),
              maxlength: t("connect.length.host"),
              class: token_list("input", "w-full", "text-lg", {"input-error": !@valid})
            p(class: "help help-error") { t("connect.error") } if !@valid
          end

          submit_tag t("connect.submit"),
            class: "button button-accented text-lg uppercase"
        end
      end
    end
  end
end
