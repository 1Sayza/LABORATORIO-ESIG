#!/usr/bin/env bash
set -euo pipefail

JOLOKIA_AGENT_OPTS="port=8778,host=0.0.0.0,agentContext=/jolokia,\
restrictorClass=org.jolokia.restrictor.policy.PolicyRestrictor,\
policyLocation=file:/etc/jolokia/jolokia-access.xml"

# Se tiver usuário/senha, habilita basic auth
if [[ -n "${JOLOKIA_USER:-}" && -n "${JOLOKIA_PASSWORD:-}" ]]; then
  JOLOKIA_AGENT_OPTS="${JOLOKIA_AGENT_OPTS},authMode=basic,user=${JOLOKIA_USER},password=${JOLOKIA_PASSWORD}"
fi

# Adiciona no JENKINS_JAVA_OPTS (não sobrescreve)
export JENKINS_JAVA_OPTS="${JENKINS_JAVA_OPTS:-} -javaagent:/opt/jolokia/jolokia.jar=${JOLOKIA_AGENT_OPTS}"

exec /usr/local/bin/jenkins.sh

