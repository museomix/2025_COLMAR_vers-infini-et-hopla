{ lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: initial: {
      alsa-utils = initial.alsa-utils.override {
        withPipewireLib = false;
      };
      ffmpeg = initial.ffmpeg-headless.override {
        ffmpegVariant = "headless";
        buildFfplay = false;
        withAlsa = true;
        withSdl2 = false;
        withAmf = false;
        withAom = false;
        withAss = false;
        withBluray = false;
        withCudaLLVM = false;
        withCuvid = false;
        withDav1d = false;
        withDrm = false;
        withNvcodec = false;
        withFontconfig = false;
        withFreetype = false;
        withFribidi = false;
        withGmp = false;
        withGnutls = false;
        withHarfbuzz = false;
        withIconv = false;
        withMp3lame = false;
        withOpenapv = false;
        withOpencl = false;
        withOpenjpeg = false;
        withRist = false;
        withSpeex = false;
        withSrt = false;
        withSsh = false;
        withSvtav1 = false;
        withTheora = false;
        withV4l2 = false;
        withVidStab = false;
        withX264 = false;
        withX265 = false;
        withHtmlDoc = false;
        withManPages = false;
        withPodDoc = false;
        withTxtDoc = false;
        withNetwork = false;
      };
    })
  ];

  systemd.services."loop-the-music" = {
    description = "Loop the music";
    after = [
      "sound.target"
    ];
    wantedBy = [
      "multi-user.target"
    ];
    script = ''
      ${pkgs.alsa-utils}/bin/amixer set PCM 100%
      ${pkgs.ffmpeg.bin}/bin/ffmpeg -re -stream_loop -1 -i ${../sounds/sound.flac} -f alsa hw:0,0
    '';
    serviceConfig = {
      Restart = "always";
      RestartSec = "1";
    };
  };

  # hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.wireless-regdb ];

  programs.htop.enable = true;

  networking.useNetworkd = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    startWhenNeeded = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  console.useXkbConfig = true;
  services.xserver = {
    xkb.layout = "fr";
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoBEnt0UE86CL8VMzXukzpAgG4Qk0Sx9DBOv4BnVIIy alarsan68"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMnUlaku3VnrDbhErcWNdc5HlAKeW4MD1xGwNqv1gAy8AAAABHNzaDo= Yubikey 5CN Cles"
    ];
  };

  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="FR"
    '';
  };

  users.mutableUsers = false;

  networking.wireless = {
    enable = true;
    userControlled = {
      enable = true;
    };
    secretsFile = "/wireless_secrets";
    networks = {
      "WIFI_MUSEEJO" = {
        pskRaw = "ext:musee";
      };
      "Spruce-Frame" = {
        pskRaw = "ext:spruce-frame";
      };
    };
  };

  networking.interfaces."wlan0" = {
    ipv4.addresses = [
      {
        address = "10.42.0.2";
        prefixLength = 24;
      }
    ];
    ipv4.routes = [
      {
        address = "0.0.0.0";
        prefixLength = 0;
        via = "10.42.0.1";
      }
    ];
  };

  users.users.root.password = "toor";
  system.stateVersion = "25.11";
  boot.initrd.systemd.enable = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllHardware = false;

  services.pipewire.enable = false;
  services.pulseaudio.enable = false;
  hardware.alsa.enable = true;

  hardware.raspberry-pi."4" = {
    # audio.enable = true;
    backlight.enable = false;
    bluetooth.enable = true;
    digi-amp-plus.enable = false;
    dwc2.enable = false;
    gpio.enable = false;
    i2c0.enable = false;
    i2c1.enable = false;
    fkms-3d.enable = false;
    apply-overlays-dtmerge.enable = true;
    poe-hat.enable = false;
    poe-plus-hat.enable = false;
    pwm0.enable = false;
    tc358743.enable = false;
    touch-ft5406.enable = false;
    tv-hat.enable = false;
  };

  # services.mpd = {
  #   enable = true;
  #   musicDirectory = ../sounds;
  #   extraConfig = ''
  #     audio_output {
  #       type "alsa"
  #       name "My ALSA"
  #       mixer_type		"hardware"
  #       mixer_device	"default"
  #       mixer_control	"PCM"
  #     }
  #   '';
  # };
}
