# frozen_string_literal: true

# Arquivo de configuração para servidores Rack (Puma, Unicorn, etc.)
require './app'

run Sinatra::Application
