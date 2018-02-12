# Rapid Attack Infrastructure using Docker Containers

Work Conducted by:
----------------------------------------------
* Keelyn Roberts [Twitter] @real_slacker007 -- [Web] [ObscurityLabs](http://blog.obscuritylabs.com)

Red Team Infrastructure... Quick... Fast... Simplified 

One of the most tedious phases of a Red Team Operation is usually the infrastructure setup.  This usually entails  
a teamserver or controller, domains, redirectors, and a Phishing server.  Each of these have their own nuances
when it comes to setup but overall, this setup process can take days.  This just seemed overly complex and time consuming.  
There are several issues that come to mind when considering how a painful and time consuming setup can impact a Red Team, but the most important thing to consider is: What if your domain(s) get burned and you need to spin up new infrastructure during the OP?  Now if you're an internal Red Team this may not be an issue, but in the world of Red Team Consulting; time is money. With an RAI deployment, it can all be done in and ~1 hour.  This includes everything from redirectors to Phishing Servers with full DKIM, DMARC, SPF, etc.  

## Some of the major components of this infrastructure include: 
-Docker    
-GoPhish   
-NGINX   
-Postfix    
-IPTables    
-Openssl   

## **Each Section has its own Readme with Usage instruction**
  
**MAJOR CALLOUTS:**
- @killswitch-gui
- @reaperb0t

