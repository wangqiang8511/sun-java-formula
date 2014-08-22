{%- from 'java/settings.sls' import java with context %}
{%- from 'java/settings.sls' import java_alternatives with context %}

# require a source_url - there is no default download location for a jdk
{%- if java.source_url is defined %}

java_folder:
  file.directory:
    - name: {{ java.prefix }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

install_jdk:
  archive:
    - extracted
    - name: {{ java.prefix }}
    - source: {{ java.source_url }}
    - source_hash: {{ java.source_hash_url }}
    - archive_format: tar
    - if_missing: {{ java.java_home }}
    - require:
      - file: java_folder
  alternatives.install:
    - name: java
    - link: {{ java_alternatives.java }}
    - path: {{ java.java_home }}/bin/java
    - priority: 30

default_symlink:
  file.symlink:
    - name: {{ java.java_default_home }}
    - target: {{ java.java_home }}
    - require:
      - alternatives: install_jdk

latest_symlink:
  file.symlink:
    - name: {{ java.java_latest_home }}
    - target: {{ java.java_home }}
    - require:
      - alternatives: install_jdk

jdk_config:
  file.append:
    - name: /etc/bashrc
    - source: salt://java/files/java.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - require:
      - alternatives: install_jdk

jdk_alternatives:
  alternatives.set:
    - name: java
    - path: {{ java.java_home }}/bin/java
    - require:
      - alternatives: install_jdk
{%- endif %}
