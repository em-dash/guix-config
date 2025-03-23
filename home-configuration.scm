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
                '("gcc-toolchain"
                  "labwc"
                  "ghostty"
                  "wl-clipboard"
                  "librewolf"
                  "xset"
                  "brightnessctl"
                  "emacs"
                  "emacs-meow"
                  "emacs-magit"
                  "emacs-which-key"
                  "emacs-undo-tree"
                  "emacs-zig-mode"
                  "emacs-vterm"
                  "emacs-geiser"
                  "emacs-geiser-guile"
                  "emacs-rainbow-delimiters"
                  "emacs-zenburn-theme"
                  "guile-lsp-server"
                  "kanshi"
                  "waybar"
                  "mako"
                  "swayidle"
                  "swaybg"
                  "kitty"
                  "helix"
                  "git"
                  "openssh"
                  "rofi"
                  "font-google-noto"
                  "font-google-noto-emoji"
                  "font-google-noto-sans-cjk"
                  "font-recursive"
                  "font-awesome"
                  "zig@0.14.0"
                  ;; "zig-zls@0.14.0"
                  "acpi"
                  "bat"
                  "cloc"
                  "gcc-toolchain"
                  "grim"
                  "slurp")))

 (services
  (append
   (list
    (service home-fish-service-type
             (home-fish-configuration
              (config
               (list (plain-file
                      "extra-config.fish"
                      "\
abbr -a la ls -lA
abbr -a ll ls -lAh
abbr -a lsl ls -lAh | bat --style=plain

alias quit='exit'

function mkcd -a target
    mkdir -p $target
    cd $target
end

function fish_greeting
    echo (set_color brblack)~(set_color normal)bienvenue à (set_color -b brmagenta)(set_color -i black)$hostname(set_color normal)(set_color brblack)~(set_color normal)
    echo
    echo (set_color -i)c'est (date), ou (date +%s) après l'époque
    echo
    echo bonne chasse
end")))
              (environment-variables
               '(("GITHUBMAIL" . "33614480+em-dash@users.noreply.github.com")))))
    (service home-files-service-type
             `((".xsession" ,(local-file "xsession"))))
    (service home-xdg-configuration-files-service-type
             `( ;helix
               ("helix/config.toml" ,(local-file "./helix-config.toml"))
               ("helix/languages.toml" ,(local-file "./helix-languages.toml"))
               ;; labwc
               ("labwc/autostart" ,(local-file "labwc/autostart"))
               ("labwc/environment" ,(local-file "labwc/environment"))
               ("labwc/menu.xml" ,(local-file "labwc/menu.xml"))
               ("labwc/rc.xml" ,(local-file "labwc/rc.xml"))
               ("labwc/shutdown" ,(local-file "labwc/shutdown"))
               ("labwc/themerc" ,(local-file "labwc/themerc"))
               ;; ghostty
               ("ghostty/config" ,(local-file "ghostty-config"))
               ;; rofi
               ("rofi/config.rasi" ,(local-file "rofi-config.rasi"))
               ;; waybar
               ("waybar/config.jsonc" ,(local-file "waybar-config.jsonc"))
               ("waybar/style.css" ,(local-file "waybar-style.css"))))
    (service home-channels-service-type
             (append (list
                      (channel
                       (name 'saayix)
                       (url "https://codeberg.org/look/saayix")
                       (branch "entropy")
                       (introduction
                        (make-channel-introduction
                         "12540f593092e9a177eb8a974a57bb4892327752"
                         (openpgp-fingerprint
                          "3FFA 7335 973E 0A49 47FC  0A8C 38D5 96BE 07D3 34AB"))))
                      (channel
                       (name 'nonguix)
                       (url "https://gitlab.com/nonguix/nonguix")
                       (introduction
                        (make-channel-introduction
                         "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                         (openpgp-fingerprint
                          "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))
                     %default-channels)))
   %base-home-services)))
