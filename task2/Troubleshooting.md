Let's systematically work through the troubleshooting process:
1. Verify DNS Resolution:
  1.1 # Check the system's DNS configuration
   -cat /etc/resolv.conf
   
   1.2# Query using system's DNS servers
   ![image](https://github.com/user-attachments/assets/3fb0899e-a915-4588-b519-faf514b882b7)

   1.3 # Query using Google's DNS (8.8.8.8)
   ![image](https://github.com/user-attachments/assets/84c533a4-5636-415b-ad3e-2741d4cc5549)
   
  -Possible outcomes:
   Both resolve to the same IP → DNS is consistent
   Different IPs → DNS inconsistency between internal and external servers
   No resolution with internal DNS but resolves with external → Internal DNS issue
   No resolution with either → Domain might not be in any DNS or complete network issue
   
2. Diagnose Service Reachability
   2.1 ## Check if we can reach the server using ping (ICMP)
   ![image](https://github.com/user-attachments/assets/81b1715b-d790-4c5b-b268-e5d9c99c6f2d)

   2.2 ## If ping doesn't work, try with the IP directly
   ![image](https://github.com/user-attachments/assets/89f8447c-0a20-4e44-8a84-3b4702406364)

   2.3 ## Check if the web port is open using netcat
   ![image](https://github.com/user-attachments/assets/0df0ffd9-63e3-4a04-a056-790fec3de932)

   2.4 ## Try to establish an HTTP connection
   ![image](https://github.com/user-attachments/assets/9cd0516a-12e8-4c59-b097-74570ca0ba2a)

3. Trace the Issue - All Possible Causes
DNS Issues:

Internal DNS server malfunction: DNS service stopped or crashed
DNS cache issues: Stale records in local or DNS server cache
DNS zone file problems: Missing or incorrect zone entry
Split-horizon DNS misconfiguration: Internal DNS records not properly maintained
DNS propagation delay: Recent changes not yet propagated

Network/Routing Issues:

Firewall blocking: Either on client, network, or server blocking port 80/443
Routing problems: Incorrect routing tables between client and server
VPN/Network segmentation issues: Clients might need to be on specific network
Server IP changed: Service running on a different IP than DNS indicates
NIC issues: Network interface on server down or misconfigured

Server Issues:

Web server not running: Apache/Nginx/etc. service stopped
Server overloaded: Unable to accept new connections
SSL/TLS certificate issues: For HTTPS connections
Web server misconfiguration: Virtual host not properly configured
Host down or rebooting: Server completely offline

