deploy_bashrc:
  file.managed:
    - name: /etc/profile.d/custom-bash.sh
    - source: salt://prompt/files/custom-bash.sh
    - user: root
    - group: root
    - mode: '0644'
