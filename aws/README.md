

## Attack Server Layout

1) rai-attack-http 
   * Installed Implant Servers - `/opt/implant/`
     * Empire - https://github.com/PowerShellEmpire/Empire
     * Meterpreter - https://www.metasploit.com/
     * Cobalt Strike - https://www.cobaltstrike.com/
     * Pupy - https://github.com/n1nj4sec/pupy
     * Throwback - https://github.com/silentbreaksec/Throwback
   * Installed Servers
     * ningx - Used for potential payload hosting if needed
     * neo4j - Used for Bloodhound ingested data
   * Network Tools under - `/opt/network/`
   * Web Tools under - `/opt/web/`
     * nikto - 
     * WPscan - 
     * sqlmap -
   * Tools Installed under - `/opt/tools/`
     * https://github.com/bluscreenofjeff/Malleable-C2-Randomizer.git 
     * https://github.com/bluscreenofjeff/AggressorScripts.git
     * https://github.com/bluscreenofjeff/MalleableC2Profiles.git
     * https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki.git
     * https://github.com/EmpireProject/Empire.git
     * https://github.com/killswitch-GUI/CobaltStrike-ToolKit.git
     * https://github.com/adaptivethreat/Bloodhound
   * Installed Security Packages `/opt/security`
     * libpam-pwquality - enforce password complexity requirements
     * unattended-upgrades - default install to support security patches etc.
   * Installed Monitoring `/opt/monitor`
     * Auditd
     * NetworkBeat
     * LogBeat

1) rai-attack-https
2) rai-attack-dns