#!/usr/bin/env ruby -rubygems
require 'sinatra'
require 'haml'
require 'youtube-helper.rb'

set :haml, { :format => :html5 }


get "/" do
  haml :index
end

get '/chromeless' do
  haml :chromeless
end

get '/chromefull' do
  haml :chromefull
end

get '/js/:file' do
  File.open(File.dirname(__FILE__) + "/#{params[:file]}") do |f|
    f.read
  end  
end

__END__

@@chromefull
%html
  %head
    %title Youtube Test: Chromefull
    %script{ :src => 'js/swfobject.js' }
    %script{ :src => 'js/youtube-helper.js' }
  %body
    = yt_player(:video_id => '6sxXgj--s9M')
    = yt_register_state_callback("testCallback");
    %script
      function testCallback(state) { alert("State is: " + state); }

@@chromeless
%html
  %head
    %title Youtube Test: Chromeless
    %script{ :src => 'js/swfobject.js' }
    %script{ :src => 'js/youtube-helper.js' }
  %body
    = yt_player(:chromeless, :video_id => '6sxXgj--s9M')
    = yt_play_btn
    = yt_pause_btn
    = yt_register_state_callback("testCallback");
    %script
      function testCallback(state) { alert("State is: " + state); }

@@index
%html
  %head
    %title Youtube Test
  %body
    %a{ :href => '/chromefull'} chromefull
    %br
    %a{ :href => '/chromeless'} chromeless

