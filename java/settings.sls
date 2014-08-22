{% set p  = salt['pillar.get']('java', {}) %}
{% set g  = salt['grains.get']('java', {}) %}

{% set pa  = salt['pillar.get']('java_alternatives', {}) %}
{% set ga  = salt['grains.get']('java_alternatives', {}) %}


{%- set default_version_name = 'jdk1.7.0_60' %}
{%- set default_prefix       = '/opt/java' %}
{%- set default_source_url   = 'http://s3.amazonaws.com/bigdata-thirdparty/sun-jdk/jdk-7u60-linux-x64.tar.gz' %}
{%- set default_source_hash_url   = 'http://s3.amazonaws.com/bigdata-thirdparty/sun-jdk/jdk-7u60-linux-x64.tar.gz.md5' %}
{%- set default_dl_opts      = '-L' %}

{%- set version_name   = g.get('version_name', p.get('version_name', default_version_name)) %}
{%- set source_url     = g.get('source_url', p.get('source_url', default_source_url)) %}
{%- set source_hash_url     = g.get('source_hash_url', p.get('source_hash_url', default_source_hash_url)) %}
{%- set dl_opts        = g.get('dl_opts', p.get('dl_opts', default_dl_opts)) %}
{%- set prefix         = g.get('prefix', p.get('prefix', default_prefix)) %}
{%- set java_home = prefix + '/' + version_name %}

{%- set java = {} %}
{%- do java.update({ 
    'version_name'   : version_name,
    'source_url'     : source_url,
    'source_hash_url': source_hash_url,
    'dl_opts'        : dl_opts,
    'java_home'      : java_home,
    'java_default_home': prefix + '/default',
    'java_latest_home': prefix + '/latest',
    'prefix'         : prefix,
}) %}

{%- set default_al_java = '/usr/bin/java' %}
{%- set default_al_javac = '/usr/bin/javac' %}
{%- set default_al_javaws = '/usr/bin/javaws' %}
{%- set default_al_jar = '/usr/bin/jar' %}

{%- set al_java = ga.get('java', pa.get('java', default_al_java)) %}
{%- set al_javac = ga.get('javac', pa.get('javac', default_al_javac)) %}
{%- set al_javaws = ga.get('javaws', pa.get('javaws', default_al_javaws)) %}
{%- set al_jar = ga.get('jar', pa.get('jar', default_al_jar)) %}

{%- set java_alternatives = {} %}
{%- do java_alternatives.update({ 
    'java'   : al_java,
    'javac'  : al_javac,
    'javaws' : al_javaws,
    'jar'    : al_jar
}) %}
