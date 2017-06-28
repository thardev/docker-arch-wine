FROM base/archlinux

    # Enable multilib repository
RUN sed -i '/#\[multilib\]/,/#Include = \/etc\/pacman.d\/mirrorlist/ s/#//' /etc/pacman.conf && \
    sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf && \

    # Update pacman repositories
    pacman -Syy --noconfirm && \

    # Install Wine & Winetricks dependencies
    pacman --noconfirm -S \
    gstreamer \
    nano \
    mesa-libgl \
    wget \
    wine-mono \
    wine_gecko \
    wine \
    xorg-server \
    xf86-video-intel && \

    # Install Winetricks from github as it is more recent.
    curl -o winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    install -Dm755 winetricks /usr/bin/winetricks &&  \
    rm winetricks && \

    ##########################################################################
    # CLEAN UP SECTION - THIS GOES AT THE END                                #
    ##########################################################################

    # Remove info, man and docs
    rm -r /usr/share/info/* && \
    rm -r /usr/share/man/* && \
    rm -r /usr/share/doc/* && \

    # Cleanup pacman
    bash -c "echo 'y' | pacman -Scc >/dev/null 2>&1" && \
    paccache -rk0 >/dev/null 2>&1 &&  \
    pacman-optimize && \
    rm -r /var/lib/pacman/sync/*

# Thow in some sample templates (bash scripts)
COPY templates/guildwars.template /home/docker/templates/guildwars.template

USER root

CMD /init
