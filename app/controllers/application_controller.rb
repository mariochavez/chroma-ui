# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def connected!
    disconnect! if !connected? && controller_name != "home"
  end

  def disconnect!
    self.server = nil
    self.version = nil

    redirect_to root_path
  end

  def connected?
    if server.present?
      _, error = ChromaGateway.heartbeat

      return error.blank?
    end

    false
  end

  def server=(value)
    session[:server] = value
  end

  def server
    @server ||= session[:server]
  end

  def version=(value)
    session[:version] = value
  end

  def version
    @version ||= session[:version]
  end

  helper_method :server, :version

  def escape_name(name)
    CGI.escape(name.tr(".", " "))
  end

  def unescape_name(name)
    CGI.unescape(name)&.gsub(" ", ".")
  end
end
