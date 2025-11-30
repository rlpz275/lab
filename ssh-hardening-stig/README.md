# SSH Hardening - DISA STIG Implementation

[![Security](https://img.shields.io/badge/Security-STIG%20Compliant-green)](https://www.stigviewer.com/)
[![Platform](https://img.shields.io/badge/Platform-RHEL%2FAlmaLinux-red)](https://almalinux.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

Production-ready SSH hardening implementation following Defense Information Systems Agency (DISA) Security Technical Implementation Guide (STIG) requirements for Red Hat Enterprise Linux 8.

This project demonstrates:
- **Security**: Multi-layered defense-in-depth approach
- **Compliance**: Automated STIG validation and reporting
- **Automation**: Infrastructure-as-Code security implementation
- **Monitoring**: Real-time security event detection

## Features

### 🔐 Security Controls
- RSA 4096-bit public key authentication
- FIPS 140-2 validated cryptography
- Fail2ban intrusion prevention system
- Network-based access control via firewalld
- Automated brute-force protection

### 📋 Compliance
- DISA RHEL 8 STIG V1R14 compliant
- NIST 800-53 control mappings
- Automated compliance validation
- Color-coded compliance reporting

### 🔧 Automation
- One-script deployment
- Automated testing suite
- Configuration templates
- Rollback capabilities

## Quick Start
```bash
# Clone repository
git clone https://github.com/yourusername/ssh-hardening-stig
cd ssh-hardening-stig

# Review and customize settings
cp configs/sshd_config.template /tmp/sshd_config.review
vim /tmp/sshd_config.review

# Run compliance check
./scripts/validate_ssh_stig.sh

# Monitor SSH access
./scripts/monitor_ssh.sh
```

## STIG Controls Implemented

| STIG ID | Control | Implementation |
|---------|---------|----------------|
| V-230244 | SSH Protocol 2 | `Protocol 2` (implicit in OpenSSH 7.4+) |
| V-230288 | Disable Root Login | `PermitRootLogin no` |
| V-230380 | Public Key Auth | `PubkeyAuthentication yes` |
| V-230296 | No Host-Based Auth | `HostbasedAuthentication no` |
| V-230301 | Audit Logging | `LogLevel VERBOSE` |
| V-230226 | Warning Banner | `/etc/ssh/sshd_banner` |

[Full STIG mapping documentation](docs/STIG_MAPPING.md)

## Architecture
```
┌─────────────────┐     ┌──────────────┐     ┌─────────────┐
│   SSH Client    │────▶│   Firewalld  │────▶│  SSH Daemon │
└─────────────────┘     └──────────────┘     └─────────────┘
                               │                      │
                               ▼                      ▼
                        ┌──────────────┐       ┌──────────┐
                        │   Fail2ban   │       │  Auditd  │
                        └──────────────┘       └──────────┘
```

## Testing
```bash
# Run compliance tests
./tests/test_compliance.sh

# Validate STIG compliance
./scripts/validate_ssh_stig.sh
```

## Screenshots

![Compliance Check](images/compliance_check.png)

## Technologies Used

- **Operating System**: AlmaLinux 8 / RHEL 8
- **Security Tools**: OpenSSH 8.x, Fail2ban, firewalld
- **Automation**: Bash scripting
- **Standards**: DISA STIGs, NIST 800-53, FIPS 140-2

## Author

Raul Lopez
- LinkedIn: (https://www.linkedin.com/in/raullopez01/)
- Focus: DevSecOps, Cloud Security, Infrastructure Automation

## License

MIT License - See [LICENSE](LICENSE) file for details

## Disclaimer

These configurations are provided as examples. Always test in a non-production environment and adjust settings based on your specific security requirements.
