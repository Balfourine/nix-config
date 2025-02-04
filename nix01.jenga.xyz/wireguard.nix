{ config, lib, pkgs, ... }:

{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.firewall.allowedUDPPortRanges = [
    { from = 51820; to = 51820; }
  ];

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/16" ];

      # The port that Wireguard listens to. Must be accessible by the client.
      listenPort = 51820;

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/etc/wireguard.privkey";

      peers = [
        { # Squiz MBA
          publicKey = "zCc5xpI0ul94qOjiOoHdn1VHEUBnTCfljdjLNoeoFTs=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }
        { # Squiz iPhone
          publicKey = "41p3cS/BvnaecDDJhOUfucbiXaMmil5ks2X22xJXlG4=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.3/32" ];
        }
        { # Thinkpad
          publicKey = "dIJ1EYTiyRbT5TJQ+5wi04uyFOjvoti09wrNYmwmBUI=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.4/32" ];
        }
      ];
    };
  };
}
