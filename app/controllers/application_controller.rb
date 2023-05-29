# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def connected!
    redirect_to root_path if !connected? && controller_name != "home"
  end

  def disconnect!
    self.server = nil
    self.version = nil

    redirect_to root_path
  end

  def connected?
    server.present?
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
end
