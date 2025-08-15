{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
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
          "/mnt/sda1/media:/media"
          "/mnt/sda1/data/torrents:/downloads"
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
          "/mnt/sda1/media:/media"
          "/mnt/sda1/data/torrents:/downloads"
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
          "/mnt/sda1/data/torrents:/downloads"
        ];
        ports = [
          "8080:8080"
          "6881:6881"
          "6881:6881/udp"
        ];
      };

      # Plex
      plex = {
        image = "plexinc/pms-docker:latest";
        environment = {
          TZ = "Asia/Kolkata";
          PLEX_CLAIM = "claim-jcxynZtWeZJamYzU8kFy";
          # ADVERTISE_IP = "http://192.168.1.184:32400/";
        };
        volumes = [
          "/mnt/sda1/plex/config:/config"
          "/mnt/sda1/media:/media:ro"
        ];
        extraOptions = [ "--network=host" ];
      };
    };
  };
}
