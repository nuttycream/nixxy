{...}: {
  personal.home_modules = [
    ({pkgs, ...}: {
      home.packages = with pkgs; [
        #ffmpeg-full
        yt-dlp
        mpv
        vlc
      ];
    })
  ];
}
