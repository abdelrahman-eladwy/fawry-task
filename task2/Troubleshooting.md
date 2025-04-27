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
    
    Network/Routing Issues:
    
    Firewall blocking: Either on client, network, or server blocking port 80/443
    Routing problems: Incorrect routing tables between client and server
 
    
    Server Issues:
    
    Web server not running: Apache/Nginx/etc. service stopped
    Web server misconfiguration: Virtual host not properly configured

4. Propose and Apply Fixes
   1-For DNS Server Issues:
    Issue: Internal DNS server malfunction
   
    Confirm root cause:
    ![image](https://github.com/user-attachments/assets/b68f8d5b-7ac8-4e93-a249-607e7df46f3b)

   Fix:
   ![image](https://github.com/user-attachments/assets/aca4fd2e-d14a-41ab-9088-15fd8903f09d)

Issue: DNS cache issues
  # Check if different clients have same issue
  # Check time-to-live (TTL) in DNS records
  ![image](https://github.com/user-attachments/assets/6daf2a09-c172-42c6-aca0-e2d3febc7021)

  Fix:
  # Flush DNS cache
  ![image](https://github.com/user-attachments/assets/54ae493c-7d23-42a1-b8d7-d1428cb59074)

2-For Network/Routing Issues:
  Issue: Firewall blocking
  
  Confirm root cause:
  # Check local firewall
  ![image](https://github.com/user-attachments/assets/fd35d7a9-ffac-470a-b941-8201035f9751)
  
  Fix:
  # Allow HTTP/HTTPS through firewall
  ![image](https://github.com/user-attachments/assets/28deecf3-3649-49fc-9055-b137a9f513a8)

  Issue: Routing problems

  Confirm root cause:
  # Check route to the server
  ![image](https://github.com/user-attachments/assets/a8d731af-5ca9-4f23-80dc-51d11a502725)

  # Check routing table
  ![image](https://github.com/user-attachments/assets/32a9f6ff-2e0f-4640-a36f-b0da438401de)

  Fix:
  # Add a static route if needed
  ![image](https://github.com/user-attachments/assets/e43e68be-e0af-4153-b47e-c99f7d0f2458)

  For Server Issues:
  Issue: Web server not running
  
  Confirm root cause:
  # Check service status
  ![image](https://github.com/user-attachments/assets/83736a2a-8565-4df7-9050-aed29a6b9f79)

  # Check logs
  ![image](https://github.com/user-attachments/assets/22bb4edb-4451-4170-bacb-51ebfd64fe0f)
  
Fix:
  # Start the web service
  ![image](https://github.com/user-attachments/assets/94c64834-61e0-44ed-9e9f-ff19bbe64ed0)

  # Enable to start at boot
  ![image](https://github.com/user-attachments/assets/c85faa12-bf8a-48ae-a760-7c64618fad9f)
  
Issue: Web server misconfiguration
  
  Confirm root cause:
  # Check web server configuration
  ![image](https://github.com/user-attachments/assets/7648c215-078c-4405-84ea-0fb31aa782fc)
  
  # Check virtual hosts
  ![image](https://github.com/user-attachments/assets/740e1986-0e2c-4e80-9714-30e48e238267)

Fix:
  # Edit virtual host configuration
  ![image](https://github.com/user-attachments/assets/7cfcf662-212c-4f1f-a887-6021a723df3a)

  # Enable site if needed
  ![image](https://github.com/user-attachments/assets/a8dab7b0-7c85-41fa-851f-808c127d5df3)

  # Reload service
  ![image](https://github.com/user-attachments/assets/aef235b1-f651-455c-bd9f-432dd8fb9394)

5. Bonus - Local hosts Entry and Persistent DNS Configuration
  Add local hosts entry to bypass DNS:
  # Edit hosts file
  ![image](https://github.com/user-attachments/assets/13e2f7a1-bdd4-4cb1-9910-598cd54fb8e2)
  
  # Add entry
  ![image](https://github.com/user-attachments/assets/bfc5af40-192c-4f88-be31-e876823d8be4)
  
  # Verify it works
  ![image](https://github.com/user-attachments/assets/59bdaf83-d604-47d9-9ce3-d1be15bdb404)

Configure persistent DNS settings:
  Using systemd-resolved:
  # Create or edit the configuration
  ![image](https://github.com/user-attachments/assets/6a6a3027-1e1e-4730-8d18-c7db69d8f57a)

  # Add DNS servers
  ![image](https://github.com/user-attachments/assets/70cd9531-17ba-46f4-a546-12bff5a0d092)

  # Restart service
  ![image](https://github.com/user-attachments/assets/ef0c1969-fba5-4978-bd5a-30a0c18ff97d)













