require 'json'

def yt_player(*args)
  mode,opts = *args

  # If mode is a hash, then assuming default for the first argument
  if mode.is_a? Hash
    mode,opts = :default, mode
  end

  player_opts = gen_player_opts(opts)
 
  player_opts[:swfUrlStr] = case mode
    when :default:    "http://www.youtube.com/v/#{opts[:video_id]}?enablejsapi=1"
    when :chromeless: "http://www.youtube.com/apiplayer?enablejsapi=1"
    else raise NotImplementedError, mode.to_s
  end

  <<-END_OF_HTML
  <div id="#{player_opts[:replaceElemIdStr]}">
      You need Flash player 8+ and JavaScript enabled to view this video.
  </div>
  <script type="text/javascript">
  <!--
    _yt_init_player(#{player_opts.to_json});
    #{ "_yt_init_first_video('#{opts[:video_id]}');" if mode == :chromeless and opts[:video_id]}
  -->
  </script>
  END_OF_HTML
end

def yt_play_btn(tag = "Play", opts = {})

  <<-END_OF_HTML
    <span class="#{opts[:class]}" onclick="yt_play()">#{tag}</span>
  END_OF_HTML
end

def yt_pause_btn(tag = "Pause", opts = {})

  <<-END_OF_HTML
    <span class="#{opts[:class]}" onclick="yt_pause()">#{tag}</span>
  END_OF_HTML
end

def yt_register_state_callback(function) 

  <<-END_OF_HTML
    <script type="text/javascript">
      _yt_init_state_callback("#{function}");
    </script>
  END_OF_HTML
end

private
def gen_player_opts(opts)
  { 
    :swfUrlStr        => nil, #Filled in later
    :replaceElemIdStr => opts[:id]         || "__yt_player__",
    :widthStr         => opts[:width]      || "425",
    :heightStr        => opts[:height]     || "356",
    :swfVersionStr    => opts[:version]    || "8",
    :xiSwfUrlStr      => opts[:xi_url]     || nil,
    :flashVarsObj     => opts[:flash_vars] || nil,
    :parObj           => { :allowScriptAccess => "always" },
    :attObj           => { :id => "__yt_flash_player__" }
  }
end 
