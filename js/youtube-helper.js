__yt = {};

function _yt_init_player(player_opts) {
  __yt.player_opts = player_opts;
}

function _yt_init_first_video(video_id) { 
  __yt.first_video = video_id;
}

function _yt_init_state_callback(callback) {
  __yt.state_callback = callback;
}
window.onload = function() { 
  swfobject.embedSWF(
    __yt.player_opts.swfUrlStr,
    __yt.player_opts.replaceElemIdStr,
    __yt.player_opts.widthStr,
    __yt.player_opts.heightStr,
    __yt.player_opts.swfVersionStr,
    __yt.player_opts.xiSwfUrlStr,
    __yt.player_opts.flashvarsObj,
    __yt.player_opts.parObj,
    __yt.player_opts.attObj
  )
}


function onYouTubePlayerReady() {
  __yt.player = document.getElementById(__yt.player_opts.attObj.id);
  if(__yt.player) {
    if(__yt.first_video) {
      __yt.player.cueVideoById(__yt.first_video);
    }
    if(__yt.state_callback) {
      __yt.player.addEventListener("onStateChange",__yt.state_callback);
    }
  }
   
}

function yt_play() { 
  if(__yt.player) {
    __yt.player.playVideo();
  }
}

function yt_pause() {
  if(__yt.player) {
    __yt.player.pauseVideo();
  }
}


function yt_get_player() {
  return __yt.player;
}
