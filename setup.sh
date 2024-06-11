#!/bin/bash


# Get policy name from user
read -p "Enter the name of your security policy: " POLICY_NAME

# Create the security policy
gcloud compute security-policies create $POLICY_NAME

# Create rules
gcloud compute security-policies rules create 1000 --security-policy $POLICY_NAME --description "block traffic from 192.0.2.0/24 and 198.51.100.0/24" --src-ip-ranges "192.0.2.0/24","198.51.100.0/24" --action "deny-403" --preview
gcloud compute security-policies rules create 1050 --security-policy $POLICY_NAME --expression "origin.region_code == 'CN'" --action deny-403 --description "China block" --preview
gcloud compute security-policies rules create 25000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('rfi-v33-stable')"  --action deny-403 --description "rfi rules" --preview
gcloud compute security-policies rules create 30000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('sqli-v33-stable')"  --action deny-403 --description "sqli rules" --preview
gcloud compute security-policies rules create 40000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('xss-v33-stable')"  --action deny-403 --description "xss rules" --preview
gcloud compute security-policies rules create 50000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('lfi-v33-stable')"  --action deny-403 --description "lfi rules" --preview
gcloud compute security-policies rules create 60000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredExpr('rce-v33-stable')"  --action deny-403 --description "rce rules" --preview
gcloud compute security-policies rules create 70000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredExpr('methodenforcement-v33-stable')"  --action deny-403 --description "method-enforcement rules" --preview
gcloud compute security-policies rules create 80000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('scannerdetection-v33-stable')"  --action deny-403 --description "scanners" --preview
gcloud compute security-policies rules create 90000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('protocolattack-v33-stable')"  --action deny-403 --description "protocol attack" --preview
gcloud compute security-policies rules create 1000000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('php-v33-stable')"  --action deny-403 --description "php rules" --preview
gcloud compute security-policies rules create 110000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('sessionfixation-v33-stable')"  --action deny-403 --description "session-fixation rules" --preview
gcloud compute security-policies rules create 120000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('java-v33-stable', {'sensitivity': 2})"  --action deny-403 --description "java specific rules" --preview
gcloud compute security-policies rules create 130000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('nodejs-v33-stable')"  --action deny-403 --description "nodejs rules" --preview
gcloud compute security-policies rules create 140000 --security-policy $POLICY_NAMEs --expression "evaluatePreconfiguredExpr('cve-canary')"  --action deny-403 --description "cve rules" --preview
gcloud compute security-policies rules create 150000 --security-policy $POLICY_NAME --expression "evaluatePreconfiguredWaf('json-sqli-canary')"  --action deny-403 --description "json rules" --preview
gcloud compute security-policies rules create 160000 --security-policy $POLICY_NAMEs --src-ip-ranges="*" --rate-limit-threshold-count 100 --rate-limit-threshold-interval-sec 60  --action rate-based-ban --ban-duration-sec 300 --conform-action allow --exceed-action deny-403 --preview
# Success message
echo "Policy $POLICY_NAME was created successfully with the following rules:"
echo "1. Rule 1000: block traffic from 192.0.2.0/24 and 198.51.100.0/24"
echo "2. Rule 1050: China block"
echo "3. Rule 25000: rfi rules"
echo "4. Rule 30000: sqli rules"
echo "5. Rule 40000: xss rules"
echo "6. Rule 50000: lfi rules"
echo "7. Rule 60000: rce rules"
echo "8. Rule 70000: method-enforcement rules"
echo "9. Rule 80000: scanners"
echo "10. Rule 90000: protocol attack"
echo "11. Rule 1000000: php rules"
echo "12. Rule 110000: session-fixation rules"
echo "13. Rule 120000: java specific rules"
echo "14. Rule 130000: nodejs rules"
echo "15. Rule 140000: cve rules"
echo "16. Rule 150000: json rules"
echo "17. Rule 160000: rate limiting"

echo "All rules are created in preview modes. This is just a place for you to start. Customize the rules as per your application."
