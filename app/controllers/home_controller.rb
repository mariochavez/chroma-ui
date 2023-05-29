# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :connected!

  layout "home"

  def index
  end

  def create
    host = params[:host]
    valid = connect_to_host(host)

    return redirect_to collections_path if valid

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

    self.version = ChromaGateway.version
    self.server = host

    true
  rescue
    Chroma.connect_host = nil
    false
  end
end
