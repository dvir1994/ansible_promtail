Ansible Playbook for Provisioning of a Bare Metal Server with Promtail, users and nginx.

## 📋 Verifications

- ✅ Ansible-lint
- ✅ Idempotent code, playbook can be run multiple times
- ✅ Include tags in Playbooks for readability and troubleshooting
- ✅ SSH login with devops user
- ✅ `bob` permissions (sudo reboot with no password prompt)
- ✅ Password of `devops` user is taken from vault and applied to user
- ✅ nginx logs are ingested and shown in Loki instance
- ✅ UFW incoming and outgoing rules
- ✅ Basic security enhancements
- ✅ `makefile` commands work as expected

Tested on:

- Ubuntu 24.04
- Ansible 2.17.3
- Python 3.10.9
- Hetzner and AWS instances

## 🔎 Scope

The playbook sets up the following:

1. Nginx:
   - Installs and configures Nginx
   - Using custom HTML file

2. Log Management:
   - Installs and configures Promtail for log collection
   - Forwards Nginx logs to a specified Loki instance

3. User Management:
   - Creates a `devops` user with sudo privileges and SSH key authentication
   - Creates a non-privileged `bob` user with specific sudo permissions for rebooting the system

4. Security Enhancements:
   - Sets up UFW firewall to allow HTTP (80) and SSH (22) traffic
   - Setup basic security enhancements (fail2ban, chkrootkit, auditd, etc.)

## 📜 Requirements

- Ansible installed on the local system
- Ubuntu 24.04 target system with Python >3.10 installed
- SSH access to the target system
- Sufficient permissions to perform system changes
- Loki instance

## 🚀 Quick Start

```bash
### 1. Install Ansible dependencies
make install-dependencies

### 2. Ansible vault setup
make create-vault
# Once inside the editor, add the following sensitive variables
  # 1. Password of the user used to run the playbook (if exists)
  # vault_sudo_user_password: ""
  # 2. Setting a password for the devops user
  # vault_user_management_devops_user_password: "reb122uL3STE2rEn5T6aC73aN"

### 3. Running the playbook
# vi inventory.yml - Update IP of target host and connection SSH key
# vi group_vars/all/all.yml - Update SSH key, and Loki URL
make run
```

## 📦 Artifacts

- Ansible playbook
  - Code is adhering to standards and syntax checks performed using `ansible-lint`
  - Preference to run using built in modules
  - Role structure
    - `log_management` - log management
    - `user_management` - user management
    - `nginx` - Nginx setup and configuration
    - `firewall` - UFW setup and configuration
    - `security` - Basic security enhancements
  - Variable management
    - Sensitive data stored in an Ansible Vault
    - Global variables used at `group_vars/all/all.yml`
    - Role-specific variables in `roles/<role_name>/defaults/main.yml`
  - Configuration management
    - Using templates for config files (Jinja2)
    - Templates stored at `roles/<role_name>/templates/`
  - Makefile for running the playbook
    - `make install-dependencies` - Install Ansible dependencies (community.general)"
    - `make lint` - Lint Ansible playbooks and roles (ansible-lint required)"
    - `make create-vault` - Creating Ansible vault"
    - `make run` - Run the Ansible playbook"
    - `make edit-vault` - Edit the created Ansible vault"

## 🔐 Security Considerations

- SSH key-based authentication
- Firewall configuration (UFW)
- Principle of least privilege for user 'bob'
- Basic security enhancements (fail2ban, chkrootkit, auditd, etc.)
- Run promtail using a non-root dedicated app user

## 🪄 Suggestions

- Implement logging and monitoring beyond the basic setup
- Add integration with NameCheap DNS API for dynamic DNS updates (for Nginx SSL setup)
- Implement SELinux for enhanced security
- Send Slack update notification - for start and end of the playbook with status
