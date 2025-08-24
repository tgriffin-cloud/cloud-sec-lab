# Cloud Security Lab


This repository is a hands-on portfolio that demonstrates practical  
cloud security engineering.  

The current focus is AWS, with expansion planned for GCP.  
Each project includes evidence files, Terraform code, and validation  
outputs that prove security controls were implemented and tested.  

Key themes include:  
- Identity and Access Management (IAM) with MFA enforcement  
- Least-privilege access and role assumption (verified with AWS STS)  
- Compliance and monitoring with CloudTrail, Config, and Security Hub  
- Automation with Terraform for secure infrastructure

## Projects Roadmap
- **Project 1: IAM Security Auditor Role with MFA Enforcement** — **Completed**
- Enforced MFA at the AssumeRole boundary with AWS managed policies: `SecurityAudit` and `ReadOnlyAccess`
- Configured `SecurityAuditors` group and validated membership
- Verified role assumption with AWS STS + MFA
- Captured CloudTrail and denial evidence

  **Evidence (click to open files):**
  - [Trust policy](./evidence/00-trust-policy.json)  
  - [Role description](./evidence/01-get-role.json)  
  - [Attached policies](./evidence/02-role-policies.json)  
  - [SecurityAuditors group membership](./evidence/03-get-group.json)  
  - [Caller identity (assumed)](./evidence/04-caller-identity-assumed.json)  
  - [Read-only `list-users`](./evidence/05-readonly-list-users.json)  
  - [Denied S3 write attempt](./evidence/06-negative-write-test.txt)  
  - [CloudTrail AssumeRole event (pretty)](./evidence/07-cloudtrail-assumerole_pretty.json)  
  - [AssumeRole without MFA (denied)](./evidence/08-assumerole-no-mfa-denied.txt)  
  - [AssumeRole with MFA (sanitized)](./evidence/09-assumerole-with-mfa-sanitized.json)  


### **Project 2: Terraform Remote State Hardening — Planned**
- Secure S3 bucket and DynamoDB table for Terraform state management

### **Project 3: Incident Response Automation (Lambda + CloudWatch) — Planned**
- Automate alerts and remediation for suspicious IAM and S3 activity

### **Project 4: Compliance as Code (Terraform Guardrails) — Planned**
- Enforce baseline security controls using Terraform policies

### **Project 5: Multi-Cloud Security (AWS + GCP) — Planned**
- Replicate IAM and compliance patterns across GCP environments

### **Project 6: Monitoring Dashboards (Config + Security Hub) — Planned**
- Build compliance and threat monitoring dashboards

## Scope
- Identity and Access Management (IAM) with least-privilege design  
- Secure infrastructure automation with Terraform (IaC)  
- Data protection and incident response workflows  
- Compliance as code and monitoring dashboards  

## Tools
- AWS: IAM, STS, S3, DynamoDB, CloudTrail  
- Terraform for infrastructure as code  
- GitHub for version control and documentation  

## Contact
- Location: Remote (United States)  
- GitHub: [tgriffin-cloud](https://github.com/tgriffin-cloud)  
