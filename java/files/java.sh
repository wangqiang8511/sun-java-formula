{%- from 'java/settings.sls' import java with context %}

export JAVA_HOME={{ java.java_default_home }}
export PATH=$JAVA_HOME/bin:$PATH
