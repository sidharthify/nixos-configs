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
          ND_LASTFM_ENABLED = "true";
          ND_LASTFM_APIKEY = builtins.readFile "/etc/nixos-secrets/secrets/lastfm_api";
          ND_LASTFM_SECRET = builtins.readFile "/etc/nixos-secrets/secrets/lastfm_secret";
          ND_BASEURL = "https://music.sidharthify.me";
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
          PASSWORD = builtins.readFile "/etc/nixos-secrets/secrets/nicotine_password";
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
          #ADVERTISE_IP = "http://192.168.1.184:32400/";
        };
        volumes = [
          "/mnt/sda1/plex/config:/config"
          "/mnt/sda1/media:/media:ro"
        ];
        extraOptions = [ "--network=host" ];
      };

      # MySQL for Monica
      monica-mysql = {
        image = "mysql:5.7";
        environment = {
          MYSQL_RANDOM_ROOT_PASSWORD = "true";
          MYSQL_DATABASE = "monica";
          MYSQL_USER = "homestead";
          MYSQL_PASSWORD = "secret";
        };
        volumes = [
          "/mnt/sda1/monica/mysql:/var/lib/mysql"
        ];
        extraOptions = [ "--network=monica-network" ];
      };

      # Monica CRM
      monica = {
        image = "monica";
        environment = {
          DB_HOST = "monica-mysql";
          DB_DATABASE = "monica";
          DB_USERNAME = "homestead";
          DB_PASSWORD = "secret";
        };
        ports = [ "8081:80" ];
        volumes = [
          "/mnt/sda1/monica/storage:/var/www/html/storage"
        ];
        extraOptions = [ "--network=monica-network" ];
      };
    };
  };

    systemd.services.init-monica-network = {
    description = "Create monica-network";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.runtimeShell} -c '${pkgs.docker}/bin/docker network inspect monica-network >/dev/null 2>&1 || ${pkgs.docker}/bin/docker network create monica-network'";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
