#
# KVM host
#
{% if salt['pillar.get']('netbox:role:name') %}
{%- set role = salt['pillar.get']('netbox:role:name') %}
{% else %}
{%- set role = salt['pillar.get']('netbox:device_role:name') %}
{% endif %}


{% if 'vmhost' in role %}
virt-pkgs:
  pkg.installed:
    - pkgs:
      - qemu-kvm
      - libvirt-daemon-system
      - libvirt-clients
      - xmlstarlet
      - netcat-openbsd
      - ipmitool
      - lm-sensors

/etc/libvirt/hooks/qemu:
  file.managed:
    - source: salt://kvm/qemu-hook
    - mode: "0755"
    - require:
      - pkg: virt-pkgs
{% endif %}
