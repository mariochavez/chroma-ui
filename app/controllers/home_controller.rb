# frozen_string_literal: true

class HomeController < ApplicationController
  layout "home"

  def index
  end

  def create
    host = params[:host]
    valid = connect_to_host(host)

    return redirect_to(collections_path, notice: t("flash.home.create.notice", server_host: host)) if valid

    respond_to do |format|
      format.turbo_stream do
        response.status = :unprocessable_entity
        render turbo_stream: turbo_stream.replace(:connect_form, Home::ConnectForm.new(server, valid))
      end
    end
  end

  def destroy
    disconnect!
  end

  private

  def connect_to_host(host)
    return false if host.blank?

    ChromaGateway.configure(host)
    version, error = ChromaGateway.version

    if error.blank?
      self.version =  version
      self.server = host
    end

    error.blank?
  end
end
