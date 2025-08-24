# Cloud Security Lab

This Cloud Security Lab is where I explore practical security engineering in the cloud.  
It focuses on IAM governance, automation with Terraform, and hands-on security practices.  
The initial work is in AWS, with a design that can expand into multi-cloud environments.

## Projects Roadmap
- **Project 1: IAM Security Auditor Role with MFA Enforcement** — **Completed**
  - MFA-enforced role with AWS managed policies: `SecurityAudit` and `ReadOnlyAccess`
  - Configured SecurityAuditors group and added membership
  - Validated role assumption with AWS STS + MFA
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

- **Project 2: Terraform Remote State Hardening** — *Planned*  
- **Project 3: Incident Response Automation (Lambda + CloudWatch)** — *Planned*  
- **Project 4: Compliance as Code (Terraform guardrails)** — *Planned*  
- **Project 5: Multi-Cloud Security (AWS + GCP)** — *Planned*  
- **Project 6: Monitoring Dashboards (Config + Security Hub)** — *Planned*  

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
