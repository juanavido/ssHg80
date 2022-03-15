FROM alpine

ARG url

RUN apk add openssh curl


RUN adduser -D -s /bin/ash hg80 && \
    passwd -u hg80 && \
    ssh-keygen -A && \
    mkdir /home/hg80/.ssh && \
    chown -R hg80:hg80 /home/hg80

RUN curl -s "$url" -o url.file && \
	tar czf url.filee.tgz ./url.file && \
	rm url.file

COPY authorized_keys /home/hg80/.ssh/authorized_keys

RUN chown -R hg80:hg80 /home/hg80/.ssh && \
    chmod 600 /home/hg80/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

