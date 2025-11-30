#!/bin/bash
# SSH STIG Compliance Validator
# Author: Raul Lopez
# Purpose: Validate SSH configuration against DISA STIG requirements
# Usage: ./validate_ssh_stig.sh
# 
# NO SENSITIVE DATA - Safe for public repositories

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "SSH STIG Compliance Check"
echo "========================="

check_setting() {
    local setting=$1
    local expected=$2
    local actual=$(sudo sshd -T | grep -i "^$setting" | awk '{print $2}')

    # Special case for protocol - modern SSH is v2 only
    if [ "$setting" = "protocol" ] && [ -z "$actual" ]; then
        echo -e "${GREEN}✓${NC} $setting = 2 (implicit - modern SSH)"
        return
    fi

    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}✓${NC} $setting = $expected"
    else
        echo -e "${RED}✗${NC} $setting = $actual (expected: $expected)"
    fi
}

# STIG Checks
check_setting "protocol" "2"
check_setting "permitrootlogin" "no"
check_setting "passwordauthentication" "no"
check_setting "permitemptypasswords" "no"
check_setting "hostbasedauthentication" "no"
check_setting "ignorerhosts" "yes"
check_setting "strictmodes" "yes"
check_setting "maxauthtries" "3"

# Check file permissions
echo ""
echo "File Permission Checks:"
stat -c "%a %n" ~/.ssh | grep -q "700" && echo -e "${GREEN}✓${NC} ~/.ssh is 700" || echo -e "${RED}✗${NC} ~/.ssh permissions incorrect"
stat -c "%a %n" ~/.ssh/authorized_keys 2>/dev/null | grep -q "600" && echo -e "${GREEN}✓${NC} authorized_keys is 600" || echo -e "${RED}✗${NC} authorized_keys permissions incorrect"

# Check if banner exists
if [ -f /etc/ssh/sshd_banner ]; then
    echo -e "${GREEN}✓${NC} SSH banner exists"
else
    echo -e "${RED}✗${NC} SSH banner missing"
fi

# Check fail2ban
if systemctl is-active --quiet fail2ban; then
    echo -e "${GREEN}✓${NC} Fail2ban is running"
else
    echo -e "${RED}✗${NC} Fail2ban is not running"
fi
