#!/usr/bin/env ruby -rubygems
require 'sinatra'
require 'haml'
require 'youtube-helper.rb'

set :haml, { :format => :html5 }


get "/" do
  haml :index
end

get '/js/:file' do
  File.open(File.dirname(__FILE__) + "/#{params[:file]}") do |f|
    f.read
  end  
end

__END__

@@index
%html
  %head
    %title Youtube Test
    %script{ :src => 'js/swfobject.js' }
    %script{ :src => 'js/youtube-helper.js' }
  %body
    woo

