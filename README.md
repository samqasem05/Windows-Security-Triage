# Windows Security Triage

PowerShell scripts for practicing Windows endpoint investigation, process analysis, and basic threat hunting.

## Skills Demonstrated

- PowerShell
- Windows endpoint security
- Process triage
- Parent/child process analysis
- Command-line inspection
- TCP connection analysis
- Windows services
- Local account investigation
- Scheduled task inspection
- Basic threat hunting

## Scripts

- `Process-Triage.ps1` - Reviews running processes, executable paths, command lines, and basic suspicious indicators.
- `Suspicious-Process-Ancestry-Hunt.ps1` - Examines parent/child process relationships and suspicious PowerShell or CMD ancestry.
- `MiniThreatHunting.ps1` - Performs lightweight process and network connection investigation.
- `unusual.ps1` - Checks Windows services for executables running from unusual locations.
- `Automated-Hunt-and-Audit.ps1` - Combines several endpoint auditing, account, process, scheduled task, network, and containment checks.
