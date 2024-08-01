# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/base'

class App < Sinatra::Base

  before do
    content_type :json
  end

  get '/' do
  
  end

  post '/artifact' do
    unless params[:file] && (tempfile = params[:file][:tempfile]) && (name = params[:file][:filename])
      return "No file uploaded"
    end

    "Received file: #{name}\n"
  end
   
end
