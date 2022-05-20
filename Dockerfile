FROM archlinux

RUN pacman -Sy sudo --noconfirm
RUN echo "ALL ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd -ms /bin/bash tester  && \
    usermod -aG wheel tester      && \
    groupadd docker               && \
    gpasswd -a tester docker
USER tester

WORKDIR /home/tester/Singularis/

COPY . .

CMD ["/usr/bin/bash"]
