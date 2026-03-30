# Technology Watch Report - MediLink Infrastructure

> **Jedha Bootcamp 2025 - Final Project**
> Author : Eddy GASSAB
> Last update : J5 - March 30, 2026

---

## Network Segmentation using VLANs and pfSense

---

## 1. Introduction

In enterprise networks, segmentation is a key mechanism used to improve security, control traffic, and organise infrastructure.

In the MediLink project, network segmentation is implemented using VLANs combined with a pfSense firewall. This approach allows the isolation of network zones, limits unauthorised access, and reduces the impact of potential security incidents.

---

## 2. Technical Foundations of VLAN Segmentation

VLANs are based on the **IEEE 802.1Q** standard, which allows multiple logical networks to coexist on the same physical infrastructure through frame tagging.

- **Access ports** - assigned to a single VLAN
- **Trunk ports** - carry multiple VLANs between devices
- **VLAN ID (VID)** - logical identifier of each network segment

---

## 3. Architecture Overview

| VLAN ID | Name | Function | Trust Level |
|---------|------|----------|-------------|
| VLAN 10 | Admin IT | Jumpbox, Passbolt | High |
| VLAN 20 | Servers | AD, File server, Backup | High |
| VLAN 30 | Internal WiFi | Medical staff | Medium |
| VLAN 40 | Administrative | HR, Accounting | Medium |
| VLAN 50 | DMZ | Nginx, MySQL | Restricted |
| VLAN 60 | Guest WiFi | Patients - internet only | Low |
| VLAN 70 | Monitoring | Wazuh SIEM, Zabbix | High |

---

## 4. pfSense Role and Integration

pfSense acts as the central Layer 3 component, connected via trunk link IEEE 802.1Q. It enables routing between VLANs, firewall rules per VLAN, and traffic inspection.

---

## 5. Security Benefits

- Reduction of attack surface
- Limitation of lateral movement
- Fine-grained traffic control
- Protection of critical systems

---

## 6. Alignment with Security Best Practices

- IEEE 802.1Q for VLAN segmentation
- Least privilege access between segments
- Defence in depth strategy
- Zero Trust approach

---

## 7. Conclusion

VLAN-based segmentation combined with pfSense is a core component of the MediLink infrastructure, significantly improving resilience and security.

---

*MediLink - Fictional Medical Practice - Jedha Bootcamp 2025*