<p align="center">
  <img src="https://github.com/obscuritylabs/RAI/blob/master/docs/saved0.svg">
</p>

# Rapid Attack Infrastructure (RAI)

**Red Team Infrastructure... Quick... Fast... Simplified** 

One of the most tedious phases of a Red Team Operation is usually the infrastructure setup. This usually entails  
a teamserver or controller, domains, redirectors, and a Phishing server.  Each of these have their own nuances
when it comes to setup, but overall this setup process can take days.  This process just seemed overly complex and time consuming.  There are several issues that come to mind when considering how a painful and time consuming setup can impact a Red Team, but the most important thing to consider is: What if your domain(s) get burned and you need to spin up new infrastructure during the OP?  Now if you're an internal Red Team this may not be an issue, but in the world of Red Team Consulting; time is money and could very well cost you your OP. With a RAI deployment, it can all be done in roughly ~1 hour.  This includes everything from your Teamserver (CobaltStrike), redirectors to Phishing Servers with full DKIM, DMARC, SPF, etc.  

## Some of the major components of this infrastructure include: 
- CobaltStrike
- Docker   
- GoPhish   
- NGINX   
- Postfix    
- IPTables   
- Openssl   

### Core Development:
* Keelyn Roberts [Twitter] @real_slacker007 -- [Web] [ObscurityLabs](http://blog.obscuritylabs.com)
* Alexander Rymdeko-Harvey [Twitter] @Killswitch-GUI -- [Web] [ObscurityLabs](http://blog.obscuritylabs.com)
  
#### Special Thanks:
- Daniel West [Twitter] @reaperb0t -- [Web] [ObscurityLabs](http://blog.obscuritylabs.com)

