# Docker Setup

{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      # Navidrome
      navidrome = {
        image = "deluan/navidrome:latest";
        user = "1000:1000";
        ports = [ "127.0.0.1:4533:4533" ];
        volumes = [
          "/mnt/sda1/music:/music:ro"
          "/mnt/sda1/navidrome:/data"
        ];
        environment = {
          ND_LOGLEVEL = "info";
          ND_SCANINTERVAL = "1h";
          ND_MUSICFOLDER = "/music";
        };
      };

      # Nicotine+
      nicotine-plus = {
        image = "ghcr.io/fletchto99/nicotine-plus-docker:latest";
        extraOptions = [ "--security-opt" "seccomp=unconfined" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Asia/Kolkata";
          PASSWORD = "sidpid098";
        };
        volumes = [
          "/mnt/sda1/nicotineplus:/config"
          "/mnt/sda1/music:/data/downloads"
          "/mnt/sda1/music:/data/incomplete_downloads"
        ];
        ports = [
          "127.0.0.1:6080:6080"
          "127.0.0.1:2234-2239:2234-2239"
        ];
      };

      # Sonarr
      sonarr = {
        image = "linuxserver/sonarr:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Asia/Kolkata";
        };
        volumes = [
          "/mnt/sda1/sonarr/config:/config"
          "/mnt/sda1/plex/media:/media"
          # "/mnt/sda1/downloads:/downloads"
        ];
        extraOptions = [ "--network=host" ];
      };

      # Radarr
      radarr = {
        image = "linuxserver/radarr:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Asia/Kolkata";
        };
        volumes = [
          "/mnt/sda1/radarr/config:/config"
          "/mnt/sda1/plex/media:/media"
          "/mnt/sda1/downloads:/downloads"
        ];
        extraOptions = [ "--network=host" ];
      };

      # Prowlarr
      prowlarr = {
        image = "linuxserver/prowlarr:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Asia/Kolkata";
        };
        volumes = [
          "/mnt/sda1/prowlarr/config:/config"
        ];
        extraOptions = [ "--network=host" ];
      };

      # qBittorrent (Docker)
      qbittorrent-docker = {
        image = "ghcr.io/hotio/qbittorrent:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          UMASK = "002";
          TZ = "Asia/Kolkata";
          WEBUI_PORTS = "8080/tcp,8080/udp";
        };
        volumes = [
          "/mnt/sda1/qbittorrent/config:/config"
          "/mnt/sda1/downloads:/downloads"
        ];
        ports = [ "127.0.0.1:8080:8080" ];
      };

      # Plex
      plex = {
        image = "plexinc/pms-docker:latest";
        environment = {
          TZ = "Asia/Kolkata";
          PLEX_CLAIM = "claim-jcxynZtWeZJamYzU8kFy";
          ADVERTISE_IP = "http://192.168.1.184:32400/";
        };
        volumes = [
          "/mnt/sda1/plex/config:/config"
          "/mnt/sda1/plex/media:/data"
        ];
        extraOptions = [ "--network=host" ];
      };
    };
  };
}
