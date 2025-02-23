;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (gnu home services)
             (gnu home services guix)
             (gnu home services shells)
             (guix gexp)
             (guix channels))

(home-environment
  (packages (map specification->package
                 '("labwc" "rofi"
                   "ghostty"
                   "guile-lsp-server"
                   "kitty"
                   "helix@23.10"
                   "git"
                   "openssh"
                   "zig"
                   "acpi"
                   "bat"
                   "cloc"
                   "gcc-toolchain"
                   "ungoogled-chromium-wayland"
                   "grim"
                   "slurp")))

  (services
   (append (list (service home-fish-service-type)
                 (service home-xdg-configuration-files-service-type
                          `( ;helix
                             ("helix/config.toml" ,(local-file
                                                    "./helix-config.toml"))
                            ("helix/languages.toml" ,(local-file
                                                      "./helix-languages.toml"))
                            ;; labwc
                            ("labwc/autostart" ,(local-file "labwc/autostart"))
                            ("labwc/environment" ,(local-file
                                                   "labwc/environment"))
                            ("labwc/menu.xml" ,(local-file "labwc/menu.xml"))
                            ("labwc/rc.xml" ,(local-file "labwc/rc.xml"))
                            ("labwc/shutdown" ,(local-file "labwc/shutdown"))
                            ("labwc/themerc" ,(local-file "labwc/themerc"))
                            ;; ghostty
                            ("ghostty/config" ,(local-file "ghostty-config"))
                            ;; rofi
                            ("rofi/config.rasi" ,(local-file
                                                  "rofi-config.rasi"))))
                 (service home-channels-service-type
                          (append (list (channel
                                          (name 'saayix)
                                          (url
                                           "https://codeberg.org/look/saayix")
                                          (branch "entropy"))
                                        (channel
                                          (name 'nonguix)
                                          (url
                                           "https://gitlab.com/nonguix/nonguix")))
                                  %default-channels))) %base-home-services)))
