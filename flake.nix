{
  description = "Deep Blood Reactor • Audio Energy Core (Nix desktop app)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        app = pkgs.stdenvNoCC.mkDerivation {
          pname = "blood-reactor";
          version = "1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/share/blood-reactor $out/bin $out/share/applications

            cp index.html $out/share/blood-reactor/

            # Normal window (mic permission button visible)
            makeWrapper ${pkgs.ungoogled-chromium}/bin/chromium $out/bin/blood-reactor \
              --add-flags "--app=file://$out/share/blood-reactor/index.html?embed=1" \
              --add-flags "--ozone-platform=wayland" \
              --add-flags "--enable-features=WebRTCPipeWireCapturer,WaylandWindowDecorations" \
              --add-flags "--disable-frame-rate-limit" \
              --add-flags "--autoplay-policy=no-user-gesture-required"

            # Wallpaper / always-on-bottom mode (kiosk + frameless)
            makeWrapper ${pkgs.ungoogled-chromium}/bin/chromium $out/bin/blood-reactor-wallpaper \
              --add-flags "--app=file://$out/share/blood-reactor/index.html?embed=1" \
              --add-flags "--ozone-platform=wayland" \
              --add-flags "--enable-features=WebRTCPipeWireCapturer" \
              --add-flags "--kiosk" \
              --add-flags "--no-frame-rate-limit"

            # Create desktop file manually to ensure proper structure
            mkdir -p $out/share/applications
            cat > $out/share/applications/blood-reactor.desktop << EOF
[Desktop Entry]
Name=Blood Reactor
Comment=Deep Blood Red Reactive Cylinder Energy Visualizer
Exec=blood-reactor
Icon=audio-x-generic
Terminal=false
Type=Application
Categories=AudioVideo;Graphics;
StartupWMClass=ungoogled-chromium
EOF
          '';

          meta = with pkgs.lib; {
            description = "Reactive blood-red cylinder audio visualizer";
            license = licenses.mit;
            platforms = platforms.linux;
            mainProgram = "blood-reactor";
          };
        };
      in {
        packages.default = app;
      });
}