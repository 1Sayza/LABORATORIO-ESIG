FROM jolokia/java-jolokia:latest AS jolokia
FROM jenkins/jenkins:2.528.3-jdk21

USER root

RUN mkdir -p /opt/jolokia /etc/jolokia && \
    chown -R jenkins:jenkins /opt/jolokia /etc/jolokia

COPY --from=jolokia /opt/jolokia/jolokia.jar /opt/jolokia/jolokia.jar
RUN chown jenkins:jenkins /opt/jolokia/jolokia.jar && chmod 0644 /opt/jolokia/jolokia.jar

COPY jolokia-access.xml /etc/jolokia/jolokia-access.xml
RUN chown jenkins:jenkins /etc/jolokia/jolokia-access.xml && chmod 0640 /etc/jolokia/jolokia-access.xml

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER jenkins

EXPOSE 8080 8778
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

